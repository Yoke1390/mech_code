import random

node_list = []


class Tree:
    def __init__(self, value="0", parent=[], deapth=0):
        self.value = value
        self.parent = parent
        self.children = []

        node_list.append(self.value)

    def show(self, deapth=0, is_last=False):
        if deapth == 0:
            node_str = "R" + " " + str(self.value)
        else:
            node_str = "  " + "│ " * (deapth - 1) + "├─ " + str(self.value)
        print(node_str)
        for child in self.children:
            child.show(deapth + 1)

    def add_child(self, child_node):
        self.children.append(child_node)

    def make_tree(self, tree_deapth, width):
        if tree_deapth == 0:
            return
        numbers = random.sample(range(10000), width)
        for i in range(width):
            value = str(numbers[i])
            parent = self.parent + [self.value]
            child = Tree(value, parent)
            self.add_child(child)
            child.make_tree(tree_deapth - 1, width)


def deapth_limited_search(tree, limit, target):
    if tree.value == target:
        return tree.value
    if limit == 0:
        return ""
    for child in tree.children:
        child_search = deapth_limited_search(child, limit - 1, target)
        if child_search:
            return tree.value + " → " + child_search
    return ""


def iterative_deepening_search(tree, target):
    max_deapth = 100
    for deapth in range(max_deapth + 1):
        print(f"searching deapth {deapth}")
        result = deapth_limited_search(tree, deapth, target)
        if result:
            return result


my_tree = Tree()
my_tree.make_tree(3, 2)
my_tree.show()

target = random.choice(node_list)
print(f"Target: {target}")
result = iterative_deepening_search(my_tree, target)
print(f"Result: {result}")
