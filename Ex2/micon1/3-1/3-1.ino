// C++ code
//

#define TRIG 2
#define ECHO 3

const float time_gain = 1.0/58.0;

float read_sensor(){
  digitalWrite(TRIG, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIG, LOW);

  Serial.println(pulseIn(ECHO, HIGH));

  return time_gain * pulseIn(ECHO, HIGH);
}

void setup() { 
  pinMode(TRIG, OUTPUT); 
  pinMode(ECHO, INPUT);

  Serial.begin(9600);
}

float distance;
void loop() {
  distance = read_sensor();
  Serial.println(distance);
  delay(500);
}
