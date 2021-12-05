import re
from aoc import *

def hasStraight(val: str) -> bool:
    i = 0
    while i < len(val)-2:
        if val[i+1] == chr(ord(val[i])+1):
            if val[i+2] == chr(ord(val[i+1])+1):
                return True
        i += 1
    return False

def hasInvalid(val: str) -> bool:
    if re.findall(r'[iol]+',val):
        return True
    return False

def hasRepeat(val: str) -> bool:
    cnt = i = 0
    c = ''
    while i < len(val)-1 and cnt < 2:
        if val[i] == val[i+1] and val[i] != c:
            cnt += 1
            i += 1
            c = [val[i]]
        i += 1
    return cnt == 2

def isValid(val: str) -> bool:
    if hasStraight(val) and not hasInvalid(val) and hasRepeat(val):
        return True
    return False

def increase(val: str) -> str:
    pos = -1
    p = list(val)
    while pos >= len(p)*-1:
        if p[pos] != 'z':
            p[pos] = chr(ord(p[pos])+1)
            break
        else:
            p[pos] = 'a'
            pos -= 1
    return "".join(p)

def part1(val: str) -> int:
    p = val
    while True:
        p = increase(p)
        if isValid(p):
            return p

def part2(values: list) -> int:
    return 1

def test():
    test_input = 'abcdefgh'
    assert part1(test_input) == 'abcdffaa'
    #assert part2(test_input) == 3

if __name__ == "__main__":
    test()
    #vals = input_as_lines('C:\\Repos\\Privat\\AdventOfCode\\2015\\input_day11.txt')
    print(f"Part 1: {part1('hepxcrrq')}")
    print(f"Part 2: {part1('hepxxyzz')}")
