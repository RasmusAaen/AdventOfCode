from aoc import input_as_string
import re


def part1(values: str) -> int:
    res = 0
    pws = re.findall(r'(\d+)-(\d+) (\w+): (.*)', values)
    for pw in pws:
        cnt = len(re.findall(pw[2], pw[3]))
        if cnt >= int(pw[0]) and cnt <= int(pw[1]):
            res += 1
    return res


def part2(values: list) -> int:
    res = 0
    pws = re.findall(r'(\d+)-(\d+) (\w+): (.*)', values)
    for pw in pws:
        oc = 0
        if pw[3][int(pw[0])-1] == pw[2]:
            oc += 1
        if pw[3][int(pw[1])-1] == pw[2]:
            oc += 1
        if oc == 1:
            res += 1
    return res


def test():
    test_input = '1-3 a: abcde\n1-3 b: cdefg\n2-9 c: ccccccccc'
    assert part1(test_input) == 2
    assert part2(test_input) == 1


if __name__ == "__main__":
    test()
    vals = input_as_string('C:\\Repos\\Privat\\AdventOfCode\\2020\\python\\input_day2.txt')
    print(f"Part 1: {part1(vals)}")
    print(f"Part 2: {part2(vals)}")
