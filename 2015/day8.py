from aoc import *

def part1(values: list) -> int:
    chars = sum(len(l) for l in values)
    mem = sum(len(eval(l)) for l in values)
    return chars - mem

def part2(values: list) -> int:
    extra = sum(2+l.count('\\')+l.count('"') for l in values)
    return extra


def test():
    test_input = 'abcdef'
    assert part1(test_input) == 609043
    #assert part2(test_input) == 3

if __name__ == "__main__":
    #test()
    vals = input_as_lines('C:\\Repos\\Privat\\AdventOfCode\\2015\\input_day8.txt')
    print(f"Part 1: {part1(vals)}")
    print(f"Part 2: {part2(vals)}")
