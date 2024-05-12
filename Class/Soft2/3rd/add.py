def inc(x):
    return x + 1
def dec(x):
    return x - 1

def plus_a(a, b):
    if a == 0:
        print(f"plus_a({a}, {b}), return {b}")
        return b
    else:
        print(f"plus_a({a}, {b})")
        return inc(plus_a(dec(a), b))

def plus_b(a, b):
    if a == 0:
        print(f"plus_b({a}, {b}), return {b}")
        return b
    else:
        print(f"plus_b({a}, {b})")
        return plus_b(dec(a), inc(b))

plus_a(4, 5)
plus_b(4, 5)
