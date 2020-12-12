$in = Get-Content .\input.txt

$x = 0
$y = 0
$direction = 90

function getDirection([int]$i) {
    switch($i) {
        -270 {return 90}
        -180 {return 180}
        -90 {return 270}
        360 { return 0}
        450 { return 90}
        540 { return 180}
        default { return $i}
    }
}

$pattern = "^(?<move>(N|S|E|W|L|R|F))(?<num>\d+)$"
foreach($instr in $in) {
    if($instr -match $pattern) {
        switch ($Matches.move) {
            "N" { $y += [int]$Matches.num; break}
            "S" { $y -= [int]$Matches.num; break}
            "E" { $x += [int]$Matches.num; break}
            "W" { $x -= [int]$Matches.num; break}
            "L" { $direction = getDirection ($direction - $Matches.num)}
            "R" { $direction = getDirection ($direction + $Matches.num)}
            "F" {
                switch($direction) {
                    0 {$y += [int]$Matches.num; break}
                    90 {$x += [int]$Matches.num; break}
                    180 {$y -= [int]$Matches.num; break}
                    270 {$x -= [int]$Matches.num; break}
                }
            }
        }
    }
}

write-host ("Ship is at x:{0}:y{1}. Manhattan distance from start is {2}"-f $x,$y,([Math]::Abs($x) + [Math]::Abs($y)))
