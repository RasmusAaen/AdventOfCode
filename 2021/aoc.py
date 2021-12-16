# aoc.py
from typing import List


## Input functions
def input_as_string(filename:str) -> str:
    """returns the content of the input file as a string"""
    with open(filename, encoding='utf-8') as f:
        return f.read().rstrip("\n")

def input_as_lines(filename:str) -> List[str]:
    """Return a list where each line in the input file is an element of the list"""
    return input_as_string(filename).split("\n")

def input_as_ints(filename:str) -> List[int]:
    """Return a list where each line in the input file is an element of the list, converted into an integer"""
    lines = input_as_lines(filename)
    line_as_int = lambda l: int(l.rstrip('\n'))
    return list(map(line_as_int, lines))

def input_as_intGrid(filename:str) -> List[List[int]]:
    """Return a grid of integers"""
    lines = input_as_lines(filename)
    return list(list(map(int,row)) for row in lines)


## Helper functions
def getNeighbours4(r, c, h, w):
    #Get valid neighbours for a grid point (up, down, left, right)
    for dr, dc in ((1, 0), (-1, 0), (0, 1), (0, -1)):
        rr, cc = (r + dr, c + dc)
        if 0 <= rr < w and 0 <= cc < h:
            yield rr, cc

def getNeighbours8(r, c, h, w):
    #Get valid neighbours for a grid point (up, down, left, right)
    for dr, dc in ((1, 0), (-1, 0), (0, 1), (0, -1), (1, 1), (-1, -1), (-1, 1), (1, -1)):
        rr, cc = (r + dr, c + dc)
        if 0 <= rr < w and 0 <= cc < h:
            yield rr, cc


## Shortcuts

# A double for loop can be replaced by itertools.product():

#     for r in range(rows):
#         for c in range(cols):
#             grid[r][c] += 1

# can be written as:

#     for r,c in product(range(rows), range(cols)):
#         grid[r][c] += 1
