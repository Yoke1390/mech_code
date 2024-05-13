def measure_Fib(n):

    recursion_count = 0

    def Fib(n):
        recursion_count += 1
        if n == 0:
            return 0
        if n == 1:
            return 1
        return Fib(n - 1) + Fib(n - 2)

    print(f"Fib({n}) -> {Fib(n)}, recursion = {recursion_count} times")


measure_Fib(10)
