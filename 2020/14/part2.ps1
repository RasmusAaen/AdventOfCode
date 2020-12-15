$in = get-content .\input.txt

$global:bitLength = 36
function getBit([int]$a,[int]$length) {
    $t = [convert]::ToString($a,2)
    $t = (('0' * ($length-$t.Length)) + $t).ToCharArray()
    return $t
}


function getAddresses([int64]$adr, [string]$mask) {
    $adr1 = getBit $adr $global:bitLength

    $floatBits = @('x')*$mask.Length
    for($i=0; $i -lt $mask.Length; $i++) {
        if($mask[$i] -eq '0') {
            $floatBits[$i] = $adr1[$i]}
        elseif ($mask[$i] -eq '1') {
            $floatBits[$i] = 1
        }
    }
    
    $floatCnt = ($floatBits | where {$_ -eq 'x'} | measure).count
    $floats = @()
    for($i=0;$i -lt [math]::Pow(2,$floatCnt); $i++) {
        $floats += ,(getBit $i $floatCnt)
    }

    $addresses = @()
    foreach($float in $floats) {
        $i=0
        $a = ""
        foreach($bit in $floatBits) {
            if($bit -ne 'x') {
                $a += $bit
            } else {
                $a += $float[$i++]
            }
        }
        $addresses += [convert]::ToInt64($a,2)
    }
    return $addresses
}

$mask = $null
$memory = @{}
foreach ($instr in $in) {
    if ($instr -match "^mask = (?<m>.+)$") {
        $mask = $Matches.m
        continue
    }
    if ($instr -match "^mem\[(?<adr>\d+)\] = (?<val>\d+)$") {
        foreach ($adr in (getAddresses $Matches.adr $mask)) {
            $memory[$adr] = $Matches.val
        }
    }
}

$total = ($memory.Values | measure -sum).sum
write-host ("Sum of values in memory is {0}" -f $total)
