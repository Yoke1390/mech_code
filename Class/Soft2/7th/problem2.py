import random


operator = ["+", "-", "*", "/"]


def inverse_poland(expr_array):
    stack = []
    for token in expr_array:
        if token.isdigit():
            stack.append(token)
        elif token in operator:
            a = int(stack.pop())
            b = int(stack.pop())
            if token == "+":
                stack.append(a + b)
            elif token == "-":
                stack.append(b - a)
            elif token == "*":
                stack.append(a * b)
            elif token == "/":
                stack.append(b / a)
        else:
            raise ValueError("Invalid token")
    return stack[0]


def human_readable(expr_array):
    stack = []
    for token in expr_array:
        if token.isdigit():
            stack.append(token)
        elif token in operator:
            a = stack.pop()
            b = stack.pop()
            stack.append(f"({b} {token} {a})")
        else:
            print(f"stack: {stack}")
            print(f"token: {token}")
            raise ValueError("Invalid token")
    return stack[0]


NUMBER_OF_OPERATION = 2

while True:
    expr = [str(random.randint(1, 9)) for _ in range(NUMBER_OF_OPERATION + 1)]
    for i in range(NUMBER_OF_OPERATION):
        expr.append(random.choice(operator))
    try:
        inverse_poland(expr)
        break
    except ZeroDivisionError:
        print("ZeroDivisionError occured. Retry.")
        continue

print("expr: " + " ".join(expr))
print(f"human readable: {human_readable(expr)}")
print(f"result: {inverse_poland(expr)}")
