import re
from aoc import input_as_lines

def part1(values: list) -> int:
    res = 0
    pos = 0
    depth = 0
    for line in values:
        (d,n) = re.match(r'(\w+) (\d+)',line).groups()
        if d == 'forward':
            pos += int(n)
        elif d == 'down':
            depth += int(n)
        elif d == 'up':
            depth -= int(n)
    res = pos * depth
    return res


def part2(values: list) -> int:
    res = 0
    pos = 0
    depth = 0
    aim = 0
    for line in values:
        (d,n) = re.match(r'(\w+) (\d+)',line).groups()
        if d == 'forward':
            pos += int(n)
            depth += int(n)*aim
        elif d == 'down':
            aim += int(n)
        elif d == 'up':
            aim -= int(n)
    res = pos * depth
    return res


def test():
    test_input = """forward 5
down 5
forward 8
up 3
down 8
forward 2""".split('\n')
    assert part1(test_input) == 150
    assert part2(test_input) == 900

if __name__ == "__main__":
    test()
    vals = input_as_lines('C:\\Repos\\Privat\\AdventOfCode\\2021\\input_day2.txt')
    print(f"Part 1: {part1(vals)}")
    print(f"Part 2: {part2(vals)}")
