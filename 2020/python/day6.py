import re
from aoc import input_as_string

def part1(values: list) -> int:
    res = 0
    for g in values:
        ans = {}
        l = g.replace('\n','')
        for i in range(len(l)):
            if l[i] in ans:
                ans[l[i]] += 1
            else:
                ans[l[i]] = 1
        res += len(ans.keys())
    return res


def part2(values: list[str]) -> int:
    res = 0
    for g in values:
        ans = {}
        pers = g.split('\n')
        for p in pers:
            for i in range(len(p)):
                if p[i] in ans:
                    ans[p[i]] += 1
                else:
                    ans[p[i]] = 1
        for k in ans.keys():
            if(ans[k] == len(pers)):
                res += 1
    return res


def test():
    test_input = """abc

a
b
c

ab
ac

a
a
a
a

b""".split('\n\n')
    assert part1(test_input) == 11
    #assert part2(test_input) == 2


if __name__ == "__main__":
    test()
    vals = input_as_string('C:\\Repos\\Privat\\AdventOfCode\\2020\\python\\input_day6.txt').split('\n\n')
    print(f"Part 1: {part1(vals)}")
    print(f"Part 2: {part2(vals)}")
