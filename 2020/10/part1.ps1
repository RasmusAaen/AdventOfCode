[int[]]$in = Get-Content .\input.txt

$last = 0
$rating = ($in | sort | select -last 1)+3

$order = @()
$diff = @{1=0;2=0;3=0}
foreach($adapter in ($in|sort)) {
    $diff[($adapter - $last)]++
    $last = $adapter
}
$diff[($rating-$last)]++

Write-Host ("Answer is {0}" -f ($diff[1]*$diff[3]))
