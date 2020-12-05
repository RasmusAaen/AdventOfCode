$in = get-content .\input.txt

function getHalfRow([string]$side, [array]$list) {
    switch($side) {
        "F" {return $list[0..(($list.Length / 2)-1)] }
        "B" {$e = $list.Length; $e--; return $list[($list.Length / 2)..($e)]} #Very strange quirk - if I just use (list.Length - 1) I always get -1 no matter the length
        "default" { throw "illegal input"}
    }
}

function getHalfSeat([string]$side, [array]$list) {
    switch($side) {
        "L" {return $list[0..(($list.Length / 2)-1)] }
        "R" {$e = $list.Length; $e--; return $list[($list.Length / 2)..($e)]}
        "default" { throw "illegal input"}
    }
}

$seatIds = @()
foreach ($line in $in) {
    $row = @(0..127)
    $seat = @(0..7)
    
    $rowlist = $line[0..6]
    $seatlist = $line[7..9]
    
    for ($i = 0; $i -lt $rowlist.Length; $i++) {
        $row = getHalfRow $rowlist[$i] $row
    }

    for ($i = 0; $i -lt $seatlist.Length; $i++) {
        $seat = getHalfSeat $seatlist[$i] $seat
    }

    $id = ($row[0] * 8) + $seat[0]
    $seatIds += $id
}

#part 1
$seatIds = $seatIds | sort
write-host ("higest seat id is {0}" -f ($seatIds | select -Last 1))

#part 2
for($i=1; $i -lt $seatIds.Length - 1; $i++) {
    if($seatIds[$i-1] -ne $seatIds[$i]-1 -or $seatIds[$i+1] -ne $seatIds[$i]+1) {
        $seat = $seatIds[$i] + 1
        write-host ("My seat id is {0}" -f $seat)
        break
    }
}
