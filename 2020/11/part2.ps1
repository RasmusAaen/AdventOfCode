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
            if ($current[$y][$x] -eq '.') { continue } #floor
            
            #Check each direction to find first visible seat and count number of occupied seats
            $occupied = 0
            #up-left
            for (($x1 = $x - 1), ($y1 = $y - 1); $x1 -ge 0 -and $y1 -ge 0; $x1--, $y1--) {
                if ($current[$y1][$x1] -eq '.') { continue }
                if ($current[$y1][$x1] -eq '#') { $occupied++ }
                break
            }
            #up
            for (($x1 = $x), ($y1 = $y - 1); $y1 -ge 0; $y1--) {
                if ($current[$y1][$x1] -eq '.') { continue }
                if ($current[$y1][$x1] -eq '#') { $occupied++ }
                break
            }
            #up-right
            for (($x1 = $x + 1), ($y1 = $y - 1); $x1 -lt $current[0].length -and $y1 -ge 0; $x1++, $y1--) {
                if ($current[$y1][$x1] -eq '.') { continue }
                if ($current[$y1][$x1] -eq '#') { $occupied++ }
                break
            }
            #right
            for (($x1 = $x + 1), ($y1 = $y); $x1 -lt $current[0].length; $x1++) {
                if ($current[$y1][$x1] -eq '.') { continue }
                if ($current[$y1][$x1] -eq '#') { $occupied++ }
                break
            }
            #down-right
            for (($x1 = $x + 1), ($y1 = $y + 1); $x1 -lt $current[0].length -and $y1 -lt $current.length; $x1++, $y1++) {
                if ($current[$y1][$x1] -eq '.') { continue }
                if ($current[$y1][$x1] -eq '#') { $occupied++ }
                break
            }
            #down
            for (($x1 = $x), ($y1 = $y + 1); $y1 -lt $current.length; $y1++) {
                if ($current[$y1][$x1] -eq '.') { continue }
                if ($current[$y1][$x1] -eq '#') { $occupied++ }
                break
            }
            #down-left
            for (($x1 = $x - 1), ($y1 = $y + 1); $x1 -ge 0 -and $y1 -lt $current.length; $x1--, $y1++) {
                if ($current[$y1][$x1] -eq '.') { continue }
                if ($current[$y1][$x1] -eq '#') { $occupied++ }
                break
            }
            #left
            for (($x1 = $x - 1), ($y1 = $y); $x1 -ge 0; $x1--) {
                if ($current[$y1][$x1] -eq '.') { continue }
                if ($current[$y1][$x1] -eq '#') { $occupied++ }
                break
            }

            #Should we change seat state?
            if ($current[$y][$x] -eq 'L') {
                if ($occupied -eq 0) {
                    $changes[$y][$x] = '#'
                }
            }
            else {
                if ($occupied -ge 5) {
                    $changes[$y][$x] = 'L'
                }
            }
        }
    }
    #Check if anything changed
    if (Compare-Object -ReferenceObject $current -DifferenceObject $changes) {
        #show seats
        #foreach($c in $current) {
        #    write-host $c
        #}
        #write-host ' '
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
