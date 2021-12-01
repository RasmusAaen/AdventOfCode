import re
from aoc import input_as_lines

def parseInput(c: list[str]) -> dict[list]:
    bags = {}
    for line in c:
        m = re.match(r'^(.+) bags contain no other bags\.$',line)
        if not m is None:
            bags[m.group(1)] = []
            continue
        m = re.match(r'^(.+) bags contain (.+)\.$', line)
        if not m is None:
            cont = []
            for l in m.group(2).split(', '):
                m1 = re.match(r'^(\d+) (.+) bag',l)
                cont.append((int(m1.group(1)), m1.group(2)))
            bags[m.group(1)] = cont
    return bags


def part1(values: list) -> int:
    DP = {}
    res = 0
    bags = parseInput(values)

    def canContain(bag: str, target: str) -> bool:
        if bag in DP:
            return DP[bag]

        if len(bags[bag]) == 0:
            #Bag cannot contain other bags
            DP[bag] = False
            return False
        for b in bags[bag]:
            if b[1] == target:
                DP[bag] = True
                return True
            if canContain(b[1], target):
                DP[bag] = True
                return True
        DP[bag] = False
        return False

    for bag in bags.keys():
        if canContain(bag, 'shiny gold'):
            res += 1

    return res

def part2(values: list[str]) -> int:
    DP = {}
    bags = parseInput(values)

    def countBags(color: str) -> int:
        if color in DP:
            return DP[color]

        cnt = 1
        for bag in bags[color]:
            cnt += bag[0] * countBags(bag[1])

        DP[color] = cnt
        return cnt

    return countBags('shiny gold')-1


def test():
    test_input = """light red bags contain 1 bright white bag, 2 muted yellow bags.
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags.""".split('\n')
    assert part1(test_input) == 4

    test_input = """shiny gold bags contain 2 dark red bags.
dark red bags contain 2 dark orange bags.
dark orange bags contain 2 dark yellow bags.
dark yellow bags contain 2 dark green bags.
dark green bags contain 2 dark blue bags.
dark blue bags contain 2 dark violet bags.
dark violet bags contain no other bags.""".split('\n')
    assert part2(test_input) == 126


if __name__ == "__main__":
    test()
    vals = input_as_lines('C:\\Repos\\Privat\\AdventOfCode\\2020\\python\\input_day7.txt')
    print(f"Part 1: {part1(vals)}")
    print(f"Part 2: {part2(vals)}")
