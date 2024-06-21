import serial
import time

# シリアルポートとボーレートを設定
ser = serial.Serial('/dev/cu.usbserial-1120', 9600)

time.sleep(2)  # シリアル通信の安定のために少し待機


def led_on():
    print('LED ON')
    ser.write(b'1')  # '1'を送信してLEDを点灯


def led_off():
    print('LED OFF')
    ser.write(b'0')  # '0'を送信してLEDを消灯


for _ in range(1000):
    # LEDを点灯
    led_on()
    time.sleep(1)  # 1秒待機

    # LEDを消灯
    led_off()
    time.sleep(1)  # 1秒待機

ser.close()  # シリアルポートを閉じる
