// megasquirt_serial.cpp
// RP2350 / Pico SDK implementation of Megasquirt "newserial" protocol (wrapper + CRC32 + commands)
// Implements: wrapper parsing (Size BE, payload, CRC32 BE), response formatting (Flag byte), dispatch.
// Adapt the read_table/write_table/get_realtime stubs to your device memory map.
//
// References / spec: Megasquirt Serial Protocol (2014-10-28). Uploaded PDF used for format & commands.
// - wrapper: Size = 16-bit BE (includes all bytes: size bytes + CRC32 bytes). Payload CRC32 is 32-bit BE. :contentReference[oaicite:5]{index=5}
// - commands: 'A', 'r', 'w', 'f', ... (see spec). :contentReference[oaicite:6]{index=6}
// - flags & error codes documented in PDF. :contentReference[oaicite:7]{index=7}

#include <cstdio>
#include <cstring>
#include <cstdint>
// #include <vector>
#include "pico/stdlib.h"
#include "hardware/uart.h"
#include "hardware/irq.h"
#include "hardware/gpio.h"
#include "pico/mutex.h"

// ---------- CONFIG ----------
#define UART_ID uart0
constexpr uint TX_PIN = 0; // set accordingly
constexpr uint RX_PIN = 1; // set accordingly
constexpr uint BAUD = 115200;

constexpr size_t RX_RING_SIZE = 4096;           // must be big enough for expected packets
constexpr uint16_t MIN_HEADER_SIZE = 2 + 1 + 4; // minimal: size(2) + at least 1 payload byte + CRC32(4) ? (depends)
constexpr uint32_t INTER_CHAR_TIMEOUT_MS = 100; // used to resync on long gaps

// Megasquirt Flags (responses)
enum : uint8_t
{
    FLAG_OK = 0x00,
    FLAG_REALTIME = 0x01,
    FLAG_PAGE = 0x02,
    FLAG_CONFIG_ERROR = 0x03,
    FLAG_BURN_OK = 0x04,
    FLAG_PAGE10_OK = 0x05,
    FLAG_CAN_DATA = 0x06
};
// Error codes are >= 0x80 per spec (see PDF). We'll return these when appropriate. :contentReference[oaicite:8]{index=8}

// Custom implementation of std::vector
template <typename T, size_t S = 2048>
class StaticVector
{
    T array[S];
    size_t len;

public:
    const T *data() { return array; }
    size_t size() { return len; }
    void reserve(size_t) {}
    void clear() { len = 0; }
    void push_back(T val)
    {
        if (len >= S)
            return;
        array[len++] = val;
    }
    void insert(const T *val, size_t n)
    {
        memcpy(array + len, val, n);
    }
    void insert(const StaticVector<T> *val)
    {
        memcpy(array + len, val->array, val->len);
    }
    void assign(size_t n, T val)
    {
        memset(array, val, n);
    }
    T &operator[](size_t n)
    {
        return array[n];
    }
    void erase(size_t n)
    {
        len -= n;
        memcpy(array, array + n, len);
    }
};

// ---------- CRC32 (public domain style) ----------
// Polynomial 0xEDB88320 reflected poly (standard CRC32)
// Implements straightforward CRC32 (the PDF references a public domain crc32.c). :contentReference[oaicite:9]{index=9}
static uint32_t crc32_table[256];
static bool crc_table_inited = false;

static void init_crc32_table()
{
    if (crc_table_inited)
        return;
    for (uint32_t i = 0; i < 256; ++i)
    {
        uint32_t crc = i;
        for (int j = 0; j < 8; ++j)
        {
            if (crc & 1)
                crc = (crc >> 1) ^ 0xEDB88320u;
            else
                crc = crc >> 1;
        }
        crc32_table[i] = crc;
    }
    crc_table_inited = true;
}

static uint32_t crc32_compute(const uint8_t *data, size_t len)
{
    init_crc32_table();
    uint32_t crc = 0xFFFFFFFFu;
    for (size_t i = 0; i < len; ++i)
    {
        uint8_t b = data[i];
        crc = (crc >> 8) ^ crc32_table[(crc ^ b) & 0xFFu];
    }
    return crc ^ 0xFFFFFFFFu;
}

// ---------- Helpers: big-endian io ----------
static uint16_t be16(const uint8_t *p) { return (uint16_t(p[0]) << 8) | uint16_t(p[1]); }
static uint32_t be32(const uint8_t *p)
{
    return (uint32_t(p[0]) << 24) | (uint32_t(p[1]) << 16) | (uint32_t(p[2]) << 8) | uint32_t(p[3]);
}
static void write_be16(StaticVector<uint8_t> &v, uint16_t x)
{
    v.push_back((x >> 8) & 0xFF);
    v.push_back(x & 0xFF);
}
static void write_be32(StaticVector<uint8_t> &v, uint32_t x)
{
    v.push_back((x >> 24) & 0xFF);
    v.push_back((x >> 16) & 0xFF);
    v.push_back((x >> 8) & 0xFF);
    v.push_back(x & 0xFF);
}

// ---------- UART / RX ring buffer ----------
static uint8_t rx_ring[RX_RING_SIZE];
static volatile size_t rx_head = 0;
static volatile size_t rx_tail = 0;
static mutex_t rx_mutex;

static absolute_time_t last_rx_time;

// push byte into ring buffer (called from IRQ)
static void rx_push_byte(uint8_t b)
{
    size_t next = (rx_head + 1) % RX_RING_SIZE;
    if (next == rx_tail)
    {
        // overflow: we lose oldest byte (or set an overflow flag)
        // For now, drop oldest
        rx_tail = (rx_tail + 1) % RX_RING_SIZE;
    }
    rx_ring[rx_head] = b;
    rx_head = next;
}

// pop up to max_count bytes into dest; returns actual count
static size_t rx_pop(uint8_t *dest, size_t max_count)
{
    size_t cnt = 0;
    mutex_enter_blocking(&rx_mutex);
    while (rx_tail != rx_head && cnt < max_count)
    {
        dest[cnt++] = rx_ring[rx_tail];
        rx_tail = (rx_tail + 1) % RX_RING_SIZE;
    }
    mutex_exit(&rx_mutex);
    return cnt;
}

// UART IRQ handler
void on_uart_rx()
{
    while (uart_is_readable(UART_ID))
    {
        int c = uart_getc(UART_ID);
        if (c < 0)
            break;
        rx_push_byte((uint8_t)c);
        last_rx_time = get_absolute_time();
    }
    // Clear IRQ (handled by SDK call)
}

// ---------- Send framed response ----------
// Response format: Size(2 BE) Flag(1) Payload(...) CRC32(4 BE).
// Note: Size is 16-bit BE and includes the size bytes and CRC32 bytes (i.e. total packet length).
static bool uart_send_bytes(const uint8_t *data, size_t len)
{
    for (size_t i = 0; i < len; ++i)
    {
        uart_putc_raw(UART_ID, data[i]);
    }
    return true;
}

static void send_response(uint8_t flag, const uint8_t *payload, size_t payload_len)
{
    // Build response payload (Flag + payload)
    StaticVector<uint8_t> body;
    body.reserve(1 + payload_len);
    body.push_back(flag);
    if (payload && payload_len)
        body.insert(payload, payload_len);

    // Compute CRC32 over body (payload for wrapper CRC is "payload bytes", for responses payload includes flag per spec).
    // The PDF describes: Response = Size Flag Payload ... CRC32 (CRC covers Flag+Payload). :contentReference[oaicite:10]{index=10}
    uint32_t crc = crc32_compute(body.data(), body.size());

    // Size field = total bytes including size and CRC according to spec.
    // total_length = size(2) + body + crc(4)
    uint16_t total_len = uint16_t(2 + body.size() + 4);

    StaticVector<uint8_t> frame;
    frame.reserve(total_len);
    write_be16(frame, total_len); // Size (2 bytes BE)
    frame.insert(&body);          // Flag + payload
    write_be32(frame, crc);       // CRC32 BE

    uart_send_bytes(frame.data(), frame.size());
}

// ---------- Protocol dispatch helpers (stubs you must adapt) ----------

// Example: return realtime payload (for 'A' command). The returned bytes must match the ECU's outpc layout.
// Here we return an example small sample; replace with your actual data retrieval.
static StaticVector<uint8_t> get_realtime_payload()
{
    // For demo: return 6 bytes (e.g., RPM U16, seconds U16, dummy U16) in big-endian
    StaticVector<uint8_t> v;
    v.push_back(0x12);
    v.push_back(0x34); // RPM = 0x1234 (4660)
    v.push_back(0x00);
    v.push_back(0x10); // seconds = 16
    v.push_back(0x00);
    v.push_back(0x01); // dummy
    return v;
}

// Example: read table bytes for 'r' command. Implement access to actual in-device tables/flash.
// table: table id; offset: big-endian 16-bit; size: big-endian 16-bit
static bool read_table(uint8_t canid, uint16_t table, uint16_t offset, uint16_t size, StaticVector<uint8_t> &out)
{
    // For example purposes only: produce 'size' bytes of 0xAA
    out.assign(size, 0xAA);
    // Real implementation: validate table/offset/size against allowed ranges and read from memory/flash.
    return true; // true -> success
}

// Example: write table bytes for 'w' command
static bool write_table(uint8_t canid, uint16_t table, uint16_t offset, const uint8_t *data, uint16_t size)
{
    // For demo we just accept the write. Real code must verify and write to RAM or flash as allowed.
    (void)canid;
    (void)table;
    (void)offset;
    (void)data;
    (void)size;
    // On success return true; on error (range/locked) return false and choose appropriate error code to return.
    return true;
}

// Example: f command info (serial version, table blocking factor, write blocking factor)
static void get_f_info(uint8_t canid, StaticVector<uint8_t> &out)
{
    // Response format: Serial version (1 byte?), Table blocking factor (2 bytes?), Write blocking factor (2 bytes?)
    // PDF shows: Size Flag SerialVersion TableBlocking WriteBlocking CRC32
    // The PDF example uses 1 byte serial version (ASCII digits) then two 16-bit BE blocking factors.
    (void)canid;
    // We'll return: serial version = 2 (binary), table block = 2048, write block = 2048 (MS3 typical). Adjust for MS2/3.
    out.clear();
    out.push_back(0x02); // serial version (protocol number 2)
    // table blocking factor (be16)
    out.push_back(0x08);
    out.push_back(0x00); // 2048 -> 0x0800
    out.push_back(0x08);
    out.push_back(0x00); // write blocking factor 2048
}

// ---------- Command dispatcher ----------
// Payload is raw payload bytes as received (no leading size; this routine gets payload only).
// For Request: payload begins with command char (ascii) followed by command-specific fields.
// We must produce a response with Flag + payload (or Flag-only on many write/OK responses).
static void handle_command(const uint8_t *payload, size_t payload_len)
{
    if (payload_len == 0)
    {
        // invalid
        send_response(0x83 /* unrecognised command */, nullptr, 0);
        return;
    }
    char cmd = (char)payload[0];

    switch (cmd)
    {
    case 'A':
    {
        // Request: Size 'A' CRC32 (no extra fields in request)
        // Response: Flag = FLAG_REALTIME (0x01) and realtime data payload. :contentReference[oaicite:11]{index=11}
        auto rt = get_realtime_payload();
        send_response(FLAG_REALTIME, rt.data(), rt.size());
        break;
    }

    case 'f':
    {
        // Request: Size 'f' CANid CRC32  => payload[1] = CANid
        if (payload_len < 2)
        {
            send_response(0x83, nullptr, 0);
            break;
        }
        uint8_t canid = payload[1];
        StaticVector<uint8_t> out;
        get_f_info(canid, out);
        send_response(FLAG_OK, out.data(), out.size()); // The PDF expects serial_version+tableblock+writeblock then CRC. Flag present. :contentReference[oaicite:12]{index=12}
        break;
    }

    case 'r':
    {
        // Request format: 'r' CANid Table(1) Offset(2 BE) Size(2 BE)
        // PDF shows: Size 'r' CANid Table Offset Size CRC32. See spec. :contentReference[oaicite:13]{index=13}
        if (payload_len < 1 + 1 + 1 + 2 + 2)
        { // command + CANid + Table + Offset(2) + Size(2)
            send_response(0x83, nullptr, 0);
            break;
        }
        uint8_t canid = payload[1];
        uint16_t table = payload[2];
        uint16_t offset = be16(&payload[3]);
        uint16_t size = be16(&payload[5]);
        // validate size
        if (size == 0)
        {
            send_response(0x84, nullptr, 0); // Out of range / invalid size
            break;
        }

        StaticVector<uint8_t> data;
        if (!read_table(canid, table, offset, size, data))
        {
            // choose appropriate error code: out of range or flash locked etc.
            send_response(0x84, nullptr, 0);
        }
        else
        {
            send_response(FLAG_PAGE, data.data(), data.size()); // FLAG_PAGE = 0x02 per spec.
        }
        break;
    }

    case 'w':
    {
        // Request: 'w' CANid Table Offset Size Data...
        if (payload_len < 1 + 1 + 1 + 2 + 2)
        {
            send_response(0x83, nullptr, 0);
            break;
        }
        uint8_t canid = payload[1];
        uint16_t table = payload[2];
        uint16_t offset = be16(&payload[3]);
        uint16_t size = be16(&payload[5]);
        if (payload_len < (size_t)(1 + 1 + 1 + 2 + 2 + size))
        {
            send_response(0x80, nullptr, 0); // underrun
            break;
        }
        const uint8_t *data_start = &payload[7];
        if (!write_table(canid, table, offset, data_start, size))
        {
            // flash locked? or out of range?
            send_response(0x86 /* flash locked / or other */, nullptr, 0);
        }
        else
        {
            send_response(FLAG_OK, nullptr, 0); // OK
        }
        break;
    }

    default:
        // Unknown command
        send_response(0x83 /* unrecognised command */, nullptr, 0);
        break;
    }
}

// ---------- Parser: extract wrapper-framed packets from RX ring ----------
static StaticVector<uint8_t> intake_buf; // used when assembling bytes
static void process_incoming_stream()
{
    // read all available bytes into intake_buf
    uint8_t tmp[512];
    size_t n = rx_pop(tmp, sizeof(tmp));
    if (n == 0)
    {
        // also consider inter-character timeout to resync if needed
        return;
    }
    intake_buf.insert(tmp, n);

    // We expect wrapper: Size(2 BE) Payload(...) CRC32(4 BE)
    // Note: Size is the total packet length (including the two size bytes and the four CRC bytes).
    // So minimum total size is 2 + 1 + 4 = 7 (if payload is 1 byte). See spec. :contentReference[oaicite:14]{index=14}

    // Try to parse as many complete packets as possible
    while (true)
    {
        if (intake_buf.size() < 2)
            return; // need size
        uint16_t total_len = be16(&intake_buf[0]);
        if (total_len < 2 + 1 + 4)
        {
            // invalid size -> drop first byte and resync
            intake_buf.erase(1);
            continue;
        }
        if (intake_buf.size() < total_len)
        {
            // need more bytes
            return;
        }
        // We have at least total_len bytes available
        // Extract payload (bytes after size bytes, up to total_len - 6 (flag? depends) but for requests: payload bytes = total_len - 2 - 4
        size_t payload_len = total_len - 2 - 4;
        const uint8_t *payload_ptr = &intake_buf[2];
        // Compute CRC32 over payload bytes
        uint32_t received_crc = be32(&intake_buf[2 + payload_len]);
        uint32_t computed_crc = crc32_compute(payload_ptr, payload_len);
        if (computed_crc != received_crc)
        {
            // CRC failure: respond with error code (on Megasquirt, response flags are used for responses; for request CRC fail
            // host would detect. Here, since this device is implementing the ECU side, we must reply with an error response
            // when a request CRC fails? The spec describes error codes for responses from MS, such as 0x82 CRC failure.
            // We'll send a short response with flag = 0x82 per spec. :contentReference[oaicite:15]{index=15}
            send_response(0x82 /* CRC failure */, nullptr, 0);
            // remove the processed bytes from buffer
            intake_buf.erase(total_len);
            continue;
        }

        // Now we have a valid payload. For requests, payload begins with command char etc.
        // Dispatch command using payload_ptr, payload_len
        handle_command(payload_ptr, payload_len);

        // Remove processed bytes
        intake_buf.erase(total_len);
    }
}

// ---------- Initialization ----------
void protocol_init()
{
    stdio_init_all(); // optional
    mutex_init(&rx_mutex);

    // UART init
    uart_init(UART_ID, BAUD);
    gpio_set_function(TX_PIN, GPIO_FUNC_UART);
    gpio_set_function(RX_PIN, GPIO_FUNC_UART);
    uart_set_hw_flow(UART_ID, false, false);
    uart_set_format(UART_ID, 8, 1, UART_PARITY_NONE);

    // Set up IRQ handler
    // For uart0 use UART0_IRQ
    if (UART_ID == uart0)
    {
        irq_set_exclusive_handler(UART0_IRQ, on_uart_rx);
        irq_set_enabled(UART0_IRQ, true);
    }
    else
    {
        irq_set_exclusive_handler(UART1_IRQ, on_uart_rx);
        irq_set_enabled(UART1_IRQ, true);
    }
    uart_set_irq_enables(UART_ID, true, false);

    last_rx_time = get_absolute_time();

    // initialize CRC table
    init_crc32_table();
}

// ---------- Public poll function to be called from main loop ----------
void protocol_poll()
{
    process_incoming_stream();
}

// ---------- Example main() showing how to use ----------
// Replace / integrate into your project build
#ifdef BUILD_MEGASQUIRT_SERIAL_DEMO
int main()
{
    protocol_init();

    while (true)
    {
        protocol_poll();
        // other app logic ...
        sleep_ms(5);
    }
    return 0;
}
#endif
