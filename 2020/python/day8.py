import re
from aoc import input_as_lines

def part1(values: list) -> int:
    ins = 0
    acc = 0
    run = []
    while True:
        if ins in run:
            break
        run.append(ins)
        (op, v) = re.match(r'^(\w+) ([+-]\d+)$',values[ins]).groups()
        if op == 'nop':
            ins += 1
            continue
        if op == 'acc':
            acc += int(v)
            ins += 1
            continue
        if op == 'jmp':
            ins += int(v)
            continue
    return acc

def part2(values: list[str]) -> int:
    changeInstr = 0
    while changeInstr < len(values):
        # Replace operation
        aList = values.copy()
        found = False
        (op, v) = re.match(r'^(\w+) ([+-]\d+)$',aList[changeInstr]).groups()
        if op == 'nop':
            aList[changeInstr] = f"jmp {v}"
            found = True
        elif op == 'jmp':
            aList[changeInstr] = f"nop {v}"
            found = True
        if found:
            #Try running the program to see if it works
            ins = 0
            acc = 0
            run = []
            while True:
                if ins >= len(aList):
                    return acc
                if ins in run:
                    break
                run.append(ins)
                (op, v) = re.match(r'^(\w+) ([+-]\d+)$',aList[ins]).groups()
                if op == 'nop':
                    ins += 1
                    continue
                if op == 'acc':
                    acc += int(v)
                    ins += 1
                    continue
                if op == 'jmp':
                    ins += int(v)
                    continue

        changeInstr += 1


def test():
    test_input = """nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6""".split('\n')
    assert part1(test_input) == 5
    assert part2(test_input) == 8


if __name__ == "__main__":
    test()
    vals = input_as_lines('C:\\Repos\\Privat\\AdventOfCode\\2020\\python\\input_day8.txt')
    print(f"Part 1: {part1(vals)}")
    print(f"Part 2: {part2(vals)}")
