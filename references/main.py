#!/usr/bin/env python3

DEG_PER_CYCLE = 0x10000


def deg_to_cycle(deg: float) -> int:
    return round(DEG_PER_CYCLE * (deg % 720) / 720)


class TriggerEvent:
    def __init__(self) -> None:
        self.timestamp: int = 0  # absolute time
        self.angle: int = DEG_PER_CYCLE - 1  # angle relative to previous teeth
        self.index: int = 0  # trigger index
        self.duration: int = 0  # time relative to previous event
        self.pos: int = 0  # absolute angle position

    def deg_to_ticks(self, deg: int) -> int:
        return deg * self.duration // self.angle

    def ticks_to_deg(self, ticks: int) -> int:
        return ticks * self.angle // self.duration

    def get_rpm(self):
        # 60e6 // 32768
        # return 1831 * self.angle // self.duration
        return self.ticks_to_deg(1831)


class Decoder:
    def __init__(self, teeth_count: int, teeth_missing: int) -> None:
        self.teeth_count: int = teeth_count
        self.teeth_missing: int = teeth_missing
        self.trigger_count = self.teeth_count - self.teeth_missing

        self.half_sync = False
        self.full_sync = False

        self.cycle_count = 0  # number of cycles since sync loss
        self.inj_count = 0  # total number of injections

        self.inj_pw = 0  # injection pulse width
        self.inj_angle = 0  # injection angle (closing)
        self.inj_index = 0  # injection event index
        self.inj_delay = 0  # injection delay after event (us)

        self.us_until_trig = 0  # simulated hardware timer

        self.last_event = TriggerEvent()

        self.teeth_angle = [0] * self.trigger_count
        self.teeth_pos = [0] * self.trigger_count

        self.initialize_angle_arrays()

    def initialize_angle_arrays(self):
        d = DEG_PER_CYCLE // self.teeth_count
        m = DEG_PER_CYCLE % self.teeth_count

        s = 0  # running sum
        r = 0  # remainder

        for i in range(self.trigger_count):
            a = d
            r += m
            while r > self.teeth_count:
                a += 1
                r -= self.teeth_count
            self.teeth_angle[i] = a
            self.teeth_pos[i] = s
            s += a

        self.teeth_angle[self.trigger_count - 1] += DEG_PER_CYCLE - s

    def set_pw(self, inj_pw: int):
        self.inj_pw = inj_pw

    def set_inj_angle(self, inj_angle: int):
        # print(f"new angle:{inj_angle}")
        self.inj_angle = inj_angle

    def find_tooth(self, event, angle, dur):
        angle_dur = event.ticks_to_deg(dur)
        angle_start = (angle - angle_dur) % (DEG_PER_CYCLE - 1)

        # find last tooth before injection pulse begins
        result = self.trigger_count - 1
        while angle_start <= self.teeth_pos[result]:
            result -= 1
        angle_diff = (angle_start - self.teeth_pos[result]) % (DEG_PER_CYCLE - 1)
        delay_us = event.deg_to_ticks(angle_diff)

        # make sure diff is large enough
        # e.g. a 60-tooth wheel on the crank at 10'000 rpm
        # gives a delay of 100 us, which should be plenty
        if delay_us < 100:
            if result == 0:
                result = self.trigger_count - 1
            else:
                result -= 1
            angle_diff = (angle_start - self.teeth_pos[result]) % (DEG_PER_CYCLE - 1)
            delay_us = event.deg_to_ticks(angle_diff)

        return (result, delay_us)

    def on_teeth(self, timestamp):
        this_event = TriggerEvent()

        # compute duration
        this_event.timestamp = timestamp
        this_event.duration = timestamp - self.last_event.timestamp

        # update simulated hardware timer
        self.us_until_trig = max(0, self.us_until_trig - this_event.duration)

        if self.full_sync:
            if self.last_event.index >= (self.trigger_count - 1):
                this_event.index = 0

                # test
                if self.inj_count != self.cycle_count:
                    print(
                        f"Missed schedule rpm {self.last_event.get_rpm()} angle {self.inj_angle}"
                    )
                    print(f"  inj_index {self.inj_index} inj_delay {self.inj_delay}")

                # increment total cycle counter
                self.cycle_count += 1
                # print(f"Rotation {self.cycle_count}")
            else:
                this_event.index = self.last_event.index + 1

            this_event.angle = self.teeth_angle[self.last_event.index]
            this_event.pos = self.teeth_pos[this_event.index]

            # print(f"Teeth {this_event.index}")

            new_inj_index, new_inj_delay = self.find_tooth(
                this_event, self.inj_angle, self.inj_pw
            )
            # print(f"{this_event.index} {new_inj_index} {new_inj_delay}")

            # catch rare case where schedule would have been missed
            if (
                self.last_event.index == new_inj_index
                and this_event.index == self.inj_index
            ):
                # print(f"Schedule would have been missed {new_inj_index} {new_inj_delay}")
                new_inj_index = this_event.index
                new_inj_delay -= this_event.duration
                # print(f"New values {new_inj_index} {new_inj_delay}")

            if new_inj_index == this_event.index:
                if self.us_until_trig > 0:
                    pass  # print(f"Schedule updated from {self.us_until_trig} to {new_inj_delay}")
                elif self.inj_count == self.cycle_count:
                    print(
                        f"Double schedule rpm {self.last_event.get_rpm()} angle {self.inj_angle}"
                    )
                    print(f"  inj_index {self.inj_index} inj_delay {self.inj_delay}")
                    print(
                        f"  new_inj_index {new_inj_index} new_inj_delay {new_inj_delay} until {self.us_until_trig}"
                    )
                else:
                    pass  # print(f"Schedule {new_inj_delay} us after teeth {this_event.index}")
                self.inj_count = self.cycle_count
                self.us_until_trig = new_inj_delay  # setup simulated hardware timer

            self.inj_index = new_inj_index
            self.inj_delay = new_inj_delay

        elif self.half_sync:
            if this_event.duration > (self.last_event.duration * 1.5):
                print(f"Full sync")
                self.full_sync = True
                this_event.index = 0
                self.cycle_count += 1

        else:
            print(f"Half sync")
            self.half_sync = True

        self.last_event = this_event


class Sim:
    def __init__(self, decoder) -> None:
        self.us_per_deg = float("inf")
        self.current_tooth = 20
        self.last_teeth = 0
        self.decoder = decoder

    def set_rpm(self, rpm):
        self.us_per_deg = 1e6 / (6 * rpm)

    def update(self):
        gap = None
        if self.current_tooth == (self.decoder.trigger_count - 1):
            gap = (
                self.decoder.teeth_pos[0]
                + DEG_PER_CYCLE
                - self.decoder.teeth_pos[self.current_tooth]
            )
            self.current_tooth = 0
        else:
            gap = (
                self.decoder.teeth_pos[self.current_tooth + 1]
                - self.decoder.teeth_pos[self.current_tooth]
            )
            self.current_tooth += 1
        self.last_teeth += gap * self.us_per_deg * 720 / DEG_PER_CYCLE
        self.decoder.on_teeth(round(self.last_teeth))
        return self.last_teeth


decoder = Decoder(24, 1)
simulation = Sim(decoder)

rpm = 500
pw = 3000
ang = deg_to_cycle(90)

decoder.set_pw(pw)
simulation.set_rpm(rpm)

# prime the simulation
# decoder.set_inj_angle(8737)
# for _ in range (100):
#     simulation.update()
# decoder.set_inj_angle(8738)
# for _ in range (100):
#     simulation.update()
# decoder.set_inj_angle(8739)
# for _ in range (100):
#     simulation.update()
# decoder.set_inj_angle(8740)
# for _ in range (100):
#     simulation.update()
# decoder.set_inj_angle(8739)
# for _ in range (100):
#     simulation.update()
# decoder.set_inj_angle(8738)
# for _ in range (100):
#     simulation.update()

print(1)
while rpm < 8000:
    decoder.set_pw(pw)
    simulation.set_rpm(rpm)
    rpm += 1
    for i in range(50):
        simulation.update()

print(2)
while rpm > 500:
    decoder.set_pw(pw)
    simulation.set_rpm(rpm)
    rpm -= 1
    for i in range(50):
        simulation.update()

# go back up to 3000 rpm, smoothly
print(2.1)
while rpm < 3000:
    decoder.set_pw(pw)
    simulation.set_rpm(rpm)
    rpm += 1
    for i in range(50):
        simulation.update()

# go back down to 1000 us, smoothly
print(2.2)
while pw > 1000:
    decoder.set_pw(pw)
    simulation.set_rpm(rpm)
    pw -= 1
    for i in range(50):
        simulation.update()

print(3)
while pw < 39000:
    decoder.set_pw(pw)
    simulation.set_rpm(rpm)
    pw += 1
    for i in range(50):
        simulation.update()

print(4)
while pw > 1000:
    decoder.set_pw(pw)
    simulation.set_rpm(rpm)
    pw -= 1
    for i in range(50):
        simulation.update()

print(5)
while ang > 0:
    decoder.set_inj_angle(ang)
    ang -= 1
    for i in range(50):
        simulation.update()

print(5.5)
while ang < 0x10000:
    decoder.set_inj_angle(ang)
    ang += 1
    for i in range(50):
        simulation.update()

print(6)
while ang > 0:
    decoder.set_inj_angle(ang)
    ang -= 1
    for i in range(50):
        simulation.update()
