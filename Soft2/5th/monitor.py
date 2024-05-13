import math


def monitor_sqrt():
    count = 0

    def sqrt_main(x):
        nonlocal count
        count += 1
        print(count)
        return math.sqrt(x)

    return sqrt_main


my_sqrt = monitor_sqrt()


print(my_sqrt(9))
print(my_sqrt(16))
