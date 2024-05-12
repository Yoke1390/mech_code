"""program for assignment 2"""


def inc(x):
    """add 1"""
    print(f"inc({x}) called")
    return x + 1


def double(f):
    """calc two times"""
    print(f"double({f}) called")
    return lambda x: f(f(x))


print(f"double(inc)(0): {double(inc)(0)}")
print(f"double(double(inc))(0): {double(double(inc))(0)}")
