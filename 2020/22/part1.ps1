$in = Get-Content .\input.txt

$p1 = [System.Collections.Queue]::new()
$p2 = [System.Collections.Queue]::new()

$i = 1
while ($in[$i] -ne '') {
    $p1.Enqueue([int]$in[$i++])
}
$i += 2
while ($i -lt $in.Length) {
    $p2.Enqueue([int]$in[$i++])
}

$round = 1
$winner = $null
while($true) {
    Write-Host "Playing round $round"
    $card1 = $p1.Dequeue()
    $card2 = $p2.Dequeue()
    if($card1 -gt $card2){
        $p1.Enqueue($card1)
        $p1.Enqueue($card2)
    } else {
        $p2.Enqueue($card2)
        $p2.Enqueue($card1)
    }
    if($p1.Count -eq 0) {
        $winner = $p2
        break
    } elseif ($p2.count -eq 0) {
        $winner = $p1
        break
    }
    $round++
}

Write-host "Found a winner"
$mul = 1
$cnt = 0
$cards = $winner.ToArray()
[array]::Reverse($cards)
foreach($card in $cards) {
    $cnt += $card * $mul++
}
Write-host "Total score is $cnt"
