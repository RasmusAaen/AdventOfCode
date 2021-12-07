import re
from aoc import *

def part1(values: list) -> int:
    res = 0
    for i in range(len(values)):
        val = 0
        for j in range(len(values)):
            val += abs(values[j]-i)
        if res == 0 or val < res:
            res = val
    return res


def part2(values: list) -> int:
    res = 0
    for i in range(len(values)):
        val = 0
        for j in range(len(values)):
            val += sum(list(range(abs(values[j]-i)+1)))
        if res == 0 or val < res:
            res = val
    return res


def test():
    test_input = [16,1,2,0,4,2,7,1,2,14]
    assert part1(test_input) == 37
    assert part2(test_input) == 168


if __name__ == "__main__":
    test()
    vals = input_as_string('C:\\Repos\\Privat\\AdventOfCode\\2021\\input_day7.txt')
    vals = [int(x) for x in vals.split(',')]
    print(f"Part 1: {part1(vals)}")
    print(f"Part 2: {part2(vals)}")
