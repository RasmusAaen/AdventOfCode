import re
from aoc import input_as_lines

def part1(values: list) -> int:
    high = 0
    for bp in values:
        row = list(range(128))
        seat = list(range(8))
        for i in range(0,7):
            if bp[i] == 'F':
                row = row[:len(row)//2]
            elif bp[i] == 'B':
                row = row[len(row)//2:]
        for i in range(7,10):
            if bp[i] == 'L':
                seat = seat[:len(seat)//2]
            elif bp[i] == 'R':
                seat = seat[len(seat)//2:]
        seatId = (row[0] * 8) + seat[0]
        if(seatId > high):
            high = seatId
    return high


def part2(values: list[str]) -> int:
    res = 0
    nums = []
    for bp in values:
        row = list(range(128))
        seat = list(range(8))
        for i in range(0,7):
            if bp[i] == 'F':
                row = row[:len(row)//2]
            elif bp[i] == 'B':
                row = row[len(row)//2:]
        for i in range(7,10):
            if bp[i] == 'L':
                seat = seat[:len(seat)//2]
            elif bp[i] == 'R':
                seat = seat[len(seat)//2:]
        seatId = (row[0] * 8) + seat[0]
        nums.append(seatId)

    nums.sort()
    for i in range(1,len(nums)):
        if nums[i] - nums[i-1] == 2:
            return nums[i]-1
    return res


def test():
    test_input = ['BFFFBBFRRR','FFFBBBFRRR','BBFFBBFRLL']
    assert part1(test_input) == 820
    #assert part2(test_input) == 2


if __name__ == "__main__":
    test()
    vals = input_as_lines('C:\\Repos\\Privat\\AdventOfCode\\2020\\python\\input_day5.txt')
    print(f"Part 1: {part1(vals)}")
    print(f"Part 2: {part2(vals)}")
