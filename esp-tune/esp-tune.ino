#include <WiFi.h>
#include <ESPAsyncWebServer.h>
#include <LittleFS.h>      // use LittleFS instead of SPIFFS

const char* ssid     = "YOUR_WIFI_SSID";
const char* password = "YOUR_WIFI_PASSWORD";

AsyncWebServer server(80);
AsyncWebSocket ws("/ws");

float values[8] = {10,20,30,40,50,60,70,80};
unsigned long lastSend = 0;

// Send JSON with 8 values to all clients
void notifyClients() {
  String json = "{\"v\":[";
  for (int i = 0; i < 8; i++) {
    json += String(values[i],1);
    if (i < 7) json += ",";
  }
  json += "]}";
  ws.textAll(json);
}

void setup() {
  Serial.begin(115200);

  WiFi.begin(ssid, password);
  Serial.print("Connecting");
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("\nWiFi connected! IP: " + WiFi.localIP().toString());

  // --- Mount LittleFS ---
  if (!LittleFS.begin(true)) {
    Serial.println("LittleFS Mount Failed!");
    return;
  }

  // Serve the index page from LittleFS
  server.on("/", HTTP_GET, [](AsyncWebServerRequest *request){
    request->send(LittleFS, "/index.html", "text/html");
  });

  // Optionally serve any other static files (css, js, etc.)
  server.serveStatic("/", LittleFS, "/");

  // WebSocket events
  ws.onEvent([](AsyncWebSocket *s, AsyncWebSocketClient *c,
                AwsEventType t, void *arg, uint8_t *data, size_t len){
    if (t == WS_EVT_CONNECT) {
      Serial.printf("WS client #%u connected\n", c->id());
    }
  });

  server.addHandler(&ws);
  server.begin();
}

void loop() {
  ws.cleanupClients();

  // Simulate sensor data & push every 500 ms
  if (millis() - lastSend > 500) {
    lastSend = millis();
    for (int i = 0; i < 8; i++) {
      values[i] += random(-10,10)*0.1;
      if (values[i] < 0) values[i] = 0;
      if (values[i] > 100) values[i] = 100;
    }
    notifyClients();
  }
}
