$in = get-content .\input.txt


function doCalc([string]$val) {
    $nums = $val -split '[+|*]'
    $ops = $val -split '\d+' | where { $_ -notlike '' }
    $res = [int]$nums[0]
    $opCnt = 0
    for ($i = 1; $i -lt $nums.Length; $i++) {
        switch ($ops[$opCnt++]) {
            '+' { $res += [int]$nums[$i] }
            '*' { $res *= [int]$nums[$i] }
        }
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

