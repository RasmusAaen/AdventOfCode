import math
from aoc import input_as_lines

def part1(values: list) -> int:
    res = 0
    gamma = []
    epsilon = []
    for i in range(len(values[1])):
        col = 0
        for j in range(len(values)):
            col += int(values[j][i])
        if col <= math.floor(len(values)/2):
            gamma.append('0')
            epsilon.append('1')
        else:
            gamma.append('1')
            epsilon.append('0')
    res = int(''.join(gamma), 2) * int(''.join(epsilon), 2)
    return res


def part2(values: list) -> int:
    res = 0

    def fliterList(l: list, pos: int, t: str) -> list:
        com = 0
        for i in range(len(l)):
            com += int(l[i][pos])
        if com < math.ceil(len(l)/2):
            common = '0'
        else:
            common = '1'
        l1 = []
        for i in range(len(l)):
            if t == 'oxygen':
                if l[i][pos] == common:
                    l1.append(l[i])
            elif t == 'co2':
                if l[i][pos] != common:
                    l1.append(l[i])
        if len(l1) == 1:
            return l1
        return fliterList(l1, pos + 1, t)

    oxygen = fliterList(values, 0, 'oxygen')[0]
    co2 = fliterList(values, 0, 'co2')[0]
    res = int(''.join(oxygen), 2) * int(''.join(co2), 2)
    return res


def test():
    test_input = """00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010""".split('\n')
    assert part1(test_input) == 198
    assert part2(test_input) == 230

if __name__ == "__main__":
    test()
    vals = input_as_lines('C:\\Repos\\Privat\\AdventOfCode\\2021\\input_day3.txt')
    print(f"Part 1: {part1(vals)}")
    print(f"Part 2: {part2(vals)}")
