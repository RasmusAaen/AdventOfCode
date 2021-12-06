import re
from aoc import *

def part1(values: list, days: int) -> int:
    fish = values.copy()
    for i in range(days):
        new = []
        for f in range(len(fish)):
            if fish[f] == 0:
                fish[f] = 6
                new.append(8)
            else:
                fish[f] -= 1
        fish.extend(new)
    return len(fish)


def part2(values: list, days: int) -> int:
    now = [0]*9
    for f in values:
        now[f] += 1

    for _ in range(days):
        next = [0]*9
        next[6] = next[8] = now[0]
        for i in range(len(now)):
            next[i] += now[i+1]
        now = next

    return sum(now)


def test():
    test_input = [3,4,3,1,2]
    assert part1(test_input, 80) == 5934
    assert part2(test_input, 256) == 26984457539


if __name__ == "__main__":
    test()
    vals = input_as_string('C:\\Repos\\Privat\\AdventOfCode\\2021\\input_day6.txt')
    vals = [int(x) for x in vals.split(',')]
    print(f"Part 1: {part1(vals, 80)}")
    print(f"Part 2: {part2(vals, 256)}")
