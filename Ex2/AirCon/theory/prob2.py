import numpy as np
import matplotlib.pyplot as plt

# ---- Constants ----

room_volume = 2.4 * 3.6 * 3.6  # m^3
rho_air = 1.166  # kg/m^3
C_air = 1006  # J/kgK
room_capacity = room_volume * rho_air * C_air  # J/K

T_init = 37  # deg C
T_targt = 26  # deg C
T_goal_range = 0.5  # deg C

Qin = 800  # W
Qout = 0  # W

N_init = 20  # rps
max_N_diff = 2  # rps/s
N_max = 110  # rps
N_min = 20  # rps

duration = 10 * 60  # s


# ---- Functions ----


def Q_cool(N):
    return 5.56e-4 * N**3 - 6.26e-2 * N**2 + 39.8 * N - 66.9  # W


def W_comp(N):
    return 3.25e-4 * N**3 - 2.31e-2 * N**2 + 7.24 * N - 26.9  # W


plt.plot(
    np.linspace(N_min, N_max, 1000),
    Q_cool(np.linspace(N_min, N_max, 1000)),
    label="Q_cool",
)
plt.plot(
    np.linspace(N_min, N_max, 1000),
    W_comp(np.linspace(N_min, N_max, 1000)),
    label="W_comp",
)
plt.xlabel("N (rps)")
plt.legend()
plt.show()

plt.plot(
    np.linspace(N_min, N_max, 1000),
    W_comp(np.linspace(N_min, N_max, 1000)) /
    Q_cool(np.linspace(N_min, N_max, 1000)),
    label="W/Q",
)
plt.xlabel("N (rps)")
plt.legend()
plt.show()
# ほとんど直線とかんがえてよさそう


# 維持に必要な最低の回転数

N_maintain = N_max
for n in np.linspace(N_min, N_max, 100000):
    if Q_cool(n) > Qin:
        N_maintain = n
        print(f"N_maintain: {N_maintain}, Q_cool: {Q_cool(N_maintain)}")
        break


class Problem:
    def __init__(self):
        self.N = N_init
        self.N_target = N_max
        self.T = T_init

        self.time_record = -1
        self.N_record = [self.N]
        self.T_record = [self.T]
        self.J_sum = 0  # 消費電力の積算値
        self.J_record = [self.J_sum]

    def main(self):
        for t in range(duration + 1):
            self.update(t)
        self.plot()
        print("Result:")
        print(f"Time to reach goal: {self.time_record} s")
        print(f"Total energy consumption: {self.J_sum / 1000:.1f} kJ")

    def update(self, t):
        self.T += (Qin - Q_cool(self.N) - Qout) / room_capacity

        self.set_N_target()
        self.N += self.dN()

        self.record(t)

    def set_N_target(self):
        if self.T < T_targt:
            self.N_target = N_maintain
        if self.T < T_targt - T_goal_range / 2:
            self.N_target = N_maintain - 1

    def dN(self):
        if self.N < self.N_target - max_N_diff:
            return max_N_diff
        elif self.N > self.N_target + max_N_diff:
            return -max_N_diff
        return self.N_target - self.N

    def record(self, t):
        if self.T <= T_targt:
            if self.time_record < 0:
                self.time_record = t

        self.N_record.append(self.N)
        self.T_record.append(self.T)
        self.J_sum += W_comp(self.N)
        self.J_record.append(self.J_sum)

    def plot(self):
        fig, ax1 = plt.subplots()

        color = "tab:red"
        ax1.set_xlabel("time (s)")
        ax1.set_ylabel("N: compressor speed [rps]", color=color)
        ax1.plot(self.N_record, color=color)
        ax1.tick_params(axis="y", labelcolor=color)

        ax2 = ax1.twinx()
        color = "tab:blue"
        ax2.set_ylabel("T: room tempreture [degree C]", color=color)
        ax2.plot(self.T_record, color=color)
        ax2.tick_params(axis="y", labelcolor=color)
        plt.grid()

        J_kJ = [J / 1000 for J in self.J_record]
        ax3 = ax1.twinx()
        ax3.spines["right"].set_position(("outward", 60))
        color = "tab:green"
        ax3.set_ylabel("J: energy consumption [kJ]", color=color)
        ax3.plot(J_kJ, color=color)
        ax3.tick_params(axis="y", labelcolor=color)

        fig.tight_layout()
        plt.show()


# A: 最短の時間で室温を下げる

print("\nProblem A")
A = Problem()
A.main()

# B: 消費電力を最小化する


class ProblemB(Problem):
    def __init__(self):
        super().__init__()
        self.N_target = self.calc_N_target()
        print(f"N_target: {self.N_target}")

    def update(self, t):
        self.T += (Qin - Q_cool(self.N) - Qout) / room_capacity
        self.N = self.simlate_N(t, self.N_target)
        self.record(t)

    def calc_N_target(self):
        for n in np.linspace(N_min, N_max, 10000):
            if self.simulate_T_at_end(n) < T_targt:
                return n
        return N_max

    def simulate_T_at_end(self, N_target):
        T = T_init
        for t in range(duration + 1):
            T += (Qin - Q_cool(self.simlate_N(t, N_target)) - Qout) / room_capacity
        return T

    def simlate_N(self, t, target_N):
        if t < duration / 2:
            N = N_init + max_N_diff * t
        if t >= duration / 2:
            N = N_maintain - max_N_diff * (t - duration + 1)
        if N > target_N:
            N = target_N
        return N


print("\nProblem B")
B = ProblemB()
B.main()
