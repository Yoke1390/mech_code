import math

# 図1のように、断面が1辺100 mmの正方形で表面が灰色（射出率εc=0.9）のパイプ型の
# 炉の中に、断面が直径20mmの円形で表面が灰色（射出率
# εm=0.2）の金属線を配置して
# 炉の表面温度を高温（
# Tc=900 K）で一定に保ったところ、線の表面温度が
# Tm=500 Kと
# なった。その際の炉から線に放射伝熱により伝わる正味の熱流束(W/m2)を求めよ。な
# お、炉および線の長さは無限大と仮定してよい。
# ステファン・ボルツマン定数は5.7×10-8 W/m2K4とする

sigma = 5.7e-8


def problem1():
    epsilon_c = 0.9
    epsilon_m = 0.2
    Tc = 900
    Tm = 500
    Ac = 100e-3**2 * 4
    Am = math.pi * (20e-3 / 2)**2


    Gc = sigma * (
        epsilon_c * Tc**4 + (1 - epsilon_c) * Tm**4 * Am / Ac
    ) / (
        1 + epsilon_c + epsilon_m - epsilon_c * epsilon_m * Am / Ac
    )
    print(f"Gc = {Gc:.3e} W/m2")

    Gm = sigma * epsilon_m * Tm**4 + (1 - epsilon_m) * Gc
    print(f"Gm = {Gm:.3e} W/m2")

    q_c = Gc - Gm * 1 - Gc * (1 - Am / Ac)
    print(f"q_c = {q_c:.3e} W/m2")
    # TODO: マイナスになってしまう

# 2. 図2のように、真空で隔てられた無限に広い平行2灰色平板の間に遮へい板が2枚設置さ
# れている。下の平板および上の平板の射出率は
# ε1=0.9および
# ε2=0.2であり、表面温度は
# 900 Kおよび500 Kに保たれている。遮へい板の射出率が両方とも
# εs=0.5であるときの
# 正味の熱流束(W/m2)を計算せよ。なお、透過は無視して良い。ステファン・ボルツマン
# 定数は5.7×10-8 W/m2K4とする。


def problem2():
    epsilon_1 = 0.9
    epsilon_2 = 0.2
    epsilon_s = 0.5
    T1 = 900
    T2 = 500

	# q = \frac{
	# 	\sigma({T_1}^4 - {T_2}^4)
	# }{
	# 	\frac{1}{\varepsilon_1} +
	# 	\frac{2}{\varepsilon_{s1}} +
	# 	\frac{2}{\varepsilon_{s2}} +
	# 	\frac{1}{\varepsilon_{2}} - 3
	# }

    q = sigma * (T1**4 - T2**4) / (
        1 / epsilon_1 + 1 / epsilon_2 + 4 / epsilon_s - 3
    )
    print(f"q = {q:.3e} W/m2")


if __name__ == "__main__":
    problem1()
    problem2()
