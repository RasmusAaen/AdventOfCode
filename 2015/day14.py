import re
from aoc import *

def part1(values: list, time: int) -> int:
    deer = []
    for line in values:
        n,s,t,r = re.match(r'^(\w+) can fly (\d+) km/s for (\d+) seconds, but then must rest for (\d+) seconds\.$',line).groups()
        deer.append([n,int(s),int(t),int(r),0,0])

    for s in range(1,time+1):
        for d in deer:
            if s > d[4]: #not resting
                d[5] += d[1] #fly

                if s >= d[4] + d[2]: #must rest
                    d[4] = s + d[3]

    return max([x[5] for x in deer])

def part2(values: list, time: int) -> int:
    deer = []
    for line in values:
        n,s,t,r = re.match(r'^(\w+) can fly (\d+) km/s for (\d+) seconds, but then must rest for (\d+) seconds\.$',line).groups()
        deer.append([n,int(s),int(t),int(r),0,0,0])

    for s in range(1,time+1):
        for d in deer:
            if s > d[4]: #not resting
                d[5] += d[1] #fly

                if s >= d[4] + d[2]: #must rest
                    d[4] = s + d[3]
        m = max([x[5] for x in deer])
        for d in deer:
            if d[5] == m:
                d[6] += 1

    return max([x[6] for x in deer])

def test():
    test_input = """Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.
Dancer can fly 16 km/s for 11 seconds, but then must rest for 162 seconds.""".split('\n')
    assert part1(test_input, 1000) == 1120
    assert part2(test_input, 1000) == 689

if __name__ == "__main__":
    test()
    vals = input_as_lines('C:\\Repos\\Privat\\AdventOfCode\\2015\\input_day14.txt')
    print(f"Part 1: {part1(vals, 2503)}")
    print(f"Part 2: {part2(vals, 2503)}")
