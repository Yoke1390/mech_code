import math
import numpy


def solve_built_in(a, b, c):
    x1 = (-b + (b**2 - 4 * a * c) ** 0.5) / (2 * a)
    x2 = (-b - (b**2 - 4 * a * c) ** 0.5) / (2 * a)
    return x1, x2


def solve_math(a, b, c):
    x1 = (-b + math.sqrt(b**2 - 4 * a * c)) / (2 * a)
    x2 = (-b - math.sqrt(b**2 - 4 * a * c)) / (2 * a)
    return x1, x2


def solve_numpy(a, b, c):
    x1, x2 = numpy.roots([a, b, c])
    return x1, x2


# ax^2 + bx + c = 0
a = 1
b = 2
c = -2

if b**2 - 4 * a * c < 0:
    raise ValueError("No real roots. b^2 - 4ac < 0")

print("Solving using built-in calculation")
print(solve_built_in(a, b, c))
print("Solving using math library")
print(solve_math(a, b, c))
print("Solving using numpy library")
print(solve_numpy(a, b, c))
