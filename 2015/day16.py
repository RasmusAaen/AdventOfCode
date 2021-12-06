import re
import itertools
from aoc import *

def parseInput(val: list) -> dict:
    res = {}
    for line in val:
        n,i1,v1,i2,v2,i3,v3 = re.match(r'Sue (\d+): (\w+): (\d+), (\w+): (\d+), (\w+): (\d+)', line).groups()
        res[int(n)] = {i1:int(v1),i2:int(v2),i3:int(v3)}

    return res

def part1(values: list) -> int:
    sues = parseInput(values)
    right = {'children':3,'cats':7,'samoyeds':2,'pomeranians':3,'akitas':0,'vizslas':0,'goldfish':5,'trees':3,'cars':2,'perfumes':1}
    for sue,props in sues.items():
        found = True
        for prop in props:
            if sues[sue][prop] != right[prop]:
                found = False
                break
        if found:
            return sue
    return None

def part2(values: list) -> int:
    sues = parseInput(values)
    right = {'children':3,'cats':7,'samoyeds':2,'pomeranians':3,'akitas':0,'vizslas':0,'goldfish':5,'trees':3,'cars':2,'perfumes':1}
    more = ['trees','cats']
    less = ['pomeranians','goldfish']
    for sue,props in sues.items():
        found = True
        for prop in props:
            if prop in more:
                if sues[sue][prop] <= right[prop]:
                    found = False
                    break
            elif prop in less:
                if sues[sue][prop] >= right[prop]:
                    found = False
                    break
            else:
                if sues[sue][prop] != right[prop]:
                    found = False
                    break
        if found:
            return sue
    return None

def test():
    test_input = ''
    assert part1(test_input) == 0
    assert part2(test_input) == 0

if __name__ == "__main__":
    #test()
    vals = input_as_lines('C:\\Repos\\Privat\\AdventOfCode\\2015\\input_day16.txt')
    print(f"Part 1: {part1(vals)}")
    print(f"Part 2: {part2(vals)}")
