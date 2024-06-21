import tkinter as tk
import math
import serial


# シリアルポートの設定
ser = serial.Serial('/dev/cu.usbserial-120', 9600)


# ======= 時計のパラメータ ========
init_hour = 10
init_minute = 10

rotate_per_hour = 1  # 時計を1時間進めるのに必要なつまみの回転回数

# =================================


class AnalogClock(tk.Canvas):
    def __init__(self, master=None, **kwargs):
        super().__init__(master, **kwargs)
        self.width = self.winfo_reqwidth()
        self.height = self.winfo_reqheight()
        self.center = (self.width // 2, self.height // 2)
        self.radius = min(self.width, self.height) // 2 - 10

        # 時刻の初期設定(10:10)
        self.hour = init_hour
        self.minute = init_minute

        self.bind("<B1-Motion>", self.on_drag)
        self.draw_clock()

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
        new_minute = (angle * 30 / math.pi) % 60

        # 現在時刻からのズレが大きい場合は無視
        new_x = self.center[0] + self.radius * 0.8 * math.sin(math.pi / 30 * new_minute)
        new_y = self.center[1] - self.radius * 0.8 * math.cos(math.pi / 30 * new_minute)
        old_x = self.center[0] + self.radius * 0.8 * math.sin(math.pi / 30 * self.minute)
        old_y = self.center[1] - self.radius * 0.8 * math.cos(math.pi / 30 * self.minute)
        if (new_x - old_x) ** 2 + (new_y - old_y) ** 2 > self.radius ** 2 / 25:
            return


        if self.minute < 10 and new_minute > 50:
            self.hour = (self.hour - 1) % 24
        elif self.minute > 50 and new_minute < 10:
            self.hour = (self.hour + 1) % 24
        self.minute = round(new_minute)
        self.draw_clock()

    def send_serial(self):
        diff_hour = self.hour - init_hour
        diff_minute = self.minute - init_minute
        target_angle = 2 * math.pi * rotate_per_hour * (diff_hour + diff_minute / 60)
        ser.write(f"Move:{target_angle}")


def send_step(step):
    print(f'Send step {step}')
    ser.write(bytes(str(step), encoding="ascii"))  # ステッピングモーターにステップ数を送信


if __name__ == "__main__":
    root = tk.Tk()
    root.title("Analog Clock")
    clock = AnalogClock(root, width=400, height=400)
    clock.pack(expand=True, fill=tk.BOTH)
    root.mainloop()
