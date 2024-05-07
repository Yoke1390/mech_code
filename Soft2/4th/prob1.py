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
    return term(a) + sum(term, _next(a), _next, b)


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

    return sum(f, a + (dx / 2.0), add_dx, b) * dx


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

    return sum(term, a, b, n) * (3 / h)
