import re
import numpy
from aoc import *


def part1(values: str) -> int:
    tr,tc = map(int,re.match(r'To continue, please consult the code grid in the manual\.  Enter the code at row (\d+), column (\d+)', values).groups())

    c = r = 1
    val = 20151125
    while True:
        if r == 1:
            r = c+1
            c = 1
        else:
            c += 1
            r -= 1
        val = (val * 252533) % 33554393
        if r == tr and c == tc:
            return val


def part2(values: list) -> int:
    return None


def test():
    test_input = """""".split('\n')
    assert part1(test_input) == None
    assert part2(test_input) == None


if __name__ == "__main__":
    #test()
    vals = input_as_string('C:\\Repos\\Privat\\AdventOfCode\\2015\\input_day25.txt')
    print(f"Part 1: {part1(vals)}")
    print(f"Part 2: {part2(vals)}")
