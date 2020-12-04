$in = get-content .\input.txt

class present {
    [int]$w
    [int]$h
    [int]$l

    [int]getPaper() {
        $a = 2*$this.l*$this.w
        $b = 2*$this.w*$this.h
        $c = 2*$this.h*$this.l
        $d = $a,$b,$c | sort | select -first 1
        return $a+$b+$c+($d/2)
    }

    [int]getRibbon() {
        $tot = 0
        $a,$b = $this.l,$this.w,$this.h | sort | select -first 2
        $tot += (2*$a)+(2*$b)
        $tot += $this.w*$this.h*$this.l
        return $tot
    }
}

$presents = @()
foreach($line in $in) {
    $p = [present]::new()
    $p.w,$p.h,$p.l = $line -split 'x'
    $presents += $p
}
$paper = 0 
foreach($present in $presents) {
    $paper += $present.getPaper()
}
$ribbon = 0 
foreach($present in $presents) {
    $ribbon += $present.getRibbon()
}

write-host ("Total wrapping paper: {0}" -f $paper)
write-host ("Total ribbon: {0}" -f $ribbon)
