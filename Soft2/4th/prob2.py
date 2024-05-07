"""program for assignment 2"""


def inc(x):
    """add 1"""
    return x + 1


def double(f):
    """calc two times"""
    return lambda x: f(f(x))


print(f"double(inc)(0): {double(inc)(0)}")
print(f"double(double(inc))(0): {double(double(inc))(0)}")
