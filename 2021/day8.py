import itertools
from collections import defaultdict
from aoc import *

def part1(values: list) -> int:
    res = 0
    for line in values:
        sigs, ovals = [x.strip() for x in line.split('|')]
        sigs = sigs.split(' ')
        ovals = ovals.split(' ')
        for v in ovals:
            if len(v) in [2,4,3,7]:
                res += 1
    return res


def part2(values: list) -> int:
    res = 0
    for line in values:
        #line = 'acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf'
        sigs, ovals = [x.strip() for x in line.split('|')]
        sigs = sigs.split(' ')
        ovals = ovals.split(' ')

        segments = ['']*7
        counts = defaultdict(lambda: 0)
        #Count occurrences of each segment
        for i in range(len(sigs)):
            for l in range(len(sigs[i])):
                counts[sigs[i][l]] += 1

        # Segments
        #
        #    0
        #   1 2
        #    3
        #   4 5
        #    6

        #three segments can be identified by count directly
        for k,v in counts.items():
            if v == 9:
                segments[5] = k
            elif v == 6:
                segments[1] = k
            elif v == 4:
                segments[4] = k

        #Look at 1 - we know segment 5 so the other must be segment 2
        for s in sigs:
            if len(s) == 2:
                r = ''
                if s[0] == segments[5]:
                    r = s[1]
                else:
                    r = s[0]
                segments[2] = r
                #only segments 0 and 2 has 8 occurrences
                for k,v in counts.items():
                    if v == 8 and k != r:
                        segments[0] = k
                        break
                break

        #Look at 4 - missing segment must be 3
        for s in sigs:
            if len(s) == 4:
                for i in range(len(s)):
                    if s[i] not in segments:
                        segments[3] = s[i]
                break

        #Look at 8 - missing segment must be 6
        for s in sigs:
            if len(s) == 7:
                for i in range(len(s)):
                    if s[i] not in segments:
                        segments[6] = s[i]
                break

        #Translate segments to numbers
        sig2num = {}
        for p in itertools.permutations([segments[0],segments[1],segments[2],segments[4],segments[5],segments[6]]): sig2num[''.join(p)] = '0'
        for p in itertools.permutations([segments[2],segments[5]]): sig2num[''.join(p)] = '1'
        for p in itertools.permutations([segments[0],segments[2],segments[3],segments[4],segments[6]]): sig2num[''.join(p)] = '2'
        for p in itertools.permutations([segments[0],segments[2],segments[3],segments[5],segments[6]]): sig2num[''.join(p)] = '3'
        for p in itertools.permutations([segments[1],segments[2],segments[3],segments[5]]): sig2num[''.join(p)] = '4'
        for p in itertools.permutations([segments[0],segments[1],segments[3],segments[5],segments[6]]): sig2num[''.join(p)] = '5'
        for p in itertools.permutations([segments[0],segments[1],segments[3],segments[4],segments[5],segments[6]]): sig2num[''.join(p)] = '6'
        for p in itertools.permutations([segments[0],segments[2],segments[5]]): sig2num[''.join(p)] = '7'
        for p in itertools.permutations([segments[0],segments[1],segments[2],segments[3],segments[4],segments[5],segments[6]]): sig2num[''.join(p)] = '8'
        for p in itertools.permutations([segments[0],segments[1],segments[2],segments[3],segments[5],segments[6]]): sig2num[''.join(p)] = '9'

        out = ''
        for v in ovals:
            out += sig2num[v]
        res += int(out)
    return res


def test():
    test_input = ['be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe',
'edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc',
'fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg',
'fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb',
'aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea',
'fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb',
'dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe',
'bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef',
'egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb',
'gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce']
    assert part1(test_input) == 26
    assert part2(test_input) == 61229


if __name__ == "__main__":
    test()
    vals = input_as_lines('C:\\Repos\\Privat\\AdventOfCode\\2021\\input_day8.txt')
    print(f"Part 1: {part1(vals)}")
    print(f"Part 2: {part2(vals)}")
