import re
import operator
from aoc import *

def part1(values: list, wOut: str) -> int:
    #Read ops
    machine = {}
    for line in values:
        m = (
            re.match(r'(\w+) -> (\w+)', line)
            or re.match(r'(\w+) (\w+) (\w+) -> (\w+)', line)
            or re.match(r'(\w+) (\w+) -> (\w+)', line)
        ).groups()
        machine[m[-1]] = m[:-1]

    #Define operations
    monops = {
        'NOT': lambda x : ~x & 0xFFFF,
    }
    binops = {
        'AND': operator.and_,
        'OR': operator.or_,
        'LSHIFT': operator.lshift,
        'RSHIFT': operator.rshift,
    }

    def evaluate(v):
        try:
            return int(v)
        except:
            return run(v)

    def run(reg, state = {}):
        if not reg in state:
            cmd = machine[reg]

            if len(cmd) == 1:
                input1, = cmd
                state[reg] = evaluate(input1)
            elif len(cmd) == 2:
                monop, input1 = cmd
                state[reg] = monops[monop](evaluate(input1))
            elif len(cmd) == 3:
                input1, binop, input2 = cmd
                state[reg] = binops[binop](evaluate(input1),evaluate(input2))
        return state[reg]

    return run(wOut)

def part2(values: list, wOut: str) -> int:
    values.append('956 -> b')
    return part1(values, wOut)

def test():
    test_input = """123 -> x
456 -> y
x AND y -> d
x OR y -> e
x LSHIFT 2 -> f
y RSHIFT 2 -> g
NOT x -> h
NOT y -> i""".split('\n')
    assert part1(test_input, 'f') == 492
    #assert part2(test_input) == 3

if __name__ == "__main__":
    test()
    vals = input_as_lines('C:\\Repos\\Privat\\AdventOfCode\\2015\\input_day7.txt')
    print(f"Part 1: {part1(vals, 'a')}")
    print(f"Part 2: {part2(vals, 'a')}")
