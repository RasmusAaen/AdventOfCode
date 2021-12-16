import re
import itertools
from aoc import *

def parseInput(val: list):
    weapons = []
    weapons.append([8,4,0])
    weapons.append([10,5,0])
    weapons.append([25,6,0])
    weapons.append([40,7,0])
    weapons.append([74,8,0])

    armor = []
    armor.append([0,0,0])
    armor.append([13,0,1])
    armor.append([31,0,2])
    armor.append([53,0,3])
    armor.append([75,0,4])
    armor.append([102,0,5])

    rings = []
    rings.append([0,0,0])
    rings.append([0,0,0])
    rings.append([25,1,0])
    rings.append([50,2,0])
    rings.append([100,3,0])
    rings.append([20,0,1])
    rings.append([40,0,2])
    rings.append([80,0,3])

    hp = re.match(r'Hit Points: (\d+)',val[0]).group(1)
    da = re.match(r'Damage: (\d+)',val[1]).group(1)
    ar = re.match(r'Armor: (\d+)',val[2]).group(1)

    boss = [int(hp),int(da),int(ar)]

    return weapons, armor, rings, boss

def fight(player,boss):
    b = boss[0]
    while True:
        b -= max(1,player[1] - boss[2])
        if b <= 0:
            return True
        player[0] -= max(1, boss[1] - player[2])
        if player[0] <= 0:
            return False

def part1(values: list) -> int:
    weapons, armor, rings, boss = parseInput(values)

    minCost = float('inf')
    for w in weapons:
        for a in armor:
            for r1, r2 in itertools.combinations(rings, 2):
                p = [100,0,0]
                cost = w[0] + a[0] + r1[0] + r2[0]
                p[1] = w[1] + a[1] + r1[1] + r2[1]
                p[2] = w[2] + a[2] + r1[2] + r2[2]
                if fight(p, boss):
                    if cost < minCost:
                        minCost = cost
    return minCost


def part2(values: list) -> int:
    weapons, armor, rings, boss = parseInput(values)

    maxCost = 0
    for w in weapons:
        for a in armor:
            for r1, r2 in itertools.combinations(rings, 2):
                p = [100,0,0]
                cost = w[0] + a[0] + r1[0] + r2[0]
                p[1] = w[1] + a[1] + r1[1] + r2[1]
                p[2] = w[2] + a[2] + r1[2] + r2[2]
                if not fight(p, boss):
                    if cost > maxCost:
                        maxCost = cost
    return maxCost


def test():
    test_input = """""".split('\n')
    assert part1(test_input) == None
    assert part2(test_input) == None


if __name__ == "__main__":
    #test()
    vals = input_as_lines('C:\\Repos\\Privat\\AdventOfCode\\2015\\input_day21.txt')
    print(f"Part 1: {part1(vals)}")
    print(f"Part 2: {part2(vals)}")
