
def readinput(name: str) -> list:
    with open(name) as f:
        return [int(line) for line in f]


def part1(input: list) -> int:
    for i in range(len(input)):
        for j in range(i, len(input)):
            if(input[i] + input[j] == 2020):
                #print(f"i: {input[i]}, j: {input[j]}")
                return (input[i] * input[j])
    return None


def part2(input: list) -> int:
    for i in range(len(input)):
        for j in range(i, len(input)):
            for k in range(j, len(input)):
                if(input[i] + input[j] + input[k] == 2020):
                    #print(f"i: {input[i]}, j: {input[j]}, j: {input[k]}")
                    return (input[i] * input[j] * input[k])
    return None


def test():
    test_input = [1721, 979, 366, 299, 675, 1456]
    assert part1(test_input) == 514579
    assert part2(test_input) == 241861950

if __name__ == "__main__":
    test()
    vals = readinput('input_day1.txt')
    print(f"Part 1: {part1(vals)}")
    print(f"Part 2: {part2(vals)}")
