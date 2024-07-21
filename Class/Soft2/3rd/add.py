def inc_a(x, inc_times=0):
    model = "1 + " * inc_times + str(x)
    print(model)
    return x + 1


def inc(x):
    return x + 1


def dec(x):
    return x - 1


def plus_a(a, b, inc_times=0):
    if inc_times == 0:
        print(f"plus_a({a}, {b})")
    if a == 0:
        return b
    else:
        inc_times += 1
        model = "1 + " * inc_times + f"plus_a({dec(a)}, {b})"
        print(model)
        return inc_a(
            plus_a(dec(a), b, inc_times),
            inc_times
        )


def plus_b(a, b):
    if a == 0:
        print(f"plus_b({a}, {b}) -> {b}")
        return b
    else:
        print(f"plus_b({a}, {b}) -> plus_b({dec(a)}, {inc(b)})")
        return plus_b(dec(a), inc(b))


print(plus_a(4, 5))
print("")
print(plus_b(4, 5))
