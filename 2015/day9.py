import re
import itertools
from aoc import *

def part1(values: list) -> int:
    dist = {}
    cities = []
    for line in values:
        a,b,d = re.match(r'^(.+) to (.+) = (\d+)$',line).groups()
        cities += [a,b]
        dist[f'{a} to {b}'] = int(d)
        dist[f'{b} to {a}'] = int(d)

    cities = list(set(cities))

    low = None
    for p in itertools.permutations(cities):
        d = 0
        for i in range(len(p)-1) :
            d += dist[f'{p[i]} to {p[i+1]}']

        if low is None or d < low:
            low = d

    return low

def part2(values: list) -> int:
    dist = {}
    cities = []
    for line in values:
        a,b,d = re.match(r'^(.+) to (.+) = (\d+)$',line).groups()
        cities += [a,b]
        dist[f'{a} to {b}'] = int(d)
        dist[f'{b} to {a}'] = int(d)

    cities = list(set(cities))

    high = None
    for p in itertools.permutations(cities):
        d = 0
        for i in range(len(p)-1) :
            d += dist[f'{p[i]} to {p[i+1]}']

        if high is None or d > high:
            high = d

    return high


def test():
    test_input = """London to Dublin = 464
London to Belfast = 518
Dublin to Belfast = 141""".split('\n')
    assert part1(test_input) == 605
    #assert part2(test_input) == 3

if __name__ == "__main__":
    test()
    vals = input_as_lines('C:\\Repos\\Privat\\AdventOfCode\\2015\\input_day9.txt')
    print(f"Part 1: {part1(vals)}")
    print(f"Part 2: {part2(vals)}")
