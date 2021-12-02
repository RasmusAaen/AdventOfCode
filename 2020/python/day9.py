import re
from aoc import input_as_ints

def part1(values: list, preamble: int) -> int:
    for i in range(preamble, len(values)):
        found = False
        for j in range(i-preamble, i):
            if found: break
            for k in range(j+1, i):
                if values[j] + values[k] == values[i]:
                    found = True
                    break
        if not found: break

    return values[i]

def part2(values: list[str], target: int) -> int:
    for i in range(len(values)):
        res = [values[i]]
        for j in range(i+1, len(values)):
            res.append(values[j])
            if sum(res) >= target:
                break
        if sum(res) == target:
            break
    res.sort()
    return res[0] + res[-1]


def test():
    test_input = [35,20,15,25,47,40,62,55,65,95,102,117,150,182,127,219,299,277,309,576]
    assert part1(test_input, 5) == 127
    assert part2(test_input, 127) == 62


if __name__ == "__main__":
    test()
    vals = input_as_ints('C:\\Repos\\Privat\\AdventOfCode\\2020\\python\\input_day9.txt')
    print(f"Part 1: {part1(vals, 25)}")
    print(f"Part 2: {part2(vals, 21806024)}")
