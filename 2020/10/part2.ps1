#Solution copied from https://github.com/pietroppeter/adventofnim/blob/master/2020/day10.nim

function getDiff ([int[]]$list) {
    $ret = @()
    for ($i = 1; $i -lt $list.Length; $i++) {
        $ret += $list[$i] - $list[$i - 1]
    }
    return $ret
}

$mem = @{}
$mem.Add("1-1",2)
$mem.Add("1-2",2)
$mem.Add("2-1",2)

function count([int[]]$list) {
    if($list.Length -le 1) {
        return 1
    }
    #check for 3 at start or end
    if($list[0] -eq 3) {
        return count $list[1..($list.length-1)]
    }
    if($list[-1] -eq 3) {
        return count $list[0..($list.Length-2)]
    }
    #check for 2,2 at start or end
    if($list[0] -eq 2 -and $list[1] -eq 2) {
        return count $list[2..($list.length-1)]
    }
    if($list[-1] -eq 2 -and $list[-2] -eq 2) {
        return count $list[0..($list.Length-3)]
    }
    #check if we have 3 or 2,2 inside list
    for($i=0;$i -lt $list.Length;$i++) {
        if($list[$i] -eq 3) {
            return (count $list[0..($i-1)]) * (count $list[($i+1)..($list.Length-1)])
        }
        if($list[$i] -eq 2 -and $list[$i+1] -eq 2) {
            return (count $list[0..($i-1)]) * (count $list[($i+2)..($list.Length-1)])
        }
    }
    #Check if we already calculated this sequence
    $ident = $list -join '-'
    if($mem.ContainsKey($ident)) {
        return $mem[$ident]
    }

    #Split list and calculate sequence
    #count (x y s) = count (y s) + count (x+y s)
    $s1 = [int[]]$list[1..($list.length-1)]
    $s2 = [int[]]@($list[0] + $list[1])
    #$s2 += [int[]]($list[2..($list.lenght)])
    for($j=2;$j -lt $list.length;$j++) {
        $s2 += [int]$list[$j]
    }
    $res = (count $s1) + (count $s2)
    $mem.Add($ident,$res)
    return $res
}

$in = ([int[]](Get-Content .\input.txt) | sort)
#add zero to the start of list and highest number + 3 to the end
$in = , 0 + $in + ($in[-1]+3)

#Calculate the result
count(getDiff $in)

