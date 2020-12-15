$in = get-content .\input.txt

$bitLength = 36
function maskValue([int64]$val,$mask) {
    #convert to 'binary' and pad string with preceding zeros up to 36 bits
    $val1 = [convert]::ToString($val,2)
    $val1 = (('0' * ($bitLength-$val1.Length)) + $val1).ToCharArray()
    for($i=0;$i -lt $mask.length; $i++) {
        if($mask[$i] -ne 'X') {
            $val1[$i] = $mask[$i]
        }
    }
    $val1 = [string]($val1 -join '')
    return [convert]::ToInt64($val1, 2)
}

$mask = $null
$memory = @{}
foreach($instr in $in) {
    if($instr -match "^mask = (?<m>.+)$") {
        $mask = $Matches.m
        continue
    }
    if($instr -match "^mem\[(?<adr>\d+)\] = (?<val>\d+)$") {
        $memory[$Matches.adr] = (maskValue $Matches.val $mask)
    }
}

$total = ($memory.Values | measure -sum).sum
write-host ("Sum of values in memory is {0}" -f $total)
