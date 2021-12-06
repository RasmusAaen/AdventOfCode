import re
import itertools
from aoc import *

def part1(values: list, tot: int) -> int:
    cnt =0
    for i in range(len(values)):
        subTotal = 0
        for p in itertools.combinations(values,i):
            if sum(p) == tot:
                subTotal += 1
        cnt += subTotal
    return cnt

def part2(values: list, tot: int) -> int:
    cnt =0
    for i in range(len(values)):
        subTotal = 0
        for p in itertools.combinations(values,i):
            if sum(p) == tot:
                subTotal += 1
        if subTotal > 0:
            return subTotal
    return None

def test():
    test_input = [20, 15, 10, 5, 5]
    assert part1(test_input, 25) == 4
    #assert part2(test_input) == 0

if __name__ == "__main__":
    test()
    vals = input_as_ints('C:\\Repos\\Privat\\AdventOfCode\\2015\\input_day17.txt')
    print(f"Part 1: {part1(vals, 150)}")
    print(f"Part 2: {part2(vals, 150)}")
