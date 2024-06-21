#include <Stepper.h>

#define Q1 2
#define NOT_Q1 3
#define Q2 4
#define NOT_Q2 5

#define TRIG 9
#define ECHO 8
#define STEPS_PER_ROTATE 2048
#define STEPS 33

const float time_gain = 1.0/58.0;

int rpm = 15;
Stepper stepper(STEPS_PER_ROTATE, Q1, Q2, NOT_Q1, NOT_Q2);


String inString = "";  // string to hold input
int remaining_steps = 0;


void getSteps(){
  if(Serial.available()>0){
    String input = Serial.readStringUntil(',');
    Serial.println("Received: " + input);
    remaining_steps += input.toInt();
    Serial.println("Remaining steps: " + String(remaining_steps));
  }
}

void runStepper(){
  if (remaining_steps > 5){
    stepper.step(5*STEPS);
    remaining_steps-=5;
  } else if (remaining_steps > 0){
    stepper.step(STEPS);
    remaining_steps--;
  } else if (remaining_steps < -5){
    stepper.step(-5*STEPS);
    remaining_steps+=5;
  } else if (remaining_steps < 0){
    stepper.step(-STEPS);
    remaining_steps++;
  }
}

void setup() { 
  Serial.begin(9600);
  stepper.setSpeed(rpm);
}

void loop() {
  getSteps();
  runStepper();
  Serial.println("Remaining steps: " + String(remaining_steps));
  delay(100);
}
