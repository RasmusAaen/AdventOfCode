$in = Get-Content .\input.txt

[int]$dep = $in[0]
[int[]]$busses = $in[1] -split ',' | where{$_ -ne 'x'}

$time = $dep
:loop1 while($true) {
    foreach($bus in $busses) {
        if($time % $bus -eq 0) {
            write-host ("Earliest departure is {0} with bus {1}. Answer is {2}" -f $time,$bus,(($time-$dep)*$bus))
            break loop1
        }
    }
    $time++
}
