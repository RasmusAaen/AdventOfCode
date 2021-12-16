import collections
import heapq
from aoc import *


def getNeighbours(r, c, h, w):
    #Get valid neighbours for a grid point (up, down, left, right)
    for dr, dc in ((1, 0), (-1, 0), (0, 1), (0, -1)):
        rr, cc = (r + dr, c + dc)
        if 0 <= rr < w and 0 <= cc < h:
            yield rr, cc

def dijkstra(grid):
    h, w = len(grid), len(grid[0])
    source = (0, 0)
    destination = (h - 1, w - 1)

    # Start with only the source in our queue of nodes to visit and in the
    # mindist dictionary, with distance 0.
    queue = [(0, source)]
    mindist = collections.defaultdict(lambda: float('inf'), {source: 0})
    visited = set()

    while queue:
        # Get the node with lowest distance from the queue (and its distance)
        dist, node = heapq.heappop(queue)

        # If we got to the destination, we have our answer.
        if node == destination:
            return dist

        # If we already visited this node, skip it, proceed to the next one.
        if node in visited:
            continue

        # Mark the node as visited.
        visited.add(node)
        r, c = node

        # For each neighbor of this node:
        for neighbor in getNeighbours(r, c, h, w):
            # Calculate the total distance from the source to this neighbor
            # passing through this node.
            nr, nc  = neighbor
            newdist = dist + grid[nr][nc]

            # If the new distance is lower than the minimum distance we have to
            # reach this neighbor, then update its minimum distance and add it
            # to the queue, as we found a "better" path to it.
            if newdist < mindist[neighbor]:
                mindist[neighbor] = newdist
                heapq.heappush(queue, (newdist, neighbor))

    # If we ever empty the queue without entering the node == destination check
    # in the above loop, there is no path from source to destination!
    return float('inf')

def part1(values: list) -> int:
    grid = list(list(map(int,row)) for row in values)

    return dijkstra(grid)


def part2(values: list) -> int:
    grid = list(list(map(int,row)) for row in values)

    gridW = len(grid[0])
    gridH = len(grid)

    for _ in range(4):
        for row in grid:
            tail = row[-gridW:]
            for n in tail:
                row.append(n + 1 if n < 9 else 1)

    for _ in range(4):
        for row in grid[-gridH:]:
            newRow = [n + 1 if n < 9 else 1 for n in row]
            grid.append(newRow)

    return dijkstra(grid)


def test():
    test_input = """1163751742
1381373672
2136511328
3694931569
7463417111
1319128137
1359912421
3125421639
1293138521
2311944581""".split('\n')
    assert part1(test_input) == 40
    assert part2(test_input) == 315


if __name__ == "__main__":
    test()
    vals = input_as_lines('C:\\Repos\\Privat\\AdventOfCode\\2021\\input_day15.txt')
    print(f"Part 1: {part1(vals)}")
    print(f"Part 2: {part2(vals)}")
