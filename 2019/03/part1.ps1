$in = Get-Content .\input.txt

#Using [System.Tuple] to represent a point, since I can then use Compare-Object to find intersections
function getPath($list) {
    $out = @()
    $x = 0
    $y = 0
    $pattern = "^(?<dir>(R|U|L|D))(?<num>\d+)$"
    $c=0
    $instructions = $list -split ','
    foreach ($instr in $instructions) {
        write-progress -Activity "Building wire path" -Status $instr -PercentComplete (($c++/$instructions.length)*100)
        if ($instr -match $pattern) {
            switch ($Matches.dir) {
                'U' { 
                    for ($i = 1; $i -le $Matches.Num; $i++) {
                        $y++
                        $out += [System.Tuple]::Create($x,$y,([math]::Abs($x) + [math]::Abs($y)))
                    }
                }
                'D' { 
                    for ($i = 1; $i -le $Matches.Num; $i++) {
                        $y--
                        $out += [System.Tuple]::Create($x,$y,([math]::Abs($x) + [math]::Abs($y)))
                    }
                }
                'L' {                      
                    for ($i = 1; $i -le $Matches.Num; $i++) {
                        $x--
                        $out += [System.Tuple]::Create($x,$y,([math]::Abs($x) + [math]::Abs($y)))
                    }
                }
                'R' {  
                    for ($i = 1; $i -le $Matches.Num; $i++) {
                        $x++
                        $out += [System.Tuple]::Create($x,$y,([math]::Abs($x) + [math]::Abs($y)))
                    }
                }
            }
        }
    }
    return $out
}

$w1 = getPath $in[0]
$w2 = getPath $in[1]

$common = Compare-Object -ReferenceObject $w1 -DifferenceObject $w2 -ExcludeDifferent | select -ExpandProperty InputObject

$close = $common | sort -Property Item3 | select -First 1

write-host ("Closest intersection point is {0},{1}- Manhattan distnace is {2}" -f $close.Item1,$close.Item2,$close.Item3)
