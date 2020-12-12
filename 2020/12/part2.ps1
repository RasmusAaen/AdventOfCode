$in = Get-Content .\input.txt

#Ship pos
[int]$x = 0
[int]$y = 0

#Waypoint pos
[int]$wx = 10
[int]$wy = 1

$pattern = "^(?<move>(N|S|E|W|L|R|F))(?<num>\d+)$"
foreach ($instr in $in) {
    if ($instr -match $pattern) {
        switch ($Matches.move) {
            "N" { $wy += [int]$Matches.num; break }
            "S" { $wy -= [int]$Matches.num; break }
            "E" { $wx += [int]$Matches.num; break }
            "W" { $wx -= [int]$Matches.num; break }
            "L" { 
                switch ([int]$Matches.num) {
                    90 { $t = - $wy; $wy = $wx; $wx = $t; break }
                    180 { $wx = - $wx; $wy = - $wy; break }
                    270 { $t = $wy; $wy = - $wx; $wx = $t; break }
                }
                break
            }
            "R" { 
                switch ([int]$Matches.num) {
                    90 { $t = $wy; $wy = - $wx; $wx = $t; break }
                    180 { $wx = - $wx; $wy = - $wy; break }
                    270 { $t = - $wy; $wy = $wx; $wx = $t; break }
                }
                break
            }
            "F" {
                $x = $x + ([int]$Matches.num * $wx)
                $y = $y + ([int]$Matches.num * $wy)
                break
            }
        }
    }
}

write-host ("Ship is at x:{0}:y{1}. Manhattan distance from start is {2}" -f $x, $y, ([Math]::Abs($x) + [Math]::Abs($y)))
