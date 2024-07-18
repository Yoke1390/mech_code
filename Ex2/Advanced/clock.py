import sys
import math
import time
import threading
import tkinter as tk
import serial

# 時計の初期時刻を引数から取得
init_hour = int(sys.argv[1])
init_minute = int(sys.argv[2])

# シリアルポートの設定
try:
    port = sys.argv[3]
    ser = serial.Serial(port, 9600)
except IndexError:
    print('No USB arduino port specified')
    sys.exit(1)


class AnalogClock(tk.Canvas):
    def __init__(self, master=None, **kwargs):
        super().__init__(master, **kwargs)
        # 描画サイズの設定
        self.width = self.winfo_reqwidth()
        self.height = self.winfo_reqheight()
        self.center = (self.width // 2, self.height // 2)
        self.radius = min(self.width, self.height) // 2 - 10

        # 時刻の初期設定(10:10)
        self.hour = init_hour
        self.minute = init_minute

        # シリアル通信の設定
        self.last_send_time = time.time()
        self.last_minute = self.minute
        self.last_hour = self.hour

        # イベントの設定
        self.bind("<B1-Motion>", self.on_drag)

        # 時計の描画
        self.draw_clock()

        # タイマーを起動して、定期的にシリアル通信でステッピングモーターにステップ数を送信
        self.timeEvent()

    # タイマー起動用関数
    def timeEvent(self):
        th = threading.Thread(target=self.send_step)  # スレッドインスタンス生成
        th.start()  # スレッドスタート
        self.after(1000, self.timeEvent)  # ここで、再帰的に関数を呼び出す

    def draw_clock(self):
        self.delete("all")
        self.create_oval(self.center[0] - self.radius, self.center[1] - self.radius,
                         self.center[0] + self.radius, self.center[1] + self.radius)

        # 目盛りの描画
        for i in range(12):
            angle = math.pi / 6 * i
            x_inner = self.center[0] + self.radius * 0.8 * math.sin(angle)
            y_inner = self.center[1] - self.radius * 0.8 * math.cos(angle)
            x_outer = self.center[0] + self.radius * 0.9 * math.sin(angle)
            y_outer = self.center[1] - self.radius * 0.9 * math.cos(angle)
            self.create_line(x_inner, y_inner, x_outer, y_outer, width=2)

        # 分針の描画
        minute_angle = math.pi / 30 * self.minute
        self.minute_hand = self.create_line(
            self.center[0], self.center[1],
            self.center[0] + self.radius * 0.8 * math.sin(minute_angle),
            self.center[1] - self.radius * 0.8 * math.cos(minute_angle),
            width=2, fill='blue'
        )

        # 時針の描画
        hour_angle = math.pi / 6 * (self.hour + self.minute / 60)
        self.hour_hand = self.create_line(
            self.center[0], self.center[1],
            self.center[0] + self.radius * 0.5 * math.sin(hour_angle),
            self.center[1] - self.radius * 0.5 * math.cos(hour_angle),
            width=4, fill='black'
        )

    def on_drag(self, event):
        x, y = event.x - self.center[0], event.y - self.center[1]
        angle = math.atan2(y, x) + math.pi / 2  # 90度のずれを修正
        new_minute = int((angle * 30 / math.pi) % 60)

        # 現在時刻からのズレが大きい場合は無視
        new_x = self.center[0] + self.radius * 0.8 * math.sin(math.pi / 30 * new_minute)
        new_y = self.center[1] - self.radius * 0.8 * math.cos(math.pi / 30 * new_minute)
        old_x = self.center[0] + self.radius * 0.8 * math.sin(math.pi / 30 * self.minute)
        old_y = self.center[1] - self.radius * 0.8 * math.cos(math.pi / 30 * self.minute)
        if (new_x - old_x) ** 2 + (new_y - old_y) ** 2 > self.radius ** 2 / 25:
            return

        # 分針が0時の位置をまたいだ場合の処理

        minute_diff = new_minute - self.minute
        # 反時計回りに回した場合
        if self.minute < 10 and new_minute > 50:
            minute_diff -= 60
            self.hour = (self.hour - 1) % 24
        # 時計回りに回した場合
        elif self.minute > 50 and new_minute < 10:
            minute_diff += 60
            self.hour = (self.hour + 1) % 24

        self.minute = new_minute


        self.draw_clock()

    def send_step(self):
        minute_diff = self.minute - self.last_minute
        hour_diff = self.hour - self.last_hour
        step = minute_diff + 60 * hour_diff

        self.last_minute = self.minute
        self.last_hour = self.hour
        print(f'Send step {step}')
        send = str(step) + ','
        ser.write(bytes(send, encoding="ascii"))  # ステッピングモーターにステップ数を送信


# 処理の開始
root = tk.Tk()
root.title("Analog Clock")
clock = AnalogClock(root, width=400, height=400)
clock.pack(expand=True, fill=tk.BOTH)
root.mainloop()
