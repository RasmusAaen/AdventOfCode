import collections
from typing import Counter, DefaultDict
from aoc import *

def parseInput(values: list):
    inserts = {}
    seq = values[0].strip()

    for i in range(2,len(values)):
        a,b = values[i].split(' -> ')
        inserts[a] = b

    return inserts, seq

def part1(values: list, rounds: int = 10) -> int:
    ins, seq = parseInput(values)

    for _ in range(rounds):
        newseq = ''
        for i in range(len(seq)-1):
            newseq += seq[i]
            newseq += ins[seq[i:i+2]]
        newseq += seq[-1]
        seq = newseq

    counts = collections.defaultdict(int)
    for ch in seq:
        counts[ch] += 1

    return max(counts.values()) - min(counts.values())



def part2(values: list) -> int:
    ins, seq = parseInput(values)

    charcounts = collections.Counter(seq)
    paircounts = collections.Counter(seq[i:i+2] for i in range(len(seq)-1))
    for _ in range(40):
        newpaircounts = collections.Counter()
        for pair, c in paircounts.items():
            p1, p2 = pair
            newpaircounts[p1+ins[pair]] += c
            newpaircounts[ins[pair]+p2] += c
            charcounts[ins[pair]] += c
        paircounts = newpaircounts

    charcounts = charcounts.most_common()
    return charcounts[0][1] - charcounts[-1][1]


def test():
    test_input = """NNCB

CH -> B
HH -> N
CB -> H
NH -> C
HB -> C
HC -> B
HN -> C
NN -> C
BH -> H
NC -> B
NB -> B
BN -> B
BB -> N
BC -> B
CC -> N
CN -> C""".split('\n')
    assert part1(test_input) == 1588
    assert part2(test_input) == 2188189693529


if __name__ == "__main__":
    test()
    vals = input_as_lines('C:\\Repos\\Privat\\AdventOfCode\\2021\\input_day14.txt')
    print(f"Part 1: {part1(vals)}")
    print(f"Part 2: {part2(vals)}")
