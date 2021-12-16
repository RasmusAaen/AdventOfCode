from collections import defaultdict
from aoc import *


def part1(target: int) -> int:
    houses = defaultdict(int)
    upperBound = 1000000
    for elf in range(1, target):
        for house in range(elf, upperBound, elf):
            houses[house] += elf*10

        if houses[elf] >= target:
            return elf


def part2(target: int) -> int:
    houses = defaultdict(int)
    upperBound = 1000000

    for elf in range(1, target):
        for house in range(elf, min(elf*50+1, upperBound), elf):
            houses[house] += elf*11

        if houses[elf] >= target:
            return elf

def test():
    test_input = """""".split('\n')
    assert part1(120) == 6
    assert part2(120) == 6


if __name__ == "__main__":
    test()
    #vals = input_as_lines('C:\\Repos\\Privat\\AdventOfCode\\2015\\input_day20.txt')
    print(f"Part 1: {part1(36000000)}")
    print(f"Part 2: {part2(36000000)}")
