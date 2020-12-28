$in = Get-Content .\input.txt

function step([int[]]$location, [string]$direction) {
    [int]$x = $location[0]
    [int]$y = $location[1]
    [int]$z = $location[2]

    switch ($direction) {
        'w' { return @(($x - 1), ($y + 1), $z) }
        'e' { return @(($x + 1), ($y - 1), $z) }
        'nw' { return @($x, ($y + 1), ($z - 1)) }
        'ne' { return @(($x + 1), $y, ($z - 1)) }
        'sw' { return @(($x - 1), $y, ($z + 1)) }
        'se' { return @($x, ($y - 1), ($z + 1)) }
        'default' { throw "Unknown direction: $direction" }
    }
}

function getNeighbours([int[]]$location) {
    $x = $location[0]
    $y = $location[1]
    $z = $location[2]

    return @(@(($x - 1), ($y + 1), $z), 
        @(($x + 1), ($y - 1), $z), 
        @($x, ($y + 1), ($z - 1)), 
        @(($x + 1), $y, ($z - 1)), 
        @($x, ($y - 1), ($z + 1)), 
        @(($x - 1), $y, ($z + 1)))
}

#Parse input
$moves = @()
$pattern = "((?<!n|s)e)|((?<!n|s)w)|(se)|(nw)|(sw)|(ne)"

foreach ($line in $in) {
    $moves += , @([regex]::Matches($line, $pattern))
}

$global:tiles = @{}

function updateFloor() {
    #count number of neighbours for each tile
    $neighbourCount = @{}
    foreach ($key in $global:tiles.Keys) {
        if ($global:tiles[$key] -eq "black") {
            foreach ($loc in (getNeighbours ($key.Split(',')))) {
                $sLoc = $loc -join ','
                if ($neighbourCount.ContainsKey($sLoc)) {
                    $neighbourCount[$sLoc]++
                }
                else {
                    $neighbourCount.Add($sLoc, 1)
                }
            }
        }
    }

    $map = @{}

    foreach ($key in $neighbourCount.Keys) {
        #Get state. New tiles are white
        if ($global:tiles.ContainsKey($key)) {
            $state = $global:tiles[$key]
        }
        else {
            $state = 'white'
        }
        
        #Flip according to the rules
        if ($state -eq 'black' -and ((1, 2) -notcontains $neighbourCount[$key])) {
            $map.Add($key, 'white')
        }
        elseif ($state -eq 'white' -and $neighbourCount[$key] -eq 2) {
            $map.Add($key, 'black')
        }
        else {
            $map.Add($key, $state)
        }
    }

    return $map
}

function countBlackTiles() {
    return ($Global:tiles.Values | where { $_ -eq 'black' }).count
}

#Part 1 - Lets start flipping tiles
foreach ($move in $moves) {
    [int[]]$loc = @(0, 0, 0)
    foreach ($step in $move) {
        $loc = step $loc $step
    }
    $sLoc = $loc -join ','
    if ($global:tiles.ContainsKey($sLoc)) {
        $global:tiles[$sLoc] = $global:tiles[$sLoc] -eq 'black' ? 'white' : 'black'
    }
    else {
        $global:tiles.Add($sLoc, 'black')
    }
}

write-host ("Part 1: Found {0} black tiles" -f (countBlackTiles))
Write-Host ""

#part 2
$days = 100
for ($i = 1; $i -le $days; $i++) {
    $global:tiles = updateFloor
    if ($i % 10 -eq 0) {
        write-host ("Day {0}: {1}" -f $i, (countBlackTiles))
    }
}


