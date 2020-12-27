$in = Get-Content .\input.txt

$cups = [System.Collections.ArrayList]::new([int[]]([string[]]$in.ToCharArray()))

$move = 1
$moves = 100
$lowestCup = $cups | sort | select -First 1
$highestCup = $cups | sort | select -Last 1
$active = $cups[0]

while ($move -le $moves) {
    #write-host "-- Move $move --"
    #Remove three cups clockwise of active cup
    $remPos = $cups.IndexOf($active) + 1
    $removed = @()
    for ($i = 0; $i -lt 3; $i++) {
        if ($remPos -ge $cups.Count) {
            $remPos = 0
        }
        $removed += $cups[$remPos]
        $cups.RemoveAt($remPos)
    }
    
    #Find destination cup 
    $destCupPos = -1
    $testPos = $active - 1
    while ($destCupPos -eq -1) {
        if ($testPos -lt $lowestCup) {
            $testPos = $highestCup
            #$testpos = $cups | sort | select -last 1
        }
        $destCupPos = $cups.IndexOf($testPos)
        $testPos--
    }
    
    #Insert removed cups clockwise of destinationCup
    $cups.InsertRange($destCupPos + 1, $removed)

    #Select next active cup
    $active = $cups[($cups.IndexOf($active) + 1)]
    if ($null -eq $active) {
        $active = $cups[0]
    }
    $move++
}

$onePos = $cups.IndexOf(1) + 1
$res = ""
for ($i = 0; $i -lt $cups.Count - 1; $i++) {
    if ($onePos -ge $cups.Count) {
        $onePos = 0
    }
    $res += [string]$cups[$onePos++]
}

write-host ("Cup order after {0} moves is {1}" -f $moves, $res)
