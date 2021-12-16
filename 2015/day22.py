import random
from aoc import *

def fight(part2: bool = False):
    used = 0

    boss = {'hp':51, 'dmg':9}
    player = {'hp':50, 'mp':500, 'arm':0}

    spells = [['Magic Missile', 53],['Drain',73],['Shield',113],['Poison',173],['Recharge',229]]

    turn = 'p'
    shieldActive = False
    shieldCount = 0
    poisonActive = False
    poisonCount = 0
    rechargeActive = False
    rechargeCount = 0

    while True:
        player['arm'] = 0
        if shieldActive:
            player['arm'] = 7
            shieldCount += 1
            if shieldCount == 6:
                shieldActive = False

        if poisonActive:
            boss['hp'] -= 3
            if boss['hp'] <= 0:
                return True, used
            poisonCount += 1
            if poisonCount == 6:
                poisonActive = False

        if rechargeActive:
            player['mp'] += 101
            rechargeCount += 1
            if rechargeCount == 5:
                rechargeActive = False

        if turn == 'p':
            if part2:
                player['hp'] -= 1
                if player['hp'] <= 0:
                    return False, used

            spell = None
            random.shuffle(spells)
            for s in spells:
                if player['mp'] >= s[1]:
                    if s[0] == 'Shield' and shieldActive:
                        continue
                    if s[0] == 'Poison' and poisonActive:
                        continue
                    if s[0] == 'Recharge' and rechargeActive:
                        continue
                    spell = s
                    break
            if spell is None:
                return False, used

            player['mp'] -= spell[1]
            used += spell[1]

            if spell[0] == 'Magic Missile':
                boss['hp'] -= 4
                if boss['hp'] <= 0:
                    return True, used

            elif spell[0] == 'Drain':
                boss['hp'] -= 2
                player['hp'] += 2
                if boss['hp'] <= 0:
                    return True, used

            elif spell[0] == 'Shield':
                player['arm'] = 7
                shieldActive = True
                shieldCount = 0

            elif spell[0] == 'Poison':
                poisonActive = True
                poisonCount = 0

            elif spell[0] == 'Recharge':
                rechargeActive = True
                rechargeCount = 0

            turn = 'b'

        else:
            player['hp'] -= max(1,boss['dmg'] - player['arm'])
            if player['hp'] <= 0:
                return False, used

            turn = 'p'


def part1(values: list) -> int:
    minMana = float('inf')

    for _ in range(5000):
        res, price = fight()
        if res:
            if price < minMana:
                minMana = price
    return minMana


def part2(values: list) -> int:
    minMana = float('inf')

    for _ in range(20000):
        res, price = fight(True)
        if res:
            if price < minMana:
                minMana = price
    return minMana


def test():
    test_input = """""".split('\n')
    assert part1(test_input) == None
    assert part2(test_input) == None


if __name__ == "__main__":
    #test()
    vals = input_as_lines('C:\\Repos\\Privat\\AdventOfCode\\2015\\input_day22.txt')
    print(f"Part 1: {part1(vals)}")
    print(f"Part 2: {part2(vals)}")
