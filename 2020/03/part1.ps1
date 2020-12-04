write-host "Getting input"
$in = Get-Content .\input.txt

#build map
write-host "Building map"
$width = 10
for ($i = 0; $i -lt $in.count; $i++) {
    for ($j = 0; $j -lt $width; $j++) {
        #double width for every iteration
        $in[$i] += $in[$i]
    }
}
write-host ("Map size: {0}*{1}" -f $in[0].length,$in.length)

function countTrees ($map, $right, $down) {
    $x = 0
    $y = 0
    $trees = 0
    while ($true) {
        $x += $right
        $y += $down
        if ($y -ge $map.count) {
            break
        }
        if ($map[$y][$x] -eq '#') {
            $trees++
        }
    }
    return $trees
}
#part1
Write-Host "Calculating part 1"
write-host ("Found {0} trees" -f (countTrees $in 3 1))

#part2
Write-Host "Calculating part 2"
$res1 = countTrees $in 1 1
$res2 = countTrees $in 3 1
$res3 = countTrees $in 5 1
$res4 = countTrees $in 7 1
$res5 = countTrees $in 1 2

write-host ("{0} * {1} * {2} * {3} * {4} = {5}" -f $res1,$res2,$res3,$res4,$res5,($res1*$res2*$res3*$res4*$res5))
