import re
from aoc import *


def part1(values: str, isPart2: bool = False) -> int:
    tx1,tx2,ty1,ty2 = map(int, re.match(r'^target area: x=([+-]?\d+)\.\.([+-]?\d+), y=([+-]?\d+)\.\.([+-]?\d+)$', values).groups())
    target = []
    for x in range(tx1, tx2+1):
        for y in range(ty1, ty2+1):
            target.append((x,y))

    valid = []
    maxY = x = 0
    while x <= tx2:
        y = ty1
        while y <= abs(ty1):
            pos = (0,0)
            vel = [x,y]
            pMaxY = 0
            hit = False
            while pos[0] < tx2 and pos[1] > ty1:
                pos = (pos[0] + vel[0], pos[1] + vel[1])
                if vel[0] > 0:
                    vel[0] -= 1
                elif vel[0] < 0:
                    vel[0] += 1
                vel[1] -= 1
                if pos[1] > pMaxY:
                    pMaxY = pos[1]
                if pos in target:
                    hit = True
                    break
            y += 1
            if hit:
                valid.append(vel)
                if pMaxY > maxY:
                    maxY = pMaxY
        x += 1
    if isPart2:
        return len(valid)
    return maxY


def part2(values: list) -> int:
    return part1(values, True)


def test():
    test_input = """target area: x=20..30, y=-10..-5"""
    assert part1(test_input) == 45
    assert part2(test_input) == 112


if __name__ == "__main__":
    test()
    vals = input_as_string('C:\\Repos\\Privat\\AdventOfCode\\2021\\input_day17.txt')
    print(f"Part 1: {part1(vals)}")
    print(f"Part 2: {part2(vals)}")
