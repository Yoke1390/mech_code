# Arduinoのポートを取得
PORT=$(arduino-cli board list | grep "USB" | awk '{print $1}')

# スケッチをコンパイルしてArduinoにアップロード
cd ./empty/
arduino-cli compile -b arduino:avr:nano
arduino-cli upload -p $PORT -b arduino:avr:nano .
