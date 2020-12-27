$in = Get-Content .\test.txt

$cups = New-Object System.Collections.Generic.LinkedList[int]
foreach ($c in $in.ToCharArray()) {
    $cups.Add([int][string]$c)
}

$move = 1
$moves = 10000000
$cupCount = 1000000
$lowestCup = $cups | sort | select -First 1
$highestCup = $cups | sort | select -Last 1

write-host "Placing cups"
for ($i = $highestCup + 1; $i -le $cupCount; $i++) {
    $cups.Add($i)
}

$active = $cups.First
Write-Host "Starting moves"
while ($move -le $moves) {
    if($move % 100000 -eq 0) {
        write-host "." -NoNewline
    }
    $removed = @()
    for($i=0;$i-lt 3;$i++) {
        $r = $null -eq $active.Next ? $cups.First : $active.Next
        $removed += $r
        $cups.Remove($r)
    }

    $destVal = $active.Value
    $destination = $null
    do {
        $destVal--
        if($destVal -lt $lowestCup) {
            $destVal = $highestCup
        }
        $destination = $cups.Find($destVal)
    } while (!$destination)
    

    foreach($cup in $removed) {
        $cups.AddAfter($destination,$cup)
        $destination = $cup
    }
    
    $active = $null -eq $active.Next ? $cups.First : $active.Next

    $move++
}

$one = $cups.Find(1)
$two = $one.Next
$three = $two.Next

write-host ("Product: {0}" -f ($two.Value * $three.Value))
