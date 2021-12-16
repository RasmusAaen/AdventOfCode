import collections
import math
from aoc import *

def parPacket(p: str, pos: int, versions: list):

    ver = int(p[pos:pos+3],2)
    pos += 3
    typ = int(p[pos:pos+3],2)
    pos += 3
    versions.append(ver)
    if typ == 4: #literal
        val = ''
        while True:
            grp = p[pos:pos+5]
            val += grp[1:]
            pos += 5
            if grp[0] == '0':
                break
        return int(val, 2), pos

    else:
        vals = []
        lTyp = p[pos:pos+1]
        pos += 1
        if lTyp == '0':
            pLen = int(p[pos:pos+15], 2)
            pos += 15
            orgPos = pos
            while pos < orgPos + pLen:
                pac, pos = parPacket(p, pos, versions)
                vals.append(pac)
            return calc(vals, typ), pos

        else:
            pNum = int(p[pos:pos+11], 2)
            pos += 11
            for _ in range(pNum):
                pac, pos = parPacket(p, pos, versions)
                vals.append(pac)
            return calc(vals, typ), pos

def calc(vals: list, op: int):
    if op == 0:
        return sum(vals)
    elif op == 1:
        return math.prod(vals)
    elif op == 2:
        return min(vals)
    elif op == 3:
        return max(vals)
    elif op == 5:
        return 1 if vals[0] > vals[1] else 0
    elif op == 6:
        return 1 if vals[0] < vals[1] else 0
    elif op == 7:
        return 1 if vals[0] == vals[1] else 0


def part1(values: str) -> int:
    b  =  ''
    for c in values:
        b += f'{int(c,16):04b}'
    ver = []
    _ = parPacket(b, 0, ver)

    return sum(ver)


def part2(values: list) -> int:
    b  =  ''
    for c in values:
        b += f'{int(c,16):04b}'
    ver = []
    res, _ = parPacket(b, 0, ver)

    return res


def test():
    test_input = """8A004A801A8002F478"""
    assert part1(test_input) == 16
    test_input = """9C0141080250320F1802104A08"""
    assert part2(test_input) == 1


if __name__ == "__main__":
    test()
    vals = input_as_string('C:\\Repos\\Privat\\AdventOfCode\\2021\\input_day16.txt')
    print(f"Part 1: {part1(vals)}")
    print(f"Part 2: {part2(vals)}")
