import collections
from aoc import *


def parseInput(v: list[str]):
    paths = collections.defaultdict(set)
    for line in v:
        a,b = line.split('-')
        paths[a].add(b)
        paths[b].add(a)
    return paths


def part1(values: list) -> int:
    res = 0
    paths = parseInput(values)

    def explore(cave: str, visited: set = set()):
        if cave == 'end':
            return 1
        if cave.islower():
            visited = visited.union([cave])

        count = 0
        for dest in paths[cave]:
            if dest not in visited:
                count += explore(dest, visited)
        return count


    res = explore('start')
    return res


def part2(values: list) -> int:
    res = 0
    paths = parseInput(values)

    def explore(cave: str, visited: list = []):
        if cave == 'end':
            return 1
        if cave.islower():
            visited = visited + [cave]

        count = 0
        for dest in paths[cave]:
            if dest != 'start':
                if dest not in visited:
                    if len(visited) == len(set(visited)): #no duplicates yet
                        count += explore(dest, visited)
        return count

    res = explore('start')
    return res


def test():
    test_input = """dc-end
HN-start
start-kj
dc-start
dc-HN
LN-dc
HN-end
kj-sa
kj-HN
kj-dc""".split('\n')
    assert part1(test_input) == 19
    assert part2(test_input) == 103


if __name__ == "__main__":
    test()
    vals = input_as_lines('C:\\Repos\\Privat\\AdventOfCode\\2021\\input_day12.txt')
    print(f"Part 1: {part1(vals)}")
    print(f"Part 2: {part2(vals)}")
