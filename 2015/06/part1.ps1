#Requires -Version 7.0

$in = Get-Content .\input.txt

$dimension = 1000
$map = [int[][]]::new($dimension, $dimension)

foreach ($line in $in) {
    $pattern = "^(turn on|toggle|turn off) (\d+),(\d+) through (\d+),(\d+)$"
    if ($line -match $pattern) {
        $instruction, [int]$startX, [int]$startY, [int]$endX, [int]$endY = $matches[1..5]
        $op = $null
        #change instruction to int for faster execution
        switch ($instruction) {
            "turn off" { $op = 0; break }
            "turn on" { $op = 1; break }
            "toggle" { $op = 2 ; break }
        }
        for ($i = $startx; $i -le $endX; $i++) {
            for ($j = $startY; $j -le $endY; $j++) {
                switch ($op) {
                    0 { $map[$i][$j] = 0; break }
                    1 { $map[$i][$j] = 1; break }
                    2 { $map[$i][$j] = $map[$i][$j] -eq 0 ? 1 : 0 ; break }
                }
            }
        }
    }
    else {
        Write-Error "No match"
    }
}

#count
$on = 0
for ($i = 0; $i -lt $dimension; $i++) {
    for ($j = 0; $j -lt $dimension; $j++) {
        if ($map[$i][$j] -eq 1) { $on++ }
    }
}

write-host ("A total of {0} lights are on" -f $on)
