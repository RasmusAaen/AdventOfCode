from aoc import input_as_string

def part1(values: str) -> int:
    houses = {}
    posX = posY = 0

    houses[(posX,posY)] = 1
    for i in range(len(values)):
        if values[i] == '>':
            posX += 1
        elif values[i] == 'v':
            posY -= 1
        elif values[i] == '<':
            posX -= 1
        elif values[i] == '^':
            posY += 1
        if (posX, posY) in houses:
            houses[(posX,posY)] += 1
        else:
            houses[(posX,posY)] = 1

    return len(houses.values())


def part2(values: str) -> int:
    houses = {}
    posX = posY = 0
    posXr = posYr = 0

    houses[(posX,posY)] = 1
    houses[(posXr,posYr)] += 1
    for i in range(len(values)):
        santa = False
        if i % 2 == 0:
            santa = True
        if values[i] == '>':
            if santa:
                posX += 1
            else:
                posXr += 1
        elif values[i] == 'v':
            if santa:
                posY -= 1
            else:
                posYr -= 1
        elif values[i] == '<':
            if santa:
                posX -= 1
            else:
                posXr -= 1
        elif values[i] == '^':
            if santa:
                posY += 1
            else:
                posYr += 1
        if santa:
            if (posX, posY) in houses:
                houses[(posX,posY)] += 1
            else:
                houses[(posX,posY)] = 1
        else:
            if (posXr, posYr) in houses:
                houses[(posXr,posYr)] += 1
            else:
                houses[(posXr,posYr)] = 1

    return len(houses.values())

def test():
    test_input = '^>v<'
    assert part1(test_input) == 4
    assert part2(test_input) == 3

if __name__ == "__main__":
    test()
    vals = input_as_string('C:\\Repos\\Privat\\AdventOfCode\\2015\\input_day3.txt')
    print(f"Part 1: {part1(vals)}")
    print(f"Part 2: {part2(vals)}")
