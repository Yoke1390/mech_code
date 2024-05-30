import sys


def measure_Fib(n):

    recursion_count = 0

    def Fib(n):
        nonlocal recursion_count
        recursion_count += 1
        if n == 0:
            return 0
        if n == 1:
            return 1
        return Fib(n - 1) + Fib(n - 2)

    print(f"Fib({n}) -> {Fib(n)}, recursion = {recursion_count} times")


for _ in range(100):
    N_str = input()
    if not N_str.isdigit():
        sys.exit()
    N = int(N_str)
    if N < 0:
        sys.exit()
    measure_Fib(N)

print("100 times")
sys.exit()
