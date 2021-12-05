import re
import itertools
from aoc import *

def part1(values: list) -> int:
    idx = {}
    people = []
    for l in values:
        a,d,v,b = re.match(r'^(\w+) would (\w+) (\d+) happiness units by sitting next to (\w+)\.$',l).groups()
        v1 = int(v)
        if d == 'lose':
            v1 = v1*-1
        idx[(a,b)] = v1
        people.append(a)
        people.append(b)

    #get unique list
    people = list(set(people))

    possible = itertools.permutations(people)
    max = 0
    for p in possible:
        score = 0
        for i in range(len(p)):
            if i == len(p)-1:
                score += idx[(p[i], p[0])]
                score += idx[(p[0], p[i])]
            else:
                score += idx[(p[i], p[i+1])]
                score += idx[(p[i+1], p[i])]
        if score > max:
            max = score
    return max

def part2(values: list) -> int:
    idx = {}
    people = []
    for l in values:
        a,d,v,b = re.match(r'^(\w+) would (\w+) (\d+) happiness units by sitting next to (\w+)\.$',l).groups()
        v1 = int(v)
        if d == 'lose':
            v1 = v1*-1
        idx[(a,b)] = v1
        people.append(a)
        people.append(b)

    #get unique list
    people = list(set(people))

    #add myself
    people.append('mySelf')
    for p in people:
        idx[('mySelf',p)] = 0
    for p in people:
        idx[(p, 'mySelf')] = 0


    possible = itertools.permutations(people)
    max = 0
    for p in possible:
        score = 0
        for i in range(len(p)):
            if i == len(p)-1:
                score += idx[(p[i], p[0])]
                score += idx[(p[0], p[i])]
            else:
                score += idx[(p[i], p[i+1])]
                score += idx[(p[i+1], p[i])]
        if score > max:
            max = score
    return max

def test():
    test_input = """Alice would gain 54 happiness units by sitting next to Bob.
Alice would lose 79 happiness units by sitting next to Carol.
Alice would lose 2 happiness units by sitting next to David.
Bob would gain 83 happiness units by sitting next to Alice.
Bob would lose 7 happiness units by sitting next to Carol.
Bob would lose 63 happiness units by sitting next to David.
Carol would lose 62 happiness units by sitting next to Alice.
Carol would gain 60 happiness units by sitting next to Bob.
Carol would gain 55 happiness units by sitting next to David.
David would gain 46 happiness units by sitting next to Alice.
David would lose 7 happiness units by sitting next to Bob.
David would gain 41 happiness units by sitting next to Carol.""".split('\n')
    assert part1(test_input) == 330
    #assert part2(test_input) == 48

if __name__ == "__main__":
    test()
    vals = input_as_lines('C:\\Repos\\Privat\\AdventOfCode\\2015\\input_day13.txt')
    print(f"Part 1: {part1(vals)}")
    print(f"Part 2: {part2(vals)}")
