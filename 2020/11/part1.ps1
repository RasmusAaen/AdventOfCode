$in = [string[]](Get-Content .\input.txt)

#convert input to char[][]
$current = [char[][]]@()
for ($i = 0; $i -lt $in.length; $i++) {
    $current += , $in[$i].ToCharArray()
}

#deep clone array to avoid freaking pointers. [array]::clone() is not enough...
function cloneArray($in) {
    $_TempCliXMLString = [System.Management.Automation.PSSerializer]::Serialize($in, [int32]::MaxValue)
    return [System.Management.Automation.PSSerializer]::Deserialize($_TempCliXMLString)
}

$round = 0
while ($true) {
    $round++
    $changes = [char[][]](cloneArray $current)
    for ($x = 0; $x -lt $current[0].length; $x++) {
        for ($y = 0; $y -lt $current.length; $y++) {
            if ($current[$y][$x] -eq '.') {
                #floor
                continue
            }
            $occupied = 0
            #check row above
            if (($y - 1) -ge 0) {
                if ($x - 1 -ge 0) {
                    if ($current[$y - 1][$x - 1] -eq '#') { $occupied++ }
                }
                if ($current[$y - 1][$x] -eq '#') { $occupied++ }
                if ($x + 1 -lt $current[0].length) {
                    if ($current[$y - 1][$x + 1] -eq '#') { $occupied++ }
                }
            }
            #check current row
            if (($x - 1) -ge 0) {
                if ($current[$y][$x - 1] -eq '#') { $occupied++ }
            }
            if (($x + 1) -lt $current[0].length) {
                if ($current[$y][$x + 1] -eq '#') { $occupied++ }
            }
            #check row below
            if (($y + 1) -lt $current.length) {
                if (($x - 1) -ge 0) {
                    if ($current[$y + 1][$x - 1] -eq '#') { $occupied++ }
                }
                if ($current[$y + 1][$x] -eq '#') { $occupied++ }
                if (($x + 1) -lt $current[0].length) {
                    if ($current[$y + 1][$x + 1] -eq '#') { $occupied++ }
                }
            }

            #Should we change seat state?
            if ($current[$y][$x] -eq 'L') {
                if ($occupied -eq 0) {
                    $changes[$y][$x] = '#'
                }
            }
            else {
                if ($occupied -ge 4) {
                    $changes[$y][$x] = 'L'
                }
            }
        }
    }
    #todo - check if anything changed
    if (Compare-Object -ReferenceObject $current -DifferenceObject $changes) {
        $current = [char[][]](cloneArray $changes)
    }
    else {
        #chaos has stabilized - count occupied seats
        $cnt = 0
        foreach ($c in $current) {
            foreach ($r in $c) {
                if ($r -eq '#') {
                    $cnt++
                }
            }
        }
        write-host ("Total number of occupied seats is {0}" -f $cnt)
        break
    }
}
