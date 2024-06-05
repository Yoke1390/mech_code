import random


def selection_sort(arr):
    if len(arr) == 0:
        return []
    min_index = 0
    min_value = arr[0]
    for i in range(1, len(arr)):
        if arr[i] < min_value:
            min_index = i
            min_value = arr[i]
    arr[0], arr[min_index] = arr[min_index], arr[0]
    return arr[:1] + selection_sort(arr[1:])


def bubble_sort(arr):
    if len(arr) == 0:
        return []
    for i in range(len(arr) - 1, 0, -1):
        if arr[i] < arr[i - 1]:
            arr[i], arr[i - 1] = arr[i - 1], arr[i]
    return arr[:1] + bubble_sort(arr[1:])


arr = [random.randint(0, 100) for _ in range(10)]

print("Original array: ", arr)
print("Selection sort: ", selection_sort(arr))
print("Bubble sort: ", bubble_sort(arr))
