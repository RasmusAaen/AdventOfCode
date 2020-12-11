#Deep clone an object to avoid pointer errors
function cloneObject($in) {
    $_TempCliXMLString = [System.Management.Automation.PSSerializer]::Serialize($in, [int32]::MaxValue)
    return [System.Management.Automation.PSSerializer]::Deserialize($_TempCliXMLString)
}

function runIntcode([int[]]$program) {
    $pos = 0
    $run = $true
    while ($run) {
        $opCode = $program[$pos]
        switch ($opcode) {
            1 {
                $program[$program[$pos + 3]] = $program[$program[$pos + 1]] + $program[$program[$pos + 2]]
                $pos += 4
                break
            }
            2 {
                $program[$program[$pos + 3]] = $program[$program[$pos + 1]] * $program[$program[$pos + 2]]
                $pos += 4
                break
            }
            99 {
                $run = $false
                break
            }
        }
    }
    return $program[0]
}
