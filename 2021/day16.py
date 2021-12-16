from math import prod
from aoc import *

def parPacket(p: str, pos: int, versions: list):

    eval_ops = {
        0:sum,
        1:prod,
        2:min,
        3:max,
        5:lambda v:int(v[0] > v[1]),
        6:lambda v:int(v[0] < v[1]),
        7:lambda v:int(v[0] == v[1])
    }

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
            return eval_ops[typ](vals), pos

        else:
            pNum = int(p[pos:pos+11], 2)
            pos += 11
            for _ in range(pNum):
                pac, pos = parPacket(p, pos, versions)
                vals.append(pac)
            return eval_ops[typ](vals), pos

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
    inp = input_as_string('C:\\Repos\\Privat\\AdventOfCode\\2021\\input_day16.txt')
    print(f"Part 1: {part1(inp)}")
    print(f"Part 2: {part2(inp)}")
