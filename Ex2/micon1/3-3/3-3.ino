#include <Stepper.h>

#define Q1 2
#define NOT_Q1 3
#define Q2 4
#define NOT_Q2 5

#define TRIG 9
#define ECHO 8

const float time_gain = 1.0/58.0;

float read_sensor(){
  digitalWrite(TRIG, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIG, LOW);

  return time_gain * pulseIn(ECHO, HIGH);
}

const int StepsPerRotate = 2048;
int rpm = 15;
int Steps = 512;
Stepper stepper(StepsPerRotate, Q1, Q2, NOT_Q1, NOT_Q2);

void setup() { 
  pinMode(TRIG, OUTPUT); 
  pinMode(ECHO, INPUT);

  Serial.begin(9600);
  stepper.setSpeed(rpm);
}

float distance;
void loop() {
  distance = read_sensor();
  Serial.println(distance);

  if (distance < 50){
    Serial.println("-> Rotate");
    stepper.step(Steps);
  } else {
    Serial.println("-> Stop");
  }
  delay(500);
}
