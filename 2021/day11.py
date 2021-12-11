from aoc import *

def flash(i,j,o):

    def incr(i,j):
        if o[i][j] not in [0,10]:
            o[i][j] += 1

    if i-1 >= 0:
        if j-1 >= 0:
            incr(i-1,j-1)
        if j+1 < len(o):
            incr(i-1,j+1)
        incr(i-1,j)
    if j-1 >= 0:
        incr(i,j-1)
    if j+1 < len(o):
        incr(i,j+1)
    if i+1 < len(o):
        if j-1 >= 0:
            incr(i+1,j-1)
        if j+1 < len(o):
            incr(i+1,j+1)
        incr(i+1,j)
    o[i][j] = 0


def part1(values: list, steps: int) -> int:
    res = 0
    o = [list(map(int, list(x))) for x in values]

    for _ in range(steps):
        for i in range(len(o)):
            for j in range(len(o[0])):
                if o[i][j] != 10:
                    o[i][j] += 1

        while sum(x.count(10) for x in o) > 0:
            for i in range(len(o)):
                for j in range(len(o[0])):
                    if o[i][j] == 10:
                        flash(i,j,o)
                        res += 1
    return res


def part2(values: list) -> int:
    o = [list(map(int, list(x))) for x in values]

    step = 1
    while True:
        for i in range(len(o)):
            for j in range(len(o[0])):
                if o[i][j] != 10:
                    o[i][j] += 1

        while sum(x.count(10) for x in o) > 0:
            for i in range(len(o)):
                for j in range(len(o[0])):
                    if o[i][j] == 10:
                        flash(i,j,o)
        if sum(x.count(0) for x in o) == len(o)*len(o[0]):
            return step
        step += 1


def test():
    test_input = """5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526""".split('\n')
    assert part1(test_input, 100) == 1656
    assert part2(test_input) == 195


if __name__ == "__main__":
    test()
    vals = input_as_lines('C:\\Repos\\Privat\\AdventOfCode\\2021\\input_day11.txt')
    print(f"Part 1: {part1(vals, 100)}")
    print(f"Part 2: {part2(vals)}")
