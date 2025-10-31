def merge_sort_iter(list):
    if len(list) == 1:
        yield list[0]
        return
    if len(list) == 0:
        return
    
    mid = len(list) // 2
    left = merge_sort_iter(list[:mid])
    right = merge_sort_iter(list[mid:])

    left_val = next(left, None)
    right_val = next(right, None)

    while left_val is not None or right_val is not None:
        if right_val is None or (left_val is not None and left_val <= right_val):
            yield left_val
            left_val = next(left, None)
        else:
            yield right_val
            right_val = next(right, None)


for x in merge_sort_iter([1,3,3,2,1]):
    print(x)

