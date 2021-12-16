import re
from aoc import *


def part1(values: list[str], aStart: int = 0) -> int:
    regs = {'a':aStart, 'b':0}
    cur = 0
    while cur < len(values):
        ins = values[cur]
        if ins.startswith('hlf'):
            r = ins[4:]
            regs[r] = regs[r] // 2
            cur += 1
        elif ins.startswith('tpl'):
            r = ins[4:]
            regs[r] = regs[r] * 3
            cur += 1
        elif ins.startswith('inc'):
            r = ins[4:]
            regs[r] += 1
            cur += 1
        elif ins.startswith('jmp'):
            r = re.match(r'jmp ([+-]?\d+)',ins).group(1)
            cur += int(r)
        elif ins.startswith('jie'):
            r,off = re.match(r'jie ([ab]{1}), ([+-]?\d+)',ins).groups()
            if regs[r] % 2 == 0:
                cur += int(off)
            else:
                cur += 1
        elif ins.startswith('jio'):
            r,off = re.match(r'jio ([ab]{1}), ([+-]?\d+)',ins).groups()
            if regs[r] == 1:
                cur += int(off)
            else:
                cur += 1
    return regs['b']



def part2(values: list) -> int:
    return part1(values, 1)


def test():
    test_input = """inc a
jio a, +2
tpl a
inc a""".split('\n')
    assert part1(test_input) == 0
    assert part2(test_input) == 0


if __name__ == "__main__":
    test()
    vals = input_as_lines('C:\\Repos\\Privat\\AdventOfCode\\2015\\input_day23.txt')
    print(f"Part 1: {part1(vals)}")
    print(f"Part 2: {part2(vals)}")
