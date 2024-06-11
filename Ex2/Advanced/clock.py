import tkinter as tk
import math


class AnalogClock(tk.Canvas):
    def __init__(self, master=None, **kwargs):
        super().__init__(master, **kwargs)
        self.width = self.winfo_reqwidth()
        self.height = self.winfo_reqheight()
        self.center = (self.width // 2, self.height // 2)
        self.radius = min(self.width, self.height) // 2 - 10

        # Initial time is 10:10
        self.hour = 10
        self.minute = 10

        self.bind("<B1-Motion>", self.on_drag)
        self.draw_clock()

    def draw_clock(self):
        self.delete("all")
        self.create_oval(self.center[0] - self.radius, self.center[1] - self.radius,
                         self.center[0] + self.radius, self.center[1] + self.radius)

        # Draw hour marks
        for i in range(12):
            angle = math.pi / 6 * i
            x_inner = self.center[0] + self.radius * 0.8 * math.sin(angle)
            y_inner = self.center[1] - self.radius * 0.8 * math.cos(angle)
            x_outer = self.center[0] + self.radius * 0.9 * math.sin(angle)
            y_outer = self.center[1] - self.radius * 0.9 * math.cos(angle)
            self.create_line(x_inner, y_inner, x_outer, y_outer, width=2)

        # Draw minute hand
        minute_angle = math.pi / 30 * self.minute
        self.minute_hand = self.create_line(
            self.center[0], self.center[1],
            self.center[0] + self.radius * 0.8 * math.sin(minute_angle),
            self.center[1] - self.radius * 0.8 * math.cos(minute_angle),
            width=2, fill='blue'
        )

        # Draw hour hand
        hour_angle = math.pi / 6 * (self.hour + self.minute / 60)
        self.hour_hand = self.create_line(
            self.center[0], self.center[1],
            self.center[0] + self.radius * 0.5 * math.sin(hour_angle),
            self.center[1] - self.radius * 0.5 * math.cos(hour_angle),
            width=4, fill='black'
        )

    def on_drag(self, event):
        x, y = event.x - self.center[0], event.y - self.center[1]
        angle = math.atan2(y, x)
        new_minute = (angle * 30 / math.pi) % 60
        if self.minute < 10 and new_minute > 50:
            self.hour = (self.hour - 1) % 24
        elif self.minute > 50 and new_minute < 10:
            self.hour = (self.hour + 1) % 24
        self.minute = round(new_minute)
        self.draw_clock()


if __name__ == "__main__":
    root = tk.Tk()
    root.title("Analog Clock")
    clock = AnalogClock(root, width=400, height=400)
    clock.pack(expand=True, fill=tk.BOTH)
    root.mainloop()
