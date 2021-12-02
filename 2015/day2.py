import math
from aoc import input_as_lines

def part1(values: str) -> int:
    paper = 0
    for gift in values:
        (w,h,l) = map(int, gift.split('x'))
        sides = list((2*l*w, 2*w*h, 2*h*l))
        sides.sort()
        paper += sum(sides)+int(sides[0]/2)
    return paper


def part2(values: str) -> int:
    ribbon = 0
    for gift in values:
        dim = list(map(int, gift.split('x')))
        dim.sort()
        ribbon += (dim[0]*2) + (dim[1]*2) + math.prod(dim)
    return ribbon

def test():
    test_input = ['2x3x4','1x1x10']
    assert part1(test_input) == 101
    assert part2(test_input) == 48

if __name__ == "__main__":
    test()
    vals = input_as_lines('C:\\Repos\\Privat\\AdventOfCode\\2015\\input_day2.txt')
    print(f"Part 1: {part1(vals)}")
    print(f"Part 2: {part2(vals)}")
