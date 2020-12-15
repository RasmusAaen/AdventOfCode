#Deep clone an object to avoid pointer errors
function cloneObject($in) {
    $_TempCliXMLString = [System.Management.Automation.PSSerializer]::Serialize($in, [int32]::MaxValue)
    return [System.Management.Automation.PSSerializer]::Deserialize($_TempCliXMLString)
}

function runIntcode([int[]]$program) {
    $pos = 0
    $run = $true
    while ($run) {
        $opCode = $program[$pos] % 100
        $m1 = [math]::Truncate(($program[$pos] / 100) % 10)
        $m2 = [math]::Truncate(($program[$pos] / 1000) % 10)
        #$m3 = [math]::Truncate(($program[$pos] / 10000) % 10)
        switch ($opcode) {
            1 {
                #Addition
                $p1 = $m1 -eq 0 ? $program[$program[$pos + 1]] : $program[$pos + 1]
                $p2 = $m2 -eq 0 ? $program[$program[$pos + 2]] : $program[$pos + 2]
                $program[$program[$pos + 3]] = $p1 + $p2
                $pos += 4
                break
            }
            2 {
                #Multiplication
                $p1 = $m1 -eq 0 ? $program[$program[$pos + 1]] : $program[$pos + 1]
                $p2 = $m2 -eq 0 ? $program[$program[$pos + 2]] : $program[$pos + 2]
                $program[$program[$pos + 3]] = $p1 * $p2
                $pos += 4
                break
            }
            3 {
                #Input
                $program[$program[$pos + 1]] = Read-Host -Prompt "Enter input"
                $pos += 2
                break
            }
            4 {
                #Output
                $p1 = $m1 -eq 0 ? $program[$program[$pos + 1]] : $program[$pos + 1]
                write-host ("Output: {0}" -f $p1)
                $pos += 2
                break
            }
            5 {
                #Jump if true
                $p1 = $m1 -eq 0 ? $program[$program[$pos + 1]] : $program[$pos + 1]
                $p2 = $m2 -eq 0 ? $program[$program[$pos + 2]] : $program[$pos + 2]
                $pos = $p1 -ne 0 ? $p2 : $pos + 3
                break
            }
            6 {
                #Jump if false
                $p1 = $m1 -eq 0 ? $program[$program[$pos + 1]] : $program[$pos + 1]
                $p2 = $m2 -eq 0 ? $program[$program[$pos + 2]] : $program[$pos + 2]
                $pos = $p1 -eq 0 ? $p2 : $pos + 3
                break
            }
            7 {
                #Less than
                $p1 = $m1 -eq 0 ? $program[$program[$pos + 1]] : $program[$pos + 1]
                $p2 = $m2 -eq 0 ? $program[$program[$pos + 2]] : $program[$pos + 2]
                $program[$program[$pos + 3]] = $p1 -lt $p2 ? 1 : 0
                $pos += 4
                break
            }
            8 {
                #Equal
                $p1 = $m1 -eq 0 ? $program[$program[$pos + 1]] : $program[$pos + 1]
                $p2 = $m2 -eq 0 ? $program[$program[$pos + 2]] : $program[$pos + 2]
                $program[$program[$pos + 3]] = $p1 -eq $p2 ? 1 : 0
                $pos += 4
                break
            }
            99 {
                $run = $false
                break
            }
        }
    }
    #return $program[0]
}
