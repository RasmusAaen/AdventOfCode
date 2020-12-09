$in = [Int64[]](Get-Content .\input.txt)

$preamble = 25
$last = 25

#Check if number is a sum of any numbers in list
function isValid ([Int64]$num,[Int64[]]$list) {
    for($i=0;$i -lt $list.Length; $i++) {
        for($j=0;$j -lt $list.Length; $j++) {
            if(($i -ne $j) -and ($list[$i] + $list[$j] -eq $num)) {
                return $true
            }
        }
    }
    return $false
}

for($i=$preamble;$i -lt $in.Length; $i++) {
    $valid = isValid $in[$i] $in[($i-$last)..($i-1)]
    if(!$valid) {
        write-host ("First invalid number is {0}" -f $in[$i])
        
        #Find contigous numbers that add up to invalid number found above
        for($x=0;$x -lt $in.Length; $x++) {
            [int64]$res = 0
            $y=$x
            while($res -lt $in[$i]) {
                $res += $in[$y++]
            }
            if($res -eq $in[$i]) {
                $y-- #We already incremented y for next loop
                [int64]$small = $in[$x..$y] | sort | select -First 1
                [int64]$large = $in[$x..$y] | sort | select -Last 1
                write-host ("smallest and largest number in range is {0} and {1}. Sum is {2}" -f $small,$large,([int64]$small+[int64]$large))
                break
            }
        }
        break
    }
}
