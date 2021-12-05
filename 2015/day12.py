import re
import json
from aoc import *

def part1(values: str) -> int:
    return sum(map(int, list(re.findall(r'-?\d+',values))))

def getVals(l):
    cnt = 0
    if isinstance(l,dict):
        ignore = False
        for v in l.values():
            if v == 'red':
                ignore = True
                break
        if ignore:
            return 0

        for v in l.values():
            if isinstance(v, (dict,list)):
                cnt += getVals(v)
            else:
                try:
                    cnt += int(v)
                except:
                    pass
    elif isinstance(l,list):
        for v in l:
            cnt += getVals(v)
    else:
        try:
            cnt += int(l)
        except:
            pass
    return cnt


def part2(values: str) -> int:
    return getVals(json.loads(values))

def test():
    test_input = '[-1,{"a":1}]'
    assert part1(test_input) == 0
    #assert part2(test_input) == 48

if __name__ == "__main__":
    test()
    vals = input_as_string('C:\\Repos\\Privat\\AdventOfCode\\2015\\input_day12.txt')
    print(f"Part 1: {part1(vals)}")
    print(f"Part 2: {part2(vals)}")
