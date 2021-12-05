import re
from aoc import input_as_lines

def part1(values: list) -> int:
    bottom = {}
    for i in range(len(values)):
        x, y, x1, y1 = map(int, re.match(r'(\d+),(\d+) -> (\d+),(\d+)', values[i]).groups())
        if x == x1:
            if y > y1:
                y, y1 = y1, y
            for j in range(y,y1+1):
                if (x,j) in bottom:
                    bottom[(x,j)] += 1
                else:
                    bottom[(x,j)] = 1
        elif y == y1:
            if x > x1:
                x, x1 = x1, x
            for j in range(x,x1+1):
                if (j,y) in bottom:
                    bottom[(j,y)] += 1
                else:
                    bottom[(j,y)] = 1

    res = 0
    for v in bottom.values():
        if v >= 2:
            res += 1

    return res


def part2(values: list) -> int:
    bottom = {}
    for i in range(len(values)):
        x, y, x1, y1 = map(int, re.match(r'(\d+),(\d+) -> (\d+),(\d+)', values[i]).groups())
        if x == x1:
            if y > y1:
                y, y1 = y1, y
            for j in range(y,y1+1):
                if (x,j) in bottom:
                    bottom[(x,j)] += 1
                else:
                    bottom[(x,j)] = 1
        elif y == y1:
            if x > x1:
                x, x1 = x1, x
            for j in range(x,x1+1):
                if (j,y) in bottom:
                    bottom[(j,y)] += 1
                else:
                    bottom[(j,y)] = 1
        else:
            xStep = 1
            yStep = 1
            if x > x1:
                xStep = -1
            if y > y1:
                yStep = -1
            for n in zip(range(x,x1+xStep,xStep),range(y,y1+yStep,yStep)):
                if (n) in bottom:
                    bottom[n] += 1
                else:
                    bottom[n] = 1


    res = 0
    for v in bottom.values():
        if v >= 2:
            res += 1

    return res


def test():
    test_input = """0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2""".split('\n')
    assert part1(test_input) == 5
    assert part2(test_input) == 12


if __name__ == "__main__":
    test()
    vals = input_as_lines('C:\\Repos\\Privat\\AdventOfCode\\2021\\input_day5.txt')
    print(f"Part 1: {part1(vals)}")
    print(f"Part 2: {part2(vals)}")
