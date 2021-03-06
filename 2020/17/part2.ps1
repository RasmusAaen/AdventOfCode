#deep clone array to avoid freaking pointers. [array]::clone() is not enough...
function cloneArray($in) {
    $_TempCliXMLString = [System.Management.Automation.PSSerializer]::Serialize($in, [int32]::MaxValue)
    return [System.Management.Automation.PSSerializer]::Deserialize($_TempCliXMLString)
}

$in = Get-Content .\input.txt

$cycles = 6

$finalDimension = $in[0].length + ($cycles * 2)

$active = @{}

#starting positions
$x = $y = $z = $w = $cycles
$z++
$w++

#set initial state
for ($i = 0; $i -lt $in.Length; $i++) {
    for ($j = 0; $j -lt $in[$i].Length; $j++) {
        if ($in[$i][$j] -eq '#') {
            $active.Add("$($x + $i),$($y + $j),$($z),$($w)", 0)
        }
    }
}
write-host ("Number of active cubes after init is {0}" -f $active.Keys.count)

#Run cycles
$current = cloneArray $active
for ($cycle = 1; $cycle -le $cycles; $cycle++) {
    write-host "Running cycle $cycle"
    $changes = (cloneArray $current)
    for ($x = 0; $x -lt $finalDimension; $x++) {
        for ($y = 0; $y -lt $finalDimension; $y++) {
            for ($z = 0; $z -lt $finalDimension; $z++) {
                for ($w = 0; $w -lt $finalDimension; $w++) {
                    #Write-Host ("Point x:{0} y:{1} z:{2}" -f $x, $y, $z)
                    #Count active neighbours
                    $activeNeighbours = 0
                    for ($x1 = $x - 1; $x1 -le $x + 1; $x1++) {
                        if ($x1 -lt 0 -or $x1 -gt $finalDimension) {
                            continue #out of bounds
                        }
                        for ($y1 = $y - 1; $y1 -le $y + 1; $y1++) {
                            if ($y1 -lt 0 -or $y1 -gt $finalDimension) {
                                continue #out of bounds
                            }
                            for ($z1 = $z - 1; $z1 -le $z + 1; $z1++) {
                                if ($z1 -lt 0 -or $z1 -gt $finalDimension) {
                                    continue #out of bounds
                                }
                                for ($w1 = $w - 1; $w1 -le $w + 1; $w1++) {
                                    if ($w1 -lt 0 -or $w1 -gt $finalDimension) {
                                        continue #out of bounds
                                    }
                                    if ($x1 -eq $x -and $y1 -eq $y -and $z1 -eq $z -and $w1 -eq $w) {
                                        continue #self
                                    }
                                    #write-host ("Checking neighbour x:{0} y:{1} z:{2}" -f $x1, $y1, $z1)
                                    if ($current.ContainsKey("$($x1),$($y1),$($z1),$($w1)")) {
                                        $activeNeighbours++
                                    }
                                }
                            }
                        }
                    }
                    #Write-host (" State of {0},{1},{2} is {3}. Active neighbours: {4}" -f $x,$y,$z,$current[$x][$y][$z],$activeNeighbours)
                    #Make changes
                    if ($current.ContainsKey("$($x),$($y),$($z),$($w)") -and ($activeNeighbours -ne 2 -and $activeNeighbours -ne 3)) {
                        $changes.Remove("$($x),$($y),$($z),$($w)")
                    }
                    if (!$current.ContainsKey("$($x),$($y),$($z),$($w)") -and $activeNeighbours -eq 3) {
                        $changes.Add("$($x),$($y),$($z),$($w)", $cycle)
                    }
                }
            }
        }
    }
    $current = cloneArray $changes
    write-host ("Number of active cubes after {0} cycles is {1}" -f $cycle, $current.Keys.Count)
}



