/*
  Thumb Joystick demo v1.0
  by:https://www.seeedstudio.com
  connect the module to A0&A1 for using;
*/

void setup()
{
    // initialize the A0, A1 pins as inputs:
  pinMode(14, INPUT);
  pinMode(15, INPUT);
  pinMode(2, OUTPUT);
  pinMode(3, OUTPUT);
  pinMode(4, OUTPUT);
  pinMode(5, OUTPUT);
  Serial.begin(9600);
}

void loop()
{
    int sensorValue1 = analogRead(14);
    int sensorValue2 = analogRead(15);

    if (sensorValue1 >611) {
       digitalWrite(2, HIGH);
       digitalWrite(3, LOW); 
    }
    else if (sensorValue1 < 411) {
      digitalWrite(2, LOW);
      digitalWrite(3, HIGH);
    }
    else {
      digitalWrite(2, LOW);
      digitalWrite(3, LOW);
    }

    if (sensorValue2 >611) {
       digitalWrite(4, HIGH);
       digitalWrite(5, LOW); 
    }
    else if (sensorValue2 < 411) {
      digitalWrite(4, LOW);
      digitalWrite(5, HIGH);
    }
    else {
      digitalWrite(4, LOW);
      digitalWrite(5, LOW);
    }

    Serial.print("The X and Y coordinate is:");
    Serial.print(sensorValue1, DEC);
    Serial.print(",");
    Serial.println(sensorValue2, DEC);
    Serial.println(" ");
    delay(200);
}