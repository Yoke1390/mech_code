import numpy as np
import matplotlib.pyplot as plt

r = np.linspace(0.2, 10, 1000)


def f(r):
    h = 1 / r**2
    return r**3 * h + r**2 * h**2


plt.plot(r, f(r))
plt.xlabel('r')
plt.ylabel('f(r)')
plt.savefig('graph.png')
plt.show()
