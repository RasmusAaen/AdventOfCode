$in = Get-Content .\input.txt

#Get initial hands
$player1 = [System.Collections.Queue]::new()
$player2 = [System.Collections.Queue]::new()

$i = 1
while ($in[$i] -ne '') {
    $player1.Enqueue([int]$in[$i++])
}
$i += 2
while ($i -lt $in.Length) {
    $player2.Enqueue([int]$in[$i++])
}

$global:game = 1

function playGame([System.Collections.Queue]$p1, [System.Collections.Queue]$p2, [int]$game, [int]$level = 0) {
    $playedHands = @{}
    $round = 1
    while ($p1.Count -gt 0 -and $p2.Count -gt 0) {
        #Write-Host ("Playing game {0} round {1} level{2}" -f $game,$round,$level)
        $cards = ($p1.ToArray() + $p2.ToArray()) -join '-'
        if ($playedHands.ContainsKey($cards)) {
            return $true
        }
        $playedHands.Add($cards, 0)

        [int]$card1 = $p1.Dequeue()
        [int]$card2 = $p2.Dequeue()

        $p1wins = $null
        if ($card1 -le $p1.count -and $card2 -le $p2.Count) {
            #play subgame
            $global:game++
            $p1hand = [System.Collections.Queue]::new(($p1.ToArray()[0..($card1 - 1)]))
            $p2hand = [System.Collections.Queue]::new(($p2.ToArray()[0..($card2 - 1)]))
            $p1wins = playGame $p1hand $p2hand $global:game ($level + 1)
        }
        else {
            $p1wins = $card1 -gt $card2
        }
        if ($p1wins) {
            $p1.Enqueue($card1)
            $p1.Enqueue($card2)
        }
        else {
            $p2.Enqueue($card2)
            $p2.Enqueue($card1)
        }
        $round++
    }
    return ($p1.Count -gt $p2.Count)
}

#Let's play!
$crabWins = playGame $player1 $player2 $global:game

$cards = $crabWins ? $player1.ToArray() : $player2.ToArray()

Write-host ("Found a winner: {0}" -f ($crabWins ? "The crab!" : "Me - wohoo"))
$mul = 1
$cnt = 0
[array]::Reverse($cards)
foreach ($card in $cards) {
    $cnt += $card * $mul++
}
Write-host "Total score is $cnt"
