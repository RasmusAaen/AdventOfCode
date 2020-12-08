[string[]]$in = Get-Content .\input.txt


$pattern = "^(?<instr>nop|acc|jmp) (?<num>[+|-]\d+)$"

$change = 0
while ($true) {
    #clone and change one operation
    $inCopy = $in.Clone()
    for ($j = $change; $j -lt $inCopy.length; $j++) {
        $inCopy[$j] -match $pattern | Out-Null
        if ($Matches.instr -eq "nop") {
            $inCopy[$j] = "jmp $([string]$Matches.num)"
            $change = $j+1
            break
        }
        elseif ($Matches.instr -eq "jmp") {
            $inCopy[$j] = "nop $([string]$Matches.num)"
            $change = $j+1
            break
        }
    }

    #Test cloned instruction set
    $loopDetected = $false
    $acc = 0
    $i = 0
    $opCnt = @(0) * $in.Length
    while ($i -lt $in.Length) {
        $opCnt[$i]++
        if ($opCnt[$i] -gt 1) {
            $loopDetected = $true
            break
        }
        
        if ($inCopy[$i] -match $pattern) {
            switch ($Matches.instr) {
                "nop" {
                    $i++
                    break
                }
                "acc" {
                    $acc += [int]$Matches.num
                    $i++
                    break
                }
                "jmp" {
                    $i += [int]$Matches.num
                    break
                }
            }
        }
    }
    if(!$loopDetected) {
        break
    }
}

Write-Host ("Value of accumulator is {0}" -f $acc)
