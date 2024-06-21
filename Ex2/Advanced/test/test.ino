int ledPin = 13;  // 13番ピンに接続された内蔵LED

void setup() {
  pinMode(ledPin, OUTPUT);  // LEDピンを出力に設定
  Serial.begin(9600);  // シリアル通信の開始
}

void loop() {
  if (Serial.available() > 0) {
    char data = Serial.read();  // シリアルデータを読み取る
    if (data == '1') {
      digitalWrite(ledPin, HIGH);  // LEDを点灯
    } else if (data == '0') {
      digitalWrite(ledPin, LOW);  // LEDを消灯
    }
  }
}

