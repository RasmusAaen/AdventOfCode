$in = Get-Content .\input.txt

$opCnt = @(0) * $in.Length

$acc = 0
$i = 0
while ($true) {
    $opCnt[$i]++
    if($opCnt[$i] -gt 1) {
        break
    }
    
    $pattern = "^(?<instr>nop|acc|jmp) (?<num>[+|-]\d+)$"
    if ($in[$i] -match $pattern) {
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

Write-Host ("Value of accumulator is {0}" -f $acc)
