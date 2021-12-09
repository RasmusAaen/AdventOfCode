from aoc import *

def part1(values: list) -> int:
    low = []
    for y in range(len(values)):
        for x in range(len(values[0])):
            isLow = True
            if y > 0:
                if values[y-1][x] <= values[y][x]:
                    isLow = False
            if y != len(values)-1:
                if values[y+1][x] <= values[y][x]:
                    isLow = False
            if x > 0:
                if values[y][x-1] <= values[y][x]:
                    isLow = False
            if x != len(values[0])-1:
                if values[y][x+1] <= values[y][x]:
                    isLow = False
            if isLow:
                low += values[y][x]


    return sum(map(int, low)) + len(low)


def part2(values: list) -> int:
    low = []
    for y in range(len(values)):
        for x in range(len(values[0])):
            isLow = True
            if y > 0:
                if values[y-1][x] <= values[y][x]:
                    isLow = False
            if y != len(values)-1:
                if values[y+1][x] <= values[y][x]:
                    isLow = False
            if x > 0:
                if values[y][x-1] <= values[y][x]:
                    isLow = False
            if x != len(values[0])-1:
                if values[y][x+1] <= values[y][x]:
                    isLow = False
            if isLow:
                low.append((y,x))

    def getBasin(y: int, x: int, last: set, values: list) -> list:
        basin = [(y,x)]
        if y > 0:
            if (y-1,x) != last:
                if values[y-1][x] != '9' and values[y-1][x] > values[y][x]:
                    basin.extend(getBasin(y-1, x, (y,x), values))
        if y != len(values)-1:
            if (y+1,x) != last:
                if values[y+1][x] != '9' and values[y+1][x] > values[y][x]:
                    basin.extend(getBasin(y+1, x, (y,x), values))
        if x > 0:
            if (y,x-1) != last:
                if values[y][x-1] != '9' and values[y][x-1] > values[y][x]:
                    basin.extend(getBasin(y, x-1, (y,x), values))
        if x != len(values[0])-1:
            if (y,x+1) != last:
                if values[y][x+1] != '9' and values[y][x+1] > values[y][x]:
                    basin.extend(getBasin(y, x+1, (y,x), values))

        return list(set(basin)) #get unique

    basins = []
    for y,x in low:
        basins.append(getBasin(y,x,(-1,-1),values))

    basins.sort(key=len)

    return len(basins[-1]) * len(basins[-2]) * len(basins[-3])


def test():
    test_input = """2199943210
3987894921
9856789892
8767896789
9899965678""".split('\n')
    assert part1(test_input) == 15
    assert part2(test_input) == 1134


if __name__ == "__main__":
    test()
    vals = input_as_lines('C:\\Repos\\Privat\\AdventOfCode\\2021\\input_day9.txt')
    print(f"Part 1: {part1(vals)}")
    print(f"Part 2: {part2(vals)}")
