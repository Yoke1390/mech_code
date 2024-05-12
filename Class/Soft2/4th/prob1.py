"""program for assignment 1"""


def sum_rec(term, a, _next, b):
    """
    term: function
    a: start
    _next: method to calc next index
    b: end
    """

    if a > b:
        return 0
    return term(a) + sum_rec(term, _next(a), _next, b)


def inc(n):
    """add 1"""
    return n + 1


def cube(x):
    """power by 3"""
    return x**3


def integral(f, a, b, dx):
    """integral with less accuracy"""

    def add_dx(x):
        return x + dx

    return sum_rec(f, a + (dx / 2.0), add_dx, b) * dx


def integral_simpson(f, a, b, n):
    """
    f: function to calc integral
    a: start
    b: stop
    n: number of division
    """
    h = (b - a) / n  # dx

    def y(k):
        return f(a + k * h)

    def term(k):
        if k in (0, n):
            return 1 * y(k)
        if k % 2 == 0:  # even
            return 2 * y(k)
        if k % 2 == 1:  # odd
            return 4 * y(k)
        # error
        return 0

    return sum_rec(term, 0, inc, n) * (h / 3)


if __name__ == "__main__":
    print(f"integral_simpson(cube, 0, 1, 5): {integral_simpson(cube, 0, 1, 5)}")
    print(f"integral_simpson(cube, 0, 1, 10): {integral_simpson(cube, 0, 1, 10)}")
    print(f"integral_simpson(cube, 0, 1, 100): {integral_simpson(cube, 0, 1, 100)}")
    print(f"integral(cube, 0, 1, 0.01): {integral(cube, 0, 1, 0.01)}")

# Result
# > integral_simpson(cube, 0, 1, 5): 0.20320000000000002
# > integral_simpson(cube, 0, 1, 10): 0.25
# > integral_simpson(cube, 0, 1, 100): 0.24999999999999992
# > integral(cube, 0, 1, 0.01): 0.24998750000000042
