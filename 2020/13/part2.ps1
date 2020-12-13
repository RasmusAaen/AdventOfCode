$in = Get-Content .\input.txt

[int]$dep = $in[0]
[string[]]$busses = $in[1] -split ','

#solve bus1 first, then solve bus2 in increments of bus 1 and so on
$earliest = 0
$product = 1
for($i=0; $i -lt $busses.Length; $i++) {
    if($busses[$i] -eq 'x') {
        continue
    }
    while(($earliest + $i) % [int]$busses[$i] -ne 0) {
        $earliest += $product
    }
    $product *= [int]$busses[$i]
}
write-host ("Earliest time is {0}" -f $earliest)
