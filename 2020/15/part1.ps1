#$start = [int[]]("0,3,6" -split ',')
#$start = [int[]]("1,3,2" -split ',')
#$start = [int[]]("2,1,3" -split ',')
#$start = [int[]]("1,2,3" -split ',')
#$start = [int[]]("2,3,1" -split ',')
#$start = [int[]]("3,2,1" -split ',')
#$start = [int[]]("3,1,2" -split ',')
$start = [int[]]("0,14,1,3,7,9" -split ',')

$rounds = 30000000
class num  {
    [int]$spoken1
    [int]$spoken2
    [int]$times

    num() {
        $this.spoken1 = -1
        $this.spoken2 = -1
        $this.times = 0
    }
}

$numbers = @{}
$turn = 1
$last = -1

#process start numbers
foreach($number in $start) {
    $n = [num]::new()
    $n.times = 1
    $n.spoken1 = $turn
    $numbers.Add($number,$n)
    $last = $number
    $turn++
}

$current = -1
#Start turn
while($turn -le $rounds) {
    write-progress -Activity "A strange game. The only winning move is not to play. How about a nice game of chess?" -Status "Round $turn of $rounds" -PercentComplete (($turn/$rounds)*100)
    if($numbers[$last].times -eq 1) {
        #First time $last was spoken - next num is 0
        $current = 0
    } else {
        #$last has been spoken before - calculate next
        $current = ($numbers[$last].spoken1 - $numbers[$last].spoken2)
    }
    if(!$numbers.ContainsKey($current)) {
        $numbers.Add($current,[num]::new())
    }
    $numbers[$current].times++
    $numbers[$current].spoken2 = $numbers[$current].spoken1
    $numbers[$current].spoken1 = $turn
    $last = $current
    $turn++
}

Write-Host ("`nNumber spoken in round {0} is {1}" -f $rounds,$current)
