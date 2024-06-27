import matplotlib.pyplot as plt
import seaborn as sns
import pandas as pd

# 理論データ
data1 = pd.DataFrame({
    "name": ["compressor in", "compressor out", "out heat ex (gas)", "out heat ex (liquid)", "in heat ex (liquid)", "in heat ex (gas)"],
    "temperature": [19, 59.4, 19, 14.4, 37.4, 59.4],  # [°C]
    "pressure": [1.26, 2.34, 1.26, 1.26, 2.34, 2.34],  # [MPa]
    "specific enthalpy": [523.4, 548.1, 523.4, 270.2, 270.2, 548.1],  # [kJ/kg]
    "specific entropy": [2.12, 2.13, 2.12, 1.24, 1.24, 2.13],  # [kJ/(kgK)]
    "density": [33.4, 56.5, 33.4, -1, 905.9, 56.5],  # [kg/m3]
    "flow": [1.4e-2] * 6  # [kg/s]
})


# 実測データ
data2 = pd.DataFrame({
    "name": ["compressor in", "compressor out", "out heat ex (gas)", "out heat ex (liquid)", "in heat ex (liquid)", "in heat ex (gas)"],
    "temperature": [20.5, 70.5, 17.8, 14.4, 37.4, 65.2],  # [°C]
    "pressure": [1.21, 2.49, 1.21, 1.26, 2.34, 2.48],  # [MPa]
    "specific enthalpy": [526.9, 560.0, 523.2, 270.2, 270.2, 553.0],  # [kJ/kg]
    "specific entropy": [2.14, 2.15, 2.13, 2.10, 1.23, 2.13],  # [kJ/(kgK)]
    "density": [31.3, 56.8, 32.1, -1, 906.0, 58.6],  # [kg/m3]
    "flow": [1.2e-2] * 6  # [kg/s]
})


def problem1(data, fig, ax, label):
    # モリエル線図
    plot_order = [0, 2, 3, 4, 5, 1, 0]
    enthalpy = [data["specific enthalpy"][i] for i in plot_order]
    pressure = [data["pressure"][i] for i in plot_order]
    ax.plot(enthalpy, pressure, label=label, marker='x')

    # 暖房能力
    q = (data["specific enthalpy"][5] - data["specific enthalpy"][4]) * data["flow"][0]
    print(f"暖房能力: {q:.3f} [kW]")

    # 圧縮機動力
    w = (data["specific enthalpy"][1] - data["specific enthalpy"][0]) * data["flow"][0]
    print(f"圧縮機動力: {w:.3f} [kW]")

    # 暖房COP
    cop = q / w
    print(f"暖房COP: {cop:.3f}")


if __name__ == "__main__":
    sns.set(font='Yu Gothic')
    fig, ax = plt.subplots()
    ax.set_xlabel("specific enthalpy [kJ/kg]")
    ax.set_ylabel("pressure [MPa]")
    ax.set_title("Mollier diagram")
    print("1-1: 理論データ")
    problem1(data1, fig, ax, "1-1: 理論データ")
    print("1-2: 実測データ")
    problem1(data2, fig, ax, "1-2: 実測データ")
    ax.legend()
    plt.show()
