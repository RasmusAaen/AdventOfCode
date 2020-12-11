[int[]]$in = Get-Content .\input.txt

function getFuel1([int]$mass) {
    return ([math]::Floor($mass/3)) - 2
}

function getFuel2([int]$mass) {
    $f = ([math]::Floor($mass/3)) - 2
    #write-host "$f"
    if($f -le 0) {return 0}
    return $f + (getFuel2 $f)
}


$fuel = 0
for($i=0;$i -lt $in.length;$i++) {
    $fuel += getFuel1 $in[$i]
}

Write-Host ("Total fuel for part 1: {0}" -f $fuel)

$fuel = 0
for($i=0;$i -lt $in.length;$i++) {
    $fuel += getFuel2 $in[$i]
}
Write-Host ("Total fuel for part 2: {0}" -f $fuel)
