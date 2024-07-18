# 引数から時計の初期時刻を設定
HOUR=$1
MINUTE=$2

# Arduinoのポートを取得
PORT=$(arduino-cli board list | grep "USB" | awk '{print $1}')

# スケッチをコンパイルしてArduinoにアップロード
cd ./clock/
arduino-cli compile -b arduino:avr:nano
arduino-cli upload -p $PORT -b arduino:avr:nano .

# Pythonスクリプトを実行
cd ..
echo "Running poetry with hour: $HOUR, minute: $MINUTE, port: $PORT"
poetry run python clock.py $HOUR $MINUTE $PORT
