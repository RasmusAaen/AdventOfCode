$in = Get-Content .\input.txt

$count =0
for($i=0;$i -lt $in.Length;$i++) {
    #get all answers for group
    $str = ""
    while($in[$i] -ne "" -and $i -lt $in.Length) {
        $str += $in[$i++]
    }
    $count += ($str.ToCharArray() | select -Unique).Length
}
Write-Host ("Total number of yes answers is {0}" -f $count)
