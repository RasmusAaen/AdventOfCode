import re
import itertools
from aoc import *

def parseInput(v: list) -> dict:
    res = {}
    for i in v:
        n,c,d,f,t,ca = re.match(r'(\w+): capacity (-?\d+), durability (-?\d+), flavor (-?\d+), texture (-?\d+), calories (-?\d+)',i).groups()
        res[n] = {'cap':int(c), 'dur': int(d), 'fla': int(f), 'tex': int(t), 'cal': int(ca)}
    return res

def part1(values: list) -> int:
    ingr = parseInput(values)

    max = 0
    for c in itertools.combinations_with_replacement(ingr.keys(), 100):
        counts = {}
        for i in c:
            if i in counts:
                counts[i] += 1
            else:
                counts[i] = 1

        cap = dur = fla = tex = 0
        for k in counts.keys():
            cap += counts[k] * ingr[k]['cap']
            dur += counts[k] * ingr[k]['dur']
            fla += counts[k] * ingr[k]['fla']
            tex += counts[k] * ingr[k]['tex']

        if cap <0: cap = 0
        if dur <0: dur = 0
        if fla <0: fla = 0
        if tex <0: tex = 0
        res = cap * dur * fla * tex
        if res > max:
            max = res

    return max

def part2(values: list) -> int:
    ingr = parseInput(values)

    max = 0
    for c in itertools.combinations_with_replacement(ingr.keys(), 100):
        counts = {}
        for i in c:
            if i in counts:
                counts[i] += 1
            else:
                counts[i] = 1

        cap = dur = fla = tex = cal = 0
        for k in counts.keys():
            cap += counts[k] * ingr[k]['cap']
            dur += counts[k] * ingr[k]['dur']
            fla += counts[k] * ingr[k]['fla']
            tex += counts[k] * ingr[k]['tex']
            cal += counts[k] * ingr[k]['cal']

        if cap <0: cap = 0
        if dur <0: dur = 0
        if fla <0: fla = 0
        if tex <0: tex = 0
        if cal <0: cal = 0
        res = cap * dur * fla * tex
        if res > max and cal == 500:
            max = res

    return max

def test():
    test_input = """Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8
Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3""".split('\n')
    assert part1(test_input) == 62842880
    assert part2(test_input) == 57600000

if __name__ == "__main__":
    test()
    vals = input_as_lines('C:\\Repos\\Privat\\AdventOfCode\\2015\\input_day15.txt')
    print(f"Part 1: {part1(vals)}")
    print(f"Part 2: {part2(vals)}")
