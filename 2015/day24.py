from functools import reduce
import itertools
import operator
import numpy
from aoc import *


def part1(values: list[int]) -> int:
    w = sum(values) // 3
    l = []
    for i in range(1,len(values)):
        for f in itertools.combinations(values, i):
            if sum(f) == w:
                rest = numpy.setdiff1d(values,f)
                valid = False
                for j in range(1,len(rest)):
                    for g in itertools.combinations(rest,j):
                        if sum(g) == w:
                            rest1 = numpy.setdiff1d(rest,g)
                            if sum(rest1) == w:
                                l.append(f)
                                valid = True
                                break
                    if valid:
                        break
        if len(l) > 0:
            break

    def getProd(a):
        return reduce(operator.mul, a, 1)

    l.sort(key=getProd)
    return getProd(l[0])



def part2(values: list[int]) -> int:
    w = sum(values) // 4
    l = []
    for i in range(1,len(values)):
        for f in itertools.combinations(values, i):
            if sum(f) == w:
                rest = numpy.setdiff1d(values,f)
                valid = False
                for j in range(1,len(rest)):
                    for g in itertools.combinations(rest,j):
                        if sum(g) == w:
                            rest1 = numpy.setdiff1d(rest,g)
                            for k in range(1,len(rest1)):
                                for h in itertools.combinations(rest1,k):
                                    if sum(h) == w:
                                        rest2 = numpy.setdiff1d(rest1,h)
                                        if sum(rest2) == w:
                                            l.append(f)
                                            valid = True
                                            break
                                if valid:
                                    break
                            if valid:
                                break
                    if valid:
                        break
        if len(l) > 0:
            break

    def getProd(a):
        return reduce(operator.mul, a, 1)

    l.sort(key=getProd)
    return getProd(l[0])


def test():
    test_input = """""".split('\n')
    assert part1(test_input) == None
    assert part2(test_input) == None


if __name__ == "__main__":
    #test()
    vals = input_as_ints('C:\\Repos\\Privat\\AdventOfCode\\2015\\input_day24.txt')
    print(f"Part 1: {part1(vals)}")
    print(f"Part 2: {part2(vals)}")
