from aoc import *

def part1(values: list) -> int:
    points = 0
    for line in values:
        seq = []
        for i in range(len(line)):
            if line[i] in ['<','(','[','{']:
                seq.append(line[i])
            elif (seq[-1] == '<' and line[i] == '>' or
                    seq[-1] == '(' and line[i] == ')' or
                    seq[-1] == '[' and line[i] == ']' or
                    seq[-1] == '{' and line[i] == '}'):
                seq.pop()
            else:
                if line[i] == ')':
                    points += 3
                elif line[i] == ']':
                    points += 57
                elif line[i] == '}':
                    points += 1197
                elif line[i] == '>':
                    points += 25137
                break

    return points


def part2(values: list) -> int:
    points = []
    for line in values:
        seq = []
        for i in range(len(line)):
            if line[i] in ['<','(','[','{']:
                seq.append(line[i])
            elif (seq[-1] == '<' and line[i] == '>' or
                    seq[-1] == '(' and line[i] == ')' or
                    seq[-1] == '[' and line[i] == ']' or
                    seq[-1] == '{' and line[i] == '}'):
                seq.pop()
            else:
                break

            if i == len(line)-1:
                sq = 0
                while len(seq) > 0:
                    if seq[-1] == '(':
                        sq = (sq * 5) + 1
                    elif seq[-1] == '[':
                        sq = (sq * 5) + 2
                    elif seq[-1] == '{':
                        sq = (sq * 5) + 3
                    elif seq[-1] == '<':
                        sq = (sq * 5) + 4
                    seq.pop()
                points.append(sq)

    points.sort()
    return points[int(len(points)/2)]


def test():
    test_input = """[({(<(())[]>[[{[]{<()<>>
[(()[<>])]({[<{<<[]>>(
{([(<{}[<>[]}>{[]{[(<()>
(((({<>}<{<{<>}{[]{[]{}
[[<[([]))<([[{}[[()]]]
[{[{({}]{}}([{[{{{}}([]
{<[[]]>}<{[{[{[]{()[[[]
[<(<(<(<{}))><([]([]()
<{([([[(<>()){}]>(<<{{
<{([{{}}[<[[[<>{}]]]>[]]""".split('\n')
    assert part1(test_input) == 26397
    assert part2(test_input) == 288957


if __name__ == "__main__":
    test()
    vals = input_as_lines('C:\\Repos\\Privat\\AdventOfCode\\2021\\input_day10.txt')
    print(f"Part 1: {part1(vals)}")
    print(f"Part 2: {part2(vals)}")
