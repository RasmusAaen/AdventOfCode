$in = get-content .\input.txt

function doCalc([string]$val) {
    while($val.IndexOf('+') -ge 0) {
        if($val -match "(?<n1>\d+)\+(?<n2>\d+)") {
            $val = $val.Replace($matches[0],[string]([int64]$Matches.n1 + [int64]$Matches.n2))
        }
    }
    $res = 1
    foreach($n in $val.Split('*')) {
        $res *= $n
    }
    return $res
}

function resolvePar([string]$val) {
    if($val -match '\(') {
        $len = 0
        $cnt = 1
        $start = $val.IndexOf('(')
        for($i = $start+1;$i -lt $val.Length;$i++) {
            if($val[$i] -eq '(') {
                $cnt++
            } elseif ($val[$i] -eq ')') {
                $cnt--
                if($cnt -eq 0) {
                    $len = ($i - $start) +1
                    break
                }
            }
        }
        $rep = $val.Substring($start,$len)
        $rep1 = resolvePar $rep.Substring(1,$rep.Length-2)
        $nex = $val.Replace($rep, "$rep1")
        return resolvePar $nex
    } else {
        return doCalc $val
    }
}

$sum = 0
foreach($line in $in) {
    $sum += resolvePar ($line -replace ' ', '')
}

Write-Host ("Total sum is {0}" -f $sum)

