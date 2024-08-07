import tracemalloc

tracemalloc.start()


def measure_Fib(n):
    recursion_count = 0

    snapshot1 = tracemalloc.take_snapshot().filter_traces((
        tracemalloc.Filter(False, "/Users/yosukemaeda/.pyenv/*"),
        tracemalloc.Filter(False, "<frozen abc>"),
    ))

    def Fib(n):
        nonlocal recursion_count
        recursion_count += 1
        if n == 0:
            return 0
        if n == 1:
            return 1
        return Fib(n - 1) + Fib(n - 2)

    result = Fib(n)

    snapshot2 = tracemalloc.take_snapshot().filter_traces((
        tracemalloc.Filter(False, "/Users/yosukemaeda/.pyenv/*"),
        tracemalloc.Filter(False, "<frozen abc>"),
    ))

    top_stats = snapshot2.compare_to(snapshot1, 'lineno')
    size_diff_sum = sum(stat.size_diff for stat in top_stats)

    print(f"Fib({n}) -> {result}, recursion = {recursion_count} times, memory = {size_diff_sum} bytes")
    return recursion_count, size_diff_sum


for i in range(0, 40, 5):
    measure_Fib(i)
