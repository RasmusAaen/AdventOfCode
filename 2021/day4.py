import re
from aoc import input_as_lines

def parseInput (values: list):
    nums = list(map(int, values[0].split(',')))
    boards = []

    b1 = []
    for b in values[2:]:
        if b == '':
            boards.append(b1)
            b1 = []
        else:
            b1.append(list(map(int, re.findall(r'\d+',b))))
    boards.append(b1)

    return nums, boards


def hasWon(board: list) -> bool:
    #Check rows
    for r in board:
        if -1 not in r:
            return True

    #Check cols
    for i in range(len(board[0])):
        res = True
        for j in range(len(board)):
            if board[j][i] == -1:
                res = False
                break
        if res:
            return True

    return False


def calcScore(board: list, board1: list, num: int) -> int:
    res = 0
    for i in range(len(board)):
        for j in range(len(board[i])):
            if board1[j][i] == -1:
                res += board[j][i]

    return res * num


def part1(values: list) -> int:
    nums, boards = parseInput(values)

    #initialize boards of -1's to track which numbers has been drawn
    boards1 = []
    for i in range(len(boards)):
        boards1.append([ [-1] * len(boards[0][0]) for _ in range(len(boards[0][0]))])

    for num in nums:
        for b in range(len(boards)):
            for i in range(len(boards[b])):
                for j in range(len(boards[b][i])):
                    if(boards[b][j][i] == num):
                        boards1[b][j][i] = boards[b][j][i]
            if hasWon(boards1[b]):
                return calcScore(boards[b], boards1[b], num)
    return None


def part2(values: list) -> int:
    nums, boards = parseInput(values)
    boards1 = []
    for i in range(len(boards)):
        boards1.append([ [-1] * len(boards[0][0]) for _ in range(len(boards[0][0]))])

    wonBoards = []
    for num in nums:
        for b in range(len(boards)):
            if b in wonBoards:
                continue
            for i in range(len(boards[b])):
                for j in range(len(boards[b][i])):
                    if(boards[b][j][i] == num):
                        boards1[b][j][i] = boards[b][j][i]

            if hasWon(boards1[b]):
                wonBoards.append(b)
            if(len(wonBoards) == len(boards)):
                return calcScore(boards[b], boards1[b], num)
    return None


def test():
    test_input = """7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

22 13 17 11  0
 8  2 23  4 24
21  9 14 16  7
 6 10  3 18  5
 1 12 20 15 19

 3 15  0  2 22
 9 18 13 17  5
19  8  7 25 23
20 11 10 24  4
14 21 16 12  6

14 21 17 24  4
10 16 15  9 19
18  8 23 26 20
22 11 13  6  5
 2  0 12  3  7""".split('\n')
    assert part1(test_input) == 4512
    assert part2(test_input) == 1924


if __name__ == "__main__":
    test()
    vals = input_as_lines('C:\\Repos\\Privat\\AdventOfCode\\2021\\input_day4.txt')
    print(f"Part 1: {part1(vals)}")
    print(f"Part 2: {part2(vals)}")
