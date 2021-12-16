import collections
from random import shuffle
from aoc import *

def parseInput(vals: list):
    repl = collections.defaultdict(set)
    for line in vals:
        if line == '':
            break
        a,b = line.split(' => ')
        repl[a].add(b)

    mol = vals[-1]

    return repl,mol

def part1(values: list) -> int:
    replace, mol = parseInput(values)

    res = set()
    maxLen = max(map(len, replace.keys()))

    i = 0
    while i < len(mol):
        end = 0
        for j in range(1,maxLen+1):
            m = mol[i:i+j]
            if m in replace:
                end = i+j
                break
        if end == 0:
            #no replace
            i += 1
            continue

        m = mol[i:end]
        for j in replace[m]:
            newMol = mol[:i] + j + mol[end:]
            res.add(newMol)
        i = end

    return len(res)


def part2(values: list) -> int:
    replace, mol = parseInput(values)

    # v1 - brute force calculate all possibillities. It works for the example data but takes way too long
    # maxLen = max(map(len, replace.keys()))
    # stack = [('e',0)]
    # res = []
    # while len(stack) > 0:
    #     stack.sort(key=lambda x:x[1], reverse=True)
    #     m,step = stack.pop()
    #     i = 0
    #     while i < len(m):
    #         end = 0
    #         for j in range(1,maxLen+1):
    #             m1 = m[i:i+j]
    #             if m1 in replace:
    #                 end = i+j
    #                 break
    #         if end == 0:
    #             #no replace
    #             i += 1
    #             continue

    #         m1 = m[i:end]
    #         for j in replace[m1]:
    #             newMol = m[:i] + j + m[end:]
    #             if newMol == mol:
    #                 res.append(step+1)
    #             elif len(newMol) < len(mol):
    #                 stack.append((newMol, step+1))
    #         i = end
    #return min(res)

    replaceList = []
    for k,v in replace.items():
        for v1 in v:
            replaceList.append((k,v1))

    count = shuffles = 0
    m = mol
    tried = []
    while len(m) > 1:
        start = m
        for k,v in replaceList:
            while v in m:
                count += m.count(v)
                m = m.replace(v,k)
        if start == m:
            #no changes - start again
            tried.append(replaceList.copy())
            shuffle(replaceList)
            while replaceList in tried:
                shuffle(replaceList)
            m = mol
            count = 0
            shuffles += 1

    print(f'molecule found after {count} steps and {shuffles} shuffles.')
    return count


def test():
    test_input = """H => HO
H => OH
O => HH

HOHOHO""".split('\n')
    assert part1(test_input) == 7
    test_input = """e => H
e => O
H => HO
H => OH
O => HH

HOHOHO""".split('\n')
    assert part2(test_input) == 6


if __name__ == "__main__":
    test()
    vals = input_as_lines('C:\\Repos\\Privat\\AdventOfCode\\2015\\input_day19.txt')
    print(f"Part 1: {part1(vals)}")
    print(f"Part 2: {part2(vals)}")
