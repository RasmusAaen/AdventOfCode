$in = ([int[]](Get-Content .\test2.txt) | sort)

#add zero to the start of list
$in = , 0 + $in

#get difference sequence
$diff = @()
for ($i = 1; $i -lt $in.Length; $i++) {
    $diff += $in[$i] - $in[$i - 1]
}

#split differences every time we encounter a diff of 3, or two sequential diffs of 2 since there is only one path from here
$lists = @()
$tmp = @()
for ($i = 0; $i -lt $diff.Length; $i++) {
    if ($diff[$i] -eq 3) {
        if ($tmp.Length -gt 0) { $lists += , $tmp }
        $tmp = @()
    }
    elseif ($diff[$i] -eq 2 -and $diff[$i + 1] -eq 2) {
        $i++
        if ($tmp.Length -gt 0) { $lists += , $tmp }
        $tmp = @()
    }
    else {
        $tmp += $diff[$i]
    }
}

#calculate possible paths for a given sequense
function getPaths([int[]]$list) {
    $paths = 0
    if ($list.length -eq 1) {
        #We reached the end
        return 1
    }
    for ($i = 0; $i -lt $list.length; $i++) {
        if ($list[$i + 1] -le ($list[$i] + 3)) {
            $paths += getPaths $list[($i + 1)..($list.Length)]
        }
        else {
            break
        }
    }
    return $paths
}

#calculate the possible paths of each segments
$mem = @{}
$total = 1
foreach ($list in $lists) {
    $ident = $list -join '-'
    if (!$mem.ContainsKey($ident)) {
        $x = 0
        $testSeq = , 0 + @($list | % { $x += $_; $x })
        $paths = getPaths $testSeq
        $mem.Add($ident, $paths)
    }
    $total = $total * $mem[$ident]
}

Write-host ("Total possible paths is {0}" -f $total)

