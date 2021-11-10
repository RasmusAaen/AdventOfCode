
def readfile(name: str) -> list:
    with open(name, encoding='utf-8') as file:
        return [int(line) for line in file]


def part1(values: list) -> int:
    return None


def part2(values: list) -> int:
    return None


def test():
    test_input = []
    assert part1(test_input) == 0
    assert part2(test_input) == 0

if __name__ == "__main__":
    test()
    vals = readfile('input_day1.txt')
    print(f"Part 1: {part1(vals)}")
    #print(f"Part 2: {part2(vals)}")
