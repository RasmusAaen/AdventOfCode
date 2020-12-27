$in = Get-Content .\input.txt

$moves = 10000000
$cupCount = 1000000

write-host "Placing cups"
$nums = [int[]]([string[]]$in.ToCharArray()) + (($in.length + 1)..$cupCount)

$global:cups = @{}
for ($i = 0; $i -lt $nums.Length; $i++) {
    $global:cups.Add($nums[$i], $nums[(($i + 1) % $nums.Length)])
}

$lowestCup = $global:cups.Values | sort | select -First 1
$highestCup = $global:cups.Values | sort | select -Last 1

$move = 1
$active = [int][string]$in[0]

function removeAfter([int]$num) {
    $idToRemove = $global:cups[$num]
    $newPointer = $global:cups[$idToRemove]
    $global:cups.Remove($idToRemove)
    $global:cups[$num] = $newPointer
    return $idToRemove
}

function insertAfter([int]$num, [int]$newId) {
    $nextId = $global:cups[$num]
    $global:cups[$num] = $newId
    $global:cups.Add($newId, $nextId)
}

Write-Host "Starting moves"
while ($move -le $moves) {
    if ($move % 100000 -eq 0) {
        write-host "." -NoNewline
    }

    $removed = @()
    for ($i = 0; $i -lt 3; $i++) {
        $removed += removeAfter $active
    }

    $dest = $active
    do{
        $dest--
        if($dest -lt $lowestCup) { 
            $dest = $highestCup
        }
    } while($removed -contains $dest)

    foreach($cup in $removed) {
        insertAfter $dest $cup
        $dest = $cups[$dest]
    }

    $active = $cups[$active]
    $move++
}

$n1 = $cups[1]
$n2 = $cups[$cups[1]]
write-host ("Product: {0}" -f ($n1 * $n2))
