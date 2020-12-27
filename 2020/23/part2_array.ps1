$in = Get-Content .\test.txt

$cups = [System.Collections.ArrayList]::new([int[]]([string[]]$in.ToCharArray()))

$move = 1
$moves = 10000000
$cupCount = 1000000
$lowestCup = $cups | sort | select -First 1
$highestCup = $cups | sort | select -Last 1
$cups.AddRange((($highestCup+1)..$cupCount))
$active = $cups[0]

while ($move -le $moves) {
    if($move % 100000 -eq 0) {
        write-host '.' -NoNewline
    }
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

$pos = $cups.IndexOf(1)
[int64]$n1 = $cups[($pos+1)]
[int64]$n2 = $cups[($pos+2)]
write-host ''
write-host ("Products of the two cups to the right of cup 1 is{1}" -f ($n1 * $n2))
