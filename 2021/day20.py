import collections
from copy import deepcopy
from aoc import *

def parseInput(values: list[str]):
    alg = list(map(lambda x: 0 if x == '.' else 1, values[0].strip()))

    img = collections.defaultdict(int)
    for r in range(2,len(values)):
        for c in range(len(values[r])):
            img[r-2,c] = 0 if values[r][c] == '.' else 1

    return alg, img


def part1(values: list, rounds: int = 2) -> int:
    alg, img = parseInput(values)

    for enh in range(rounds):
        minR = min(map(lambda x: x[0], img.keys()))
        minC = min(map(lambda x: x[1], img.keys()))
        maxR = max(map(lambda x: x[0], img.keys()))
        maxC = max(map(lambda x: x[1], img.keys()))

        out = collections.defaultdict(lambda: 1 if alg[0] == 1 and enh % 2 == 1 else 0)

        for r in range(minR-1, maxR+2):
            for c in range(minC-1, maxC+2):
                n = ''
                for dr, dc in ((-1,-1),(-1,0),(-1,1),(0,-1),(0,0),(0,1),(1,-1),(1, 0),(1,1)):
                    n += str(img[r + dr,c + dc])
                out[r,c] = alg[int(n, 2)]
        img = deepcopy(out)

    return list(img.values()).count(1)


def part2(values: list) -> int:
    return part1(values, 50)


def test():
    test_input = """..#.#..#####.#.#.#.###.##.....###.##.#..###.####..#####..#....#..#..##..###..######.###...####..#..#####..##..#.#####...##.#.#..#.##..#.#......#.###.######.###.####...#.##.##..#..#..#####.....#.#....###..#.##......#.....#..#..#..##..#...##.######.####.####.#.#...#.......#..#.#.#...####.##.#......#..#...##.#.##..#...##.#.##..###.#......#.#.......#.#.#.####.###.##...#.....####.#..#..#.##.#....##..#.####....##...##..#...#......#.#.......#.......##..####..#...#.#.#...##..#.#..###..#####........#..####......#..#

#..#.
#....
##..#
..#..
..###""".split('\n')
    assert part1(test_input) == 35
    assert part2(test_input) == 3351


if __name__ == "__main__":
    test()
    vals = input_as_lines('C:\\Repos\\Privat\\AdventOfCode\\2021\\input_day20.txt')
    print(f"Part 1: {part1(vals)}")
    print(f"Part 2: {part2(vals)}")
