$in = get-content .\input.txt
$floor = 0
for($i=0;$i -lt $in.length; $i++) {
    if($in[$i] -eq '(') {$floor++}
    elseif($in[$i] -eq ')') {$floor--}
    if($floor -lt 0) {
        Write-Output ("Santa entered the basement on move {0}" -f $i+1)
        break
    }
}
