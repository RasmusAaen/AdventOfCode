import hashlib
from aoc import input_as_string

def part1(values: str) -> int:
    i = 0
    while True:
        i += 1
        k = values + str(i)
        h = hashlib.md5(k.encode()).hexdigest()
        if h.startswith('00000'):
            return i

def part2(values: str) -> int:
    i = 0
    while True:
        i += 1
        k = values + str(i)
        h = hashlib.md5(k.encode()).hexdigest()
        if h.startswith('000000'):
            return i

def test():
    test_input = 'abcdef'
    assert part1(test_input) == 609043
    #assert part2(test_input) == 3

if __name__ == "__main__":
    test()
    #vals = input_as_string('C:\\Repos\\Privat\\AdventOfCode\\2015\\input_day4.txt')
    print(f"Part 1: {part1('bgvyzdsv')}")
    print(f"Part 2: {part2('bgvyzdsv')}")
