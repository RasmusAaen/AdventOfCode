import re
import copy
from collections import defaultdict
from aoc import *

def part1(values: list, rounds: int) -> int:
    lights = []
    for v in values:
        lights.append(list(v))

    for _ in range(rounds):
        newLights = copy.deepcopy(lights)
        for y in range(len(values)):
            for x in range(len(values[0])):
                #count neighbours that are on - mind edges
                neighbours = 0
                if x-1 >= 0:
                    if y-1 >= 0:
                        if lights[x-1][y-1] == '#': neighbours += 1
                    if y+1 < len(values):
                        if lights[x-1][y+1] == '#': neighbours += 1
                    if lights[x-1][y] == '#': neighbours += 1
                if y-1 >= 0:
                    if lights[x][y-1] == '#': neighbours += 1
                if y+1 < len(values):
                    if lights[x][y+1] == '#': neighbours += 1
                if x+1 < len(values):
                    if y-1 >= 0:
                        if lights[x+1][y-1] == '#': neighbours += 1
                    if y+1 < len(values):
                        if lights[x+1][y+1] == '#': neighbours += 1
                    if lights[x+1][y] == '#': neighbours += 1

                #Check if state should change
                if lights[x][y] == '#':
                    if neighbours not in (2,3):
                        newLights[x][y] = '.'
                else:
                    if neighbours == 3:
                        newLights[x][y] = '#'

        lights = newLights

    cnt = 0
    for y in range(len(values)):
        for x in range(len(values[0])):
            if lights[x][y] == '#':
                cnt += 1

    return cnt

def part2(values: list, rounds: int) -> int:
    lights = []
    for v in values:
        lights.append(list(v))

    for _ in range(rounds):
        newLights = copy.deepcopy(lights)
        for y in range(len(values)):
            for x in range(len(values[0])):
                #count neighbours that are on - mind edges
                neighbours = 0
                if x-1 >= 0:
                    if y-1 >= 0:
                        if lights[x-1][y-1] == '#': neighbours += 1
                    if y+1 < len(values):
                        if lights[x-1][y+1] == '#': neighbours += 1
                    if lights[x-1][y] == '#': neighbours += 1
                if y-1 >= 0:
                    if lights[x][y-1] == '#': neighbours += 1
                if y+1 < len(values):
                    if lights[x][y+1] == '#': neighbours += 1
                if x+1 < len(values):
                    if y-1 >= 0:
                        if lights[x+1][y-1] == '#': neighbours += 1
                    if y+1 < len(values):
                        if lights[x+1][y+1] == '#': neighbours += 1
                    if lights[x+1][y] == '#': neighbours += 1

                #Check if state should change
                if (x,y) not in [(0,0),(0,len(values)-1),(len(values)-1,0), (len(values)-1,len(values)-1)]:
                    if lights[x][y] == '#':
                        if neighbours not in (2,3):
                            newLights[x][y] = '.'
                    else:
                        if neighbours == 3:
                            newLights[x][y] = '#'

        lights = newLights

    cnt = 0
    for y in range(len(values)):
        for x in range(len(values[0])):
            if lights[x][y] == '#':
                cnt += 1

    return cnt

def test():
    test_input = """.#.#.#
...##.
#....#
..#...
#.#..#
####..""".split('\n')
    assert part1(test_input,4) == 4
    test_input = """##.#.#
...##.
#....#
..#...
#.#..#
####.#""".split('\n')
    assert part2(test_input, 5) == 17

if __name__ == "__main__":
    test()
    vals = input_as_lines('C:\\Repos\\Privat\\AdventOfCode\\2015\\input_day18.txt')
    print(f"Part 1: {part1(vals, 100)}")
    print(f"Part 2: {part2(vals, 100)}")
