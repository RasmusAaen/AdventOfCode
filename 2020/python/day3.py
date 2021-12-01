from aoc import input_as_lines

def expandGrid(g: list) -> list:
    out = []
    for i in range(len(g)):
        out.append(str(g[i]*2))
    return out

def part1(values: list) -> int:
    res = 0
    moveRight = 3
    moveDown = 1
    row = 0
    column = 0
    while row < len(values):
        if values[row][column] == '#':
            res += 1
        row += moveDown
        column += moveRight
        if column > len(values[0]):
            values = expandGrid(values)
    return res


def part2(values: list) -> int:
    res = 1
    paths = [(1,1),(3,1),(5,1),(7,1),(1,2)]
    for (moveRight,moveDown) in paths:
        trees = 0
        row = 0
        column = 0
        while row < len(values):
            if values[row][column] == '#':
                trees += 1
            row += moveDown
            column += moveRight
            if column >= len(values[0]):
                values = expandGrid(values)
        res *= trees
    return res


def test():
    test_input = ['..##.......','#...#...#..','.#....#..#.','..#.#...#.#','.#...##..#.','..#.##.....','.#.#.#....#','.#........#','#.##...#...','#...##....#','.#..#...#.#']
    assert part1(test_input) == 7
    assert part2(test_input) == 336


if __name__ == "__main__":
    test()
    vals = input_as_lines('C:\\Repos\\Privat\\AdventOfCode\\2020\\python\\input_day3.txt')
    print(f"Part 1: {part1(vals)}")
    print(f"Part 2: {part2(vals)}")
