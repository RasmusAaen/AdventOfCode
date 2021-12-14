import re
import numpy
from aoc import *

def parseInput(values: list[str]):
    points = []
    folds = []

    i = 0
    while i < len(values):
        if values[i] != '':
            if values[i].startswith('fold'):
                a,b = re.match(r'^fold along ([xy])=(\d+)',values[i]).groups()
                folds.append((a,int(b)))
            else:
                x,y = map(int, values[i].split(','))
                points.append((x,y))
        i += 1

    maxX = max([x[0] for x in points])
    maxY = max([x[1] for x in points])

    vals = numpy.zeros((maxY+1,maxX+1), dtype=int)
    for p in points:
        vals[p[1]][p[0]] = 1

    return vals, folds

def fold(grid, ax):
    axis = 1
    if ax[0] == 'y':
        axis = 0

    g1, _, g2, _ = numpy.split(grid, [ax[1],ax[1]+1,grid.shape[axis]], axis)
    g2 = numpy.flip(g2, axis)

    if g1.shape[axis] < g2.shape[axis]:
        if axis == 0:
            g1 = numpy.pad(g1,((g2.shape[axis]-g1.shape[axis],0),(0,0)))
        else:
            g1 = numpy.pad(g1,((0,0),(g2.shape[axis]-g1.shape[axis],0)))
    elif g2.shape[axis] < g1.shape[axis]:
        if axis == 0:
            g2 = numpy.pad(g2,((g1.shape[axis]-g2.shape[axis],0),(0,0)))
        else:
            g2 = numpy.pad(g2,((0,0),(g1.shape[axis]-g2.shape[axis],0)))

    return numpy.logical_or(g1,g2).astype(int)


def part1(values: list) -> int:
    vals, folds = parseInput(values)

    v1 = fold(vals, folds[0])
    #v1 = fold(v1, folds[1])

    return numpy.count_nonzero(v1)


def part2(values: list) -> int:
    vals, folds = parseInput(values)
    for f in folds:
        vals = fold(vals, f)
    [print(''.join(map(str,x))) for x in vals]
    return None


def test():
    test_input = """6,10
0,14
9,10
0,3
10,4
4,11
6,0
6,12
4,1
0,13
10,12
3,4
3,0
8,4
1,10
2,14
8,10
9,0

fold along y=7
fold along x=5""".split('\n')
    assert part1(test_input) == 17
    assert part2(test_input) == None


if __name__ == "__main__":
    test()
    vals = input_as_lines('C:\\Repos\\Privat\\AdventOfCode\\2021\\input_day13.txt')
    print(f"Part 1: {part1(vals)}")
    print(f"Part 2: {part2(vals)}")
