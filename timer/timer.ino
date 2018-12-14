#include <avr/sleep.h>
#include <avr/interrupt.h>

/* A timer program for controlling an AC relay with user input.

Designed for use in a screen printing photo exposure unit.

This program can be used for controlling power to any AC device via a
relay, with the user-controlled parameters being the hold
time. Additionally, there is a lockout facility, and a lockout
override facility. These can be left unwired, if they are unused.

The inputs from the user are the up, down, run/pause buttons, the
lockout contacts, and the lockout override.

The outputs to the system are light relay control line, the displayed
time, and the beeper.

On boot, the lights are off and the readout displays the default
exposure/run time.

On up or down, the system changes the current run time; at one tick,
if pressed and released, and more quickly, if these buttons are held.

On run, the system turns on the lights if the time is nonzero and the
lockout contacts are set, and holds the lights on until the time runs
to zero, the contacts are broken, or the user presses run/pause.

If the contacts are broken or the user hits pause, the count down time
becomes the current run time.  If the user adjusts the time during
pause, the time entered becomes the new set time.

Otherwise, when we hit zero, the current run time is set to what it
was when it ran, after the user hits runpause to acknowledge the timer
count down.

If the user hits up/down while the unit is running, these are ignored.

The time is displayed on a 4x seven-segment common-anode display. Each
digit is serviced during a single run of the display servicing
routine. Power is supplied to the digit by a dedicated control line,
and the segments needed to display a given digit are selected by a
shift register.

The program state is modelled as a set of states; each input or the
passage of time triggers a change in state. A few states exist for
implementation convenience; RUN_INIT prepares the system for timing in
RUN, and so can be entered from a number of states without being
checked at the top of RUN. HOLD_TRANSITION exists to handle an
abstract change from a state A -> B, predicated on a pin being
continually held.
*/

/* Button controls */
#define UP PCINT8		// the up button pin
#define DOWN PCINT9		// the down button pin
#define RUNPAUSE PCINT10	// the run/pause button pin

const int debounced_pins[] = {UP, DOWN, RUNPAUSE};

/* User output controls */
#define LID A3			// pin for wiring the lid contacts
#define LID_OVERRIDE A4		// pin for wiring the lid override contact
#define LTRELAY 5		// pin for turning the lights on
#define PZO 9			// pin for controlling the beeper

/* Display controls */
#define CLK 4			// pin for clocking the 74164
#define DATA 3			// pin for loading the 74164

/* Timer details */
#define DEFAULT_RUN_TIME 5	// the timer value on restart
#define MAX_RUN_TIME 10 * 60	// the maximum amount of time that can be set

/* Button details */
#define PRESS_CHECK_INTERVAL 1  // milliseconds in between button checks, at minimum
#define OBSERVATION_THRESHOLD 3 // number of consecutive button observations before a new button state is accepted (debouncing)

#define SLOW_INCR 1		// how much the timer changes on one up/down press
#define FAST_INCR 10		// how much the timer changes on a held up/down press
#define FAST_HOLD_MS 1000	// how long up or down needs to be held before we transition to a fast change
#define START_HOLD 750          // how long we need to hold down the start button before start
#define FAST_BLIP_MS 200	// how long between incr/decr blips on a held press

/* User output signals details */
#define BEEP_PITCH 2093	       // the beep frequency
#define LIGHT_ON_PITCH 880     // beep frequency when the lights are coming on
#define LIGHT_OFF_PITCH 440    // when the lights are coming off
#define PANIC_PITCH 1569       // when the door is opened before 0
#define ZERO_PWM 240

#define SHORTBEEP 50		// beep lengths
#define LONGBEEP 1000
#define PANICBEEP 5000
#define ZEROEPOCH 1000

/* useful constants */
const uint8_t CLK_LOW = ~(1 << CLK);
const uint8_t CLK_HIGH = (1 << CLK);

const uint8_t DATA_LOW = ~(1 << DATA);
const uint8_t DATA_HIGH = (1 << DATA);

/* 7-segment display constants */
const int digit_selector_lines[] = {10, 13, 12, 11}; // lines to digit index table
const uint8_t digit_codes[] = {0xAF, 0xA0, 0xCE, 0xEA, 0xE1, 0x6B, 0x6F, 0xA2, 0xEF, 0xE3}; // digit to code table
const uint8_t dot_mask = (1 << 4); // mask for setting the "dot" segment (middle two digits)

/* Timer state */
int set_run_time;		// the default run time, or the last time set by the user
int run_time;                	// the time that the timer needs to count; used for storing the time left when we pause
int display_time = 0; 		// the time written out to the display
unsigned long start_run_time;   // millisecond mark of when we started

/* Program finite state machine */
enum states {
  AWAIT, // waiting for user input
  HOLD_TRANSITION, // template state for waiting for a button to be held, or falling back to another state
  UP_PRESS, // state for single button press, UP
  UP_HOLD,  // state for held button press, UP
  DOWN_PRESS,
  DOWN_HOLD,
  RUN_INIT,       // state for setting up a run of the timer
  RUN_FROM_PAUSE, // state for returning to a timer run
  RUN,   // running
  PAUSE, // pausing
  ZERO,  // timer complete
  PANIC}; // lid lifted

// the current state
states state;

/* Button observation counts */
// debouncing data
int button_counts[8];    // historical state of the buttons, in count of observations
uint8_t monitor_mask; 	 // mask of pins that we are monitoring/debouncing
uint8_t last_read_state; // last state of the button mask; ie, what we last read
unsigned long last_press_check = 0; // time we last checked the buttons

// debouncing -> application data
uint8_t press_state;	 // current state of the debouncer -> application buffer; used to handle consumption of events
uint8_t press_events; 	 // record of rising edges
uint8_t depress_events;  // record of trailing edges

/* Display interrupt communication */
volatile uint8_t digit_values[] = {0, 0, 0, 0};

void init_debounce_pins() {
  /* Initialize the monitoring of debounced pins */
  // init the pin mask of what we are monitoring, and set the pin state
  uint8_t pin_mask = 0;
  for (int i=0; i<(sizeof(debounced_pins)/sizeof(int)); i++) {
    int pin = debounced_pins[i];

    Serial.print("Init'ing pin: ");
    Serial.println(pin , DEC);

    // add bit for button to mask
    pin_mask |= (1 << pin);

    // create button state at idx i in button_states
    button_counts[pin] = 0;
  }

  monitor_mask = pin_mask;

  press_state = 0;
  last_read_state = (~0) & monitor_mask;

  press_events = 0;
  depress_events = 0;

  // init the input pull up state of all pins
  DDRC |= monitor_mask; // sets all monitor pins as r/w
  PORTC |= monitor_mask; // sets all monitor pins as pull up (writes high)
}

void check_presses() {
  /* check the current button state, if enough time has passed */
  unsigned long mark = millis();
  if ((mark - last_press_check) > PRESS_CHECK_INTERVAL) {
    do_check_presses();
    last_press_check = mark;
  }
}

void do_check_presses() {
  /* compares the current state of the pins agains the last known state,
     marking each changed pin into the button variables */
  const uint8_t read_state = PINC & monitor_mask;
  const uint8_t read_change = read_state ^ last_read_state;

  for (int i=0; i<(sizeof(debounced_pins)/sizeof(int)); i++) {
    const int pin = debounced_pins[i];
    mark_change(pin,
		!((read_state >> pin) & 1), // the current pin's value (inverted to notate pressed as true)
		(read_change >> pin) & 1,   // whether it's changed
		(press_state >> pin) & 1);  // what we have notated
  }

  // store state for next time
  last_read_state = read_state;
}

void mark_change(int pin, bool read_state, bool read_changed, bool clean_state) {
  /* Handles the change in logic for a single, debounced pin:
     --A pin that has changed state on the wire has its state count
       reset
     --A pin that has remained in the same state for enough
       observations has its state notated into press_state, and the
       rising/trailing event notated into press/depress_events
   */
  if (read_changed) {
    button_counts[pin] = 0;
  } else if (button_counts[pin] < OBSERVATION_THRESHOLD) {
    // not long enough to affect our cleaned state
    button_counts[pin]++;
  } else if (read_state != clean_state) {
    // have press, will travel
    // set state of the button in the buffers
    const uint8_t press_bit = (1 << pin);
    if (read_state) {
      press_state |= press_bit;
      press_events |= press_bit;
    } else {
      press_state &= ~(press_bit);
      depress_events |= press_bit;
    }
  }
}

void init_display() {
  /* Sets up the display communication and interrupt */

  // set pin outputs
  DDRD |= (1 << CLK) | (1 << DATA);

  // write shift clock low, to begin with
  digitalWrite(CLK, LOW);
  digitalWrite(DATA, LOW);

  // set all selector lines down
  for (int i=0; i<4; i++) {
    pinMode(digit_selector_lines[i], OUTPUT);
    digitalWrite(digit_selector_lines[i], LOW);
  }

  // Set up interrupt for servicing each digit
  TCCR1A = 0;
  TCCR1B = 0;
  TCCR1B |= (1 << WGM12);
  TCCR1B |= (1 << CS12) | (1 << CS10); // set tick value to clk / 1024, every 62.5 us

  OCR1A = 60; // compare A register value every 1000 ticks
  TIMSK1 |= (1 << OCIE1A); // interrupt on Compare A
}

uint8_t segment = 0; // state of the digit selector

ISR(TIMER1_COMPA_vect) {
  /* An interrupt for servicing the display

     The display (common anode) can have one digit powered at a
     time. This interrupt powers down the last digit, loads the bit
     pattern in the shift register, and powers up the next digit.
   */
  const uint8_t last_segment = segment;
  const uint8_t next_segment = (segment + 1) % 4;

  uint8_t digit_data = digit_codes[digit_values[next_segment]];

  // insert dot for the middle two digits, for a semicolon
  if (next_segment == 1 || next_segment == 2) {
    digit_data |= dot_mask;
  }

  digitalWrite(digit_selector_lines[last_segment], LOW);
  write_data(digit_data);
  digitalWrite(digit_selector_lines[next_segment], HIGH);

  segment = next_segment;
}

void write_data(uint8_t data) {
  /* Writes the given data word into the shift register, MSB first */
  const uint8_t mask = 1 << 7;

  for(uint8_t i=0; i<8; i++) {
    // set data line
    if (data & mask) {
      PORTD |= DATA_HIGH;
    } else {
      PORTD &= DATA_LOW;
    }

    // toggle clock line (settle time is fast enough on the 328p)
    PORTD |= CLK_HIGH;
    PORTD &= CLK_LOW;

    data <<= 1;
  }
}

void setup() {
  // initialize misc. inputs and outputs
  pinMode(LID, INPUT_PULLUP);
  pinMode(LID_OVERRIDE, INPUT_PULLUP);

  pinMode(PZO, OUTPUT);
  digitalWrite(PZO, LOW);

  pinMode(LTRELAY, OUTPUT);
  digitalWrite(LTRELAY, LOW);

  Serial.begin(9600);

  init_debounce_pins();
  Serial.println("Set up button debounce interrupt");

  init_display();
  Serial.println("Set up display interrupt");

  // set init program state
  state = AWAIT;
  
  // set all timer state
  reset_timer();

  Serial.println("Initialized all program state");

  Serial.println("Enabling interrupts and beginning program");
  sei();
}

void reset_timer() {
  // resets the timer
  set_run_time = run_time = DEFAULT_RUN_TIME;
  set_display_time(set_run_time);
}

void set_display_time(int secs) {
  if (display_time != secs) {
    display_time = secs;
    write_display_time_out(secs);
  }
}

void write_display_time_out(const int secs) {
  // writes the display secs contents into the interrupt communication array
  write_digit(0, secs % 10);
  write_digit(1, (secs % 60) / 10);
  write_digit(2, (secs / 60) % 10);
  write_digit(3, (secs / 60) / 10);
}

void write_digit(int segment, int digit) {
  digit_values[segment] = digit;
}

void change_set_run_time(int delta) {
  set_run_time += delta;

  if (set_run_time < 0) {
    set_run_time = MAX_RUN_TIME;
  } else if (set_run_time > MAX_RUN_TIME) {
    set_run_time %= MAX_RUN_TIME;
  }

  set_display_time(set_run_time);
}

void short_beep() {
  tone(PZO, BEEP_PITCH, SHORTBEEP);
}

void panic_beep() {
  tone(PZO, PANIC_PITCH, PANICBEEP);
}

void enable_lights() {
  tone(PZO, LIGHT_ON_PITCH, LONGBEEP);
  digitalWrite(LTRELAY, HIGH);
}

void disable_lights() {
  digitalWrite(LTRELAY, LOW);
  tone(PZO, LIGHT_OFF_PITCH, LONGBEEP);
}

bool am_locked() {
  if (digitalRead(LID_OVERRIDE)) {
    return digitalRead(LID);
  }
  return true;
}

bool check_pressed(uint8_t pressed, int pin) {
  return (pressed >> pin) & 1;
}

bool is_pressed(int pin) {
  return check_pressed(press_state, pin);
}

bool is_depressed(int pin) {
  return !is_pressed(pin);
}

bool press_event(int pin) {
  return check_pressed(press_events, pin);
}

bool depress_event(int pin) {
  return check_pressed(depress_events, pin);
}

uint8_t consume_press_events() {
  const uint8_t events = press_events;
  press_events = 0;
  return events;
}

uint8_t consume_depress_events() {
  const uint8_t events = depress_events;
  depress_events = 0;
  return events;
}

void loop() {
  Serial.println("Starting main loop");

  states hold_state, from_state;
  int hold_button;
  unsigned long hold_end;

  while (true) {
    check_presses();

    switch (state) {
    case AWAIT:
      {
 	const uint8_t pressed = press_state;
	if (check_pressed(pressed, UP)) {
	  state = UP_PRESS;
	} else if (check_pressed(pressed, DOWN)) {
	  state = DOWN_PRESS;
	} else if (check_pressed(pressed, RUNPAUSE)) {
	  state = HOLD_TRANSITION;

	  hold_state = RUN_INIT;
	  from_state = AWAIT;
	  hold_button = RUNPAUSE;
	  hold_end = millis() + START_HOLD;
	} else {
	  delay(1);
	}
      }
      break;
    case HOLD_TRANSITION:
      {
	if (is_pressed(hold_button)) {
	  if (millis() >= hold_end) {	  
	    state = hold_state;
	  }
	} else {
	  state = from_state;
	}
      }
      break;
    case UP_PRESS:
      {
	change_set_run_time(SLOW_INCR);

	state = HOLD_TRANSITION;
	hold_state = UP_HOLD;
	from_state = AWAIT;
	hold_button = UP;
	hold_end = millis() + FAST_HOLD_MS;
      }
      break;
    case DOWN_PRESS:
      {
	change_set_run_time(-SLOW_INCR);

	state = HOLD_TRANSITION;
	hold_state = DOWN_HOLD;
	from_state = AWAIT;
	hold_button = DOWN;
	hold_end = millis() + FAST_HOLD_MS;
      }
      break;
    case UP_HOLD:
      {
	change_set_run_time(FAST_INCR);

	state = HOLD_TRANSITION;
	hold_state = UP_HOLD;
	from_state = AWAIT;
	hold_button = UP;
	hold_end = millis() + FAST_BLIP_MS;
      }
      break;
    case DOWN_HOLD:
      {
	change_set_run_time(-FAST_INCR);

	state = HOLD_TRANSITION;
	hold_state = DOWN_HOLD;
	from_state = AWAIT;
	hold_button = DOWN;
	hold_end = millis() + FAST_BLIP_MS;
      }
      break;
    case RUN_INIT:
      {
	run_time = set_run_time;
      }
    case RUN_FROM_PAUSE:
      // run_from_pause does not overwrite the run_time
      {
	if (!am_locked()) {
	  state = PANIC;
	  break;
	}

	start_run_time = millis();

	set_display_time(run_time);

	consume_press_events();

	enable_lights();
	state = RUN;
      }
      break;
    case RUN:
      {
	unsigned long now = millis();
	unsigned long millis_passed = now - start_run_time;
	unsigned long seconds_passed = millis_passed / 1000;
	const int seconds_left = run_time - seconds_passed;

	if (!am_locked()) {
	  run_time = seconds_left;
	  disable_lights();
	  state = PANIC;
	  Serial.println("Panic!");
	}

	if (press_event(RUNPAUSE)) {
	  run_time = seconds_left;
	  disable_lights();
	  state = PAUSE;
	  Serial.println("Paused!");
	}

	if (seconds_left <= 0) {
	  run_time = 0;
	  disable_lights();
	  state = ZERO;
	  Serial.println("Zero!");
	}

	set_display_time(seconds_left);
      }
      break;
    case ZERO:
      {
	short_beep();

	if (is_pressed(RUNPAUSE)) {
	  set_display_time(set_run_time);
	  state = AWAIT;
	}

	break;
      }
    case PANIC:
      {
	if (is_pressed(RUNPAUSE)) {
	  state = PAUSE;
	}
	break;
      }
    case PAUSE:
      {
	const uint8_t pressed = press_state;

	if (check_pressed(pressed, RUNPAUSE)) {
	  // if runpause was pressed, wait for enough held time
	  state = HOLD_TRANSITION;

	  hold_state = RUN_FROM_PAUSE;
	  from_state = PAUSE;
	  hold_button = RUNPAUSE;
	  hold_end = millis() + START_HOLD;
	} else if (pressed) {
	  // if anything has been pressed, return to AWAIT and break
	  // out of PAUSE
	  set_run_time = run_time;
	  state = AWAIT;
	}
	break;
      }
    }
  }
}
