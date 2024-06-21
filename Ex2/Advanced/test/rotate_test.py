import serial
import time

# シリアルポートとボーレートを設定
ser = serial.Serial('/dev/cu.usbserial-120', 9600)

time.sleep(2)  # シリアル通信の安定のために少し待機


def send_step(step):
    print(f'Send step {step}')
    ser.write(bytes(str(step), encoding="ascii"))  # ステッピングモーターにステップ数を送信


for _ in range(1000):
    step = int(input('Enter step: '))  # ステップ数を入力
    send_step(step)
    time.sleep(1)  # 1秒待機

ser.close()  # シリアルポートを閉じる
