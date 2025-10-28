def suspenso(a, b):
    if b == []:
        yield a
    else:
        yield a + b[0]
        for x in suspenso(b[0], b[1:]):
            yield x

def misterio(n):
    if n == 0:
        yield [1]
    else:
        for x in misterio(n-1):
            r = []
            for y in suspenso(0, x):
                r = [*r, y]
            yield r


for x in suspenso(0, [1, 1]):
    print(x)


for x in misterio(5):
    print(x)