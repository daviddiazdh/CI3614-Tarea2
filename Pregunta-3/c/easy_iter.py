def minIter(list):
    if not list:
        return
    else:
        while len(list) != 0:
            minimun = min(list)
            list.remove(minimun)
            yield minimun

for x in minIter([3, 20, 5, 1]):
    print(x)