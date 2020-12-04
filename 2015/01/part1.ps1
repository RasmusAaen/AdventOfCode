$in = get-content .\input.txt
$floor = 0
for($i=0;$i -lt $in.length; $i++) {
    if($in[$i] -eq '(') {$floor++}
    elseif($in[$i] -eq ')') {$floor--}
}
Write-Output ("Santa is on floor {0}" -f $floor)
