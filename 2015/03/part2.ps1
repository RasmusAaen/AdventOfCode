$in = Get-Content .\input.txt

#build grid
$dimension = 1000
$map = [int[][]]::new($dimension, $dimension)

#start in middle of grid
$x = [int]$dimension / 2
$y = [int]$dimension / 2
$x1 = [int]$dimension / 2
$y1 = [int]$dimension / 2


#deliver presents
$map[$x][$y]++
for ($i = 0; $i -lt $in.length; $i++) {
    if ($i % 2 -eq 0) {
        switch ($in[$i]) {
            '>' { $x++ }
            '<' { $x-- }
            '^' { $y-- }
            'v' { $y++ }
        }
        $map[$x][$y]++
    }
    else {
        switch ($in[$i]) {
            '>' { $x1++ }
            '<' { $x1-- }
            '^' { $y1-- }
            'v' { $y1++ }
        }
        $map[$x1][$y1]++
    }
}

#count
$houses = 0
for ($i = 0; $i -lt $dimension; $i++) {
    for ($j = 0; $j -lt $dimension; $j++) {
        if ($map[$i][$j] -ge 1) {
            $houses++
        }
    }
}
Write-Output ("{0} houses got one or more presents" -f $houses)
