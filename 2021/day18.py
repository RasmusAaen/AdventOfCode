import math
import itertools
from aoc import *


def add(a: list[str],b: list[str]) -> list[str]:
    n = []
    n.append('[')
    n.extend(a)
    n.append(',')
    n.extend(b)
    n.append(']')

    return reduce(n)

def mustExplode(a: list[str]) -> bool:
    exp = False
    i = 0
    for l in range(len(a)):
        if a[l] == '[':
            i += 1
        elif a[l] == ']':
            i -= 1
        if i == 5:
            exp = True
            break
    return exp

def explode(a: list[str]) -> list[str]:
    i = 0
    b = []
    for l in range(len(a)):
        if a[l] == '[':
            i += 1
        elif a[l] == ']':
            i -= 1
        if i == 5:
            v1,v2 = a[l+1], a[l+3]
            for j in range(l-1,0,-1):
                if a[j].isdigit():
                    a[j] = str(int(a[j]) + int(v1))
                    break
            for j in range(l+5,len(a)):
                if a[j].isdigit():
                    a[j] = str(int(a[j]) + int(v2))
                    break
            b.extend(a[:l])
            b.append('0')
            b.extend(a[l+5:])
            break
    return b

def mustSplit(a: list[str]) -> bool:
    spl = False
    for l in range(len(a)):
        if a[l].isdigit():
            if int(a[l]) >= 10:
                spl = True
                break
    return spl

def split(a: list[str]) -> list[str]:
    b = []
    for l in range(len(a)):
        if a[l].isdigit():
            if int(a[l]) >= 10:
                b.extend(a[:l])
                b.append('[')
                b.append(str(int(a[l]) // 2))
                b.append(',')
                b.append(str(int(math.ceil(int(a[l]) / 2))))
                b.append(']')
                b.extend(a[l+1:])
                break
    return b

def reduce(a: list[str]) -> list[str]:
    while True:
        changed  = False
        while mustExplode(a):
            changed = True
            a = explode(a)
        if mustSplit(a):
            changed = True
            a = split(a)
        if not changed:
            break
    return a

def getMagnitude(a: list[str]) -> int:
    while len(a) > 1:
        for l in range(len(a)):
            if a[l].isdigit() and a[l+2].isdigit():
                mag = 3*int(a[l]) + 2*int(a[l+2])
                b = []
                b.extend(a[:l-1])
                b.append(str(mag))
                b.extend(a[l+4:])
                a = b
                break
    return int(a[0])


def part1(values: list[str]) -> int:
    v = list(values[0])
    for i in range(1,len(values)):
        v = add(v,list(values[i]))

    return getMagnitude(v)


def part2(values: list) -> int:
    maxMag = 0
    opt = itertools.permutations(values, 2)
    for a,b in opt:
        m = getMagnitude(add(a,b))
        if m > maxMag:
            maxMag = m

    return maxMag


def test():
    test_input = """[[[0,[5,8]],[[1,7],[9,6]]],[[4,[1,2]],[[1,4],2]]]
[[[5,[2,8]],4],[5,[[9,9],0]]]
[6,[[[6,2],[5,6]],[[7,6],[4,7]]]]
[[[6,[0,7]],[0,9]],[4,[9,[9,0]]]]
[[[7,[6,4]],[3,[1,3]]],[[[5,5],1],9]]
[[6,[[7,3],[3,2]]],[[[3,8],[5,7]],4]]
[[[[5,4],[7,7]],8],[[8,3],8]]
[[9,3],[[9,9],[6,[4,9]]]]
[[2,[[7,7],7]],[[5,8],[[9,3],[0,2]]]]
[[[[5,2],5],[8,[3,7]]],[[5,[7,5]],[4,4]]]""".split('\n')
    assert part1(test_input) == 4140
    assert part2(test_input) == 3993


if __name__ == "__main__":
    test()
    vals = input_as_lines('C:\\Repos\\Privat\\AdventOfCode\\2021\\input_day18.txt')
    print(f"Part 1: {part1(vals)}")
    print(f"Part 2: {part2(vals)}")
