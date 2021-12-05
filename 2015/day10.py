from aoc import *

def part1(values: str, it: int) -> int:
    res = values
    for _ in range(it):
        pos = 0
        res = ''
        while pos < len(values):
            cnt = 1
            for j in range(pos+1,len(values)):
                if values[j] == values[pos]:
                    cnt += 1
                else:
                    break

            res += str(cnt) + values[pos]
            pos += cnt
        values = res

    return len(res)

def part2(values: list) -> int:
    return 1

def test():
    test_input = '111221'
    assert part1(test_input, 1) == '312211'
    #assert part2(test_input) == 3

if __name__ == "__main__":
    #test()
    #vals = input_as_lines('C:\\Repos\\Privat\\AdventOfCode\\2015\\input_day10.txt')
    print(f"Part 1: {part1('1113122113', 40)}")
    print(f"Part 2: {part1('1113122113', 50)}")
