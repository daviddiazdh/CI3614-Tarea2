def mergeSortIterator(array):
    if len(array) == 1:
        yield array
    else: 
        mid = len(array) // 2

        for x in mergeSortIterator(array[:mid]):
            leftArray = x

        for x in mergeSortIterator(array[mid:]):
            rightArray = x

        mixArray = []

        while len(rightArray) != 0 or len(leftArray) != 0:
            if len(rightArray) == 0:
                mixArray.append(leftArray[0])
                leftArray.pop(0)
            elif len(leftArray) == 0:
                mixArray.append(rightArray[0])
                rightArray.pop(0)
            else:
                isLeftMinor = leftArray[0] < rightArray[0]
                mixArray.append(leftArray[0] if isLeftMinor else rightArray[0])
                leftArray.pop(0) if isLeftMinor else rightArray.pop(0)

        yield mixArray

for x in mergeSortIterator([3, 20, 45, 1]):
    print(*x)



