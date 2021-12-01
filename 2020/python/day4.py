import re
from aoc import input_as_string


def part1(values: list) -> int:
    res = 0
    fields = ['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']
    for pp in values:
        for field in fields:
            if not re.search(field, pp):
                break
        else:
            res += 1

    return res


def part2(values: list[str]) -> int:
    res = 0
    fields = ['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']

    for pp in values:
        valid = True
        for field in fields:
            if not re.search(field, pp):
                valid = False
        if valid:
            items = pp.replace('\n', ' ').split(' ')
            for item in items:
                (name, val) = item.split(':')

                if name == 'byr':
                    if(int(val) < 1920 or int(val) > 2002):
                        valid = False
                elif name == 'iyr':
                    if(int(val) < 2010 or int(val) > 2020):
                        valid = False
                elif name == 'eyr':
                    if(int(val) < 2020 or int(val) > 2030):
                        valid = False
                elif name == 'hgt':
                    m = re.match(r'(\d+)(in|cm)',val)
                    if m is None:
                        valid = False
                    else:
                        (h,u) = m.groups()
                        if u == 'cm':
                            if int(h) < 150 or int(h) > 193:
                                valid = False
                        elif u == 'in':
                            if int(h) < 59 or int(h) > 76:
                                valid = False
                elif name == 'hcl':
                    if re.match(r'^#[a-fA-F0-9]{6}$',val) is None:
                        valid = False
                elif name == 'ecl':
                    if re.match(r'^(amb|blu|brn|gry|grn|hzl|oth)$',val) is None:
                        valid = False
                elif name == 'pid':
                    if re.match(r'^\d{9}$',val) is None:
                        valid = False
        if valid:
            res += 1
    return res


def test():
    test_input = ("""ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
byr:1937 iyr:2017 cid:147 hgt:183cm

iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
hcl:#cfa07d byr:1929

hcl:#ae17e1 iyr:2013
eyr:2024
ecl:brn pid:760753108 byr:1931
hgt:179cm

hcl:#cfa07d eyr:2025 pid:166559648
iyr:2011 ecl:brn hgt:59in""").split('\n\n')
    assert part1(test_input) == 2
    assert part2(test_input) == 2


if __name__ == "__main__":
    test()
    vals = input_as_string('C:\\Repos\\Privat\\AdventOfCode\\2020\\python\\input_day4.txt').split('\n\n')
    print(f"Part 1: {part1(vals)}")
    print(f"Part 2: {part2(vals)}")
