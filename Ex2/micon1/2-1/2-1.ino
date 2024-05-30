#define Q1 5
#define NOT_Q1 6
#define Q2 7
#define NOT_Q2 8

#define DELAY 10

void setup() { 
  pinMode(Q1, OUTPUT); 
  pinMode(NOT_Q1, OUTPUT); 
  pinMode(Q2, OUTPUT); 
  pinMode(NOT_Q2, OUTPUT); 
}

void loop() {
  digitalWrite(Q1, HIGH);
  digitalWrite(NOT_Q1, LOW);
  delay(DELAY);

  digitalWrite(Q2, HIGH);
  digitalWrite(NOT_Q2, LOW);
  delay(DELAY);

  digitalWrite(Q1, LOW);
  digitalWrite(NOT_Q1, HIGH);
  delay(DELAY);

  digitalWrite(Q2, LOW);
  digitalWrite(NOT_Q2, HIGH);
  delay(DELAY);
}
