#include <Stepper.h>

// ピンの定義
#define Q1 2
#define NOT_Q1 3
#define Q2 4
#define NOT_Q2 5

// ステップモータのパラメータ
#define STEPS_PER_ROTATE 2048 // 1回転あたりのステップ数
#define STEPS_PER_MINUTE 48 // 1/60回転あたりのステップ数

const float time_gain = 1.0/58.0;

int rpm = 15;
Stepper stepper(STEPS_PER_ROTATE, Q1, Q2, NOT_Q1, NOT_Q2);


String inString = "";  // インプットを格納する変数
int minuteDiff = 0;  // 時計の指す時刻と目指す時刻の差(分)


// シリアル通信でステップ数を受け取る
void getSteps(){
  if(Serial.available()>0){
    String input = Serial.readStringUntil(',');
    Serial.println("Received: " + input);
    minuteDiff += input.toInt();
    Serial.println("Remaining steps: " + String(minuteDiff));
  }
}

// minuteDiffの数だけ3ステップ刻みでステップモータを回す
void runStepper(){
  if (minuteDiff > 5){
    stepper.step(5*STEPS_PER_MINUTE);
    minuteDiff-=5;
  } else if (minuteDiff > 0){
    stepper.step(STEPS_PER_MINUTE);
    minuteDiff--;
  } else if (minuteDiff < -5){
    stepper.step(-5*STEPS_PER_MINUTE);
    minuteDiff+=5;
  } else if (minuteDiff < 0){
    stepper.step(-STEPS_PER_MINUTE);
    minuteDiff++;
  }
}

void setup() { 
  Serial.begin(9600);
  stepper.setSpeed(rpm);
}

void loop() {
  getSteps();
  runStepper();
  Serial.println("difference: " + String(minuteDiff));
  delay(100);
}
