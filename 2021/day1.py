from aoc import input_as_ints

def part1(values: list) -> int:
    incr = 0
    for i in range(1,len(values)):
        if(values[i] > values[i-1]):
            incr += 1
    return incr


def part2(values: list) -> int:
    incr = 0
    for i in range(1,len(values)-2):
        val0 = values[i] + values[i+1] + values[i+2]
        val1 = values[i-1] + values[i] + values[i+1]
        if (val0 > val1):
            incr += 1
    return incr


def test():
    test_input = [199,200,208,210,200,207,240,269,260,263]
    assert part1(test_input) == 7
    assert part2(test_input) == 5

if __name__ == "__main__":
    test()
    vals = input_as_ints('C:\\Repos\\Privat\\AdventOfCode\\2021\\input_day1.txt')
    print(f"Part 1: {part1(vals)}")
    print(f"Part 2: {part2(vals)}")
