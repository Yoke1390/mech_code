import tkinter as tk
from datetime import datetime
import math


CIRCLE_RADIUS = 300


def update_clock():
    current_time = datetime.now().time()
    hour = current_time.hour
    minute = current_time.minute
    second = current_time.second


    # 秒針の角度を計算
    # second_angle = second * 6  # 1秒あたりの角度は360度を60秒で割った値


    # 分針の角度を計算
    minute_angle = (minute + second / 60) * 6  # 1分あたりの角度は360度を60分で割った値


    # 時針の角度を計算
    hour_angle = (hour + minute / 60) * 30  # 1時間あたりの角度は360度を12時間で割った値


    # キャンバスをクリア
    canvas.delete("all")


    # 時計の円を描画
    left_top = CIRCLE_RADIUS // 3
    right_bottom = CIRCLE_RADIUS // 3 * 5
    canvas.create_oval(left_top, left_top, right_bottom, right_bottom, width=2)


    # 数字を描画
    number_radius = CIRCLE_RADIUS // 5 * 3
    font_size = int(CIRCLE_RADIUS * 0.08)
    for i in range(1, 13):
        angle = math.radians(i * 30)  # 12個の数字を円周上に均等に配置するために30度ごとに計算
        x = CIRCLE_RADIUS + number_radius * math.sin(angle)
        y = CIRCLE_RADIUS - number_radius * math.cos(angle)
        canvas.create_text(x, y, text=str(i), font=("Arial", font_size, "bold"))


    # 秒針を描画
    # second_x = CIRCLE_RADIUS + 80 * math.sin(math.radians(second_angle))
    # second_y = CIRCLE_RADIUS - 80 * math.cos(math.radians(second_angle))
    # canvas.create_line(CIRCLE_RADIUS, CIRCLE_RADIUS, second_x, second_y, fill="red", width=2)


    # 分針を描画
    minute_radius = CIRCLE_RADIUS // 15 * 7
    minute_x = CIRCLE_RADIUS + minute_radius * math.sin(math.radians(minute_angle))
    minute_y = CIRCLE_RADIUS - minute_radius * math.cos(math.radians(minute_angle))
    canvas.create_line(CIRCLE_RADIUS, CIRCLE_RADIUS, minute_x, minute_y, fill="blue", width=3)


    # 時針を描画
    hour_radius = CIRCLE_RADIUS // 3
    hour_x = CIRCLE_RADIUS + hour_radius * math.sin(math.radians(hour_angle))
    hour_y = CIRCLE_RADIUS - hour_radius * math.cos(math.radians(hour_angle))
    canvas.create_line(CIRCLE_RADIUS, CIRCLE_RADIUS, hour_x, hour_y, fill="black", width=4)


    # 1秒後に再びアップデート
    root.after(1000, update_clock)


# Tkinterウィンドウを作成
root = tk.Tk()
root.title("Analog Clock")


# キャンバスを作成
window_size = 2 * CIRCLE_RADIUS
canvas = tk.Canvas(root, width=window_size, height=window_size)
canvas.pack()


# 初回のアップデート
update_clock()


# メインループを開始
root.mainloop()
