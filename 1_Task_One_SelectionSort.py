import random
def selectionSort(array: list, size: int):
    for ind in range(size):
        min_index = ind
        for j in range(ind + 1, size):
            if array[j] < array[min_index]:
                min_index = j
        (array[ind], array[min_index]) = (array[min_index], array[ind])
items = [random.randint(0, 100) for i in range(100)]
s = len(items)     

selectionSort(array = items, size = s)
print(items)
