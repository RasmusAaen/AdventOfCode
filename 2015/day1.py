from aoc import input_as_string

def part1(values: str) -> int:
    floor = 0
    for i in range(len(values)):
        if values[i] == '(':
            floor += 1
        elif values[i] == ')':
            floor -= 1
    return floor


def part2(values: list) -> int:
    floor = 0
    for i in range(len(values)):
        if values[i] == '(':
            floor += 1
        elif values[i] == ')':
            floor -= 1
        if floor == -1:
            return i+1

def test():
    test_input = '(()))('
    assert part1(test_input) == 0
    assert part2(test_input) == 5

if __name__ == "__main__":
    test()
    vals = input_as_string('C:\\Repos\\Privat\\AdventOfCode\\2015\\input_day1.txt')
    print(f"Part 1: {part1(vals)}")
    print(f"Part 2: {part2(vals)}")
