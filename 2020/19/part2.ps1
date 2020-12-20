$in = Get-Content .\input2.txt

$global:rules = @{}
$messages = @()
$i = 0
while ($in[$i] -ne '') {
    $r1, $r2 = $in[$i++].split(': ')
    $global:rules.Add([string]$r1, [string]$r2)
}
$i++
while ($i -lt $in.Length) {
    $messages += $in[$i++]
}

$global:mem = @{}
$global:maxDepth = 60

function parseRule([string]$num, [int]$depth = 0) {
    if ($global:mem.containsKey($num)) {
        #We have seen this before - return value from memory
        return $global:mem[$num]
    }
    elseif ($depth -gt $global:maxDepth) {
        return $null
    }
    elseif ($num -match '^\d+$') {
        #single rule number
        $r = $global:rules[$num]
        $val = ""
        if ($r -match '"(?<val>a|b)"') {
            $val = $Matches.val
        }
        else {
            $val = parseRule $r ($depth + 1)
        }
        if ($null -ne $val) {
            if (!$global:mem.ContainsKey($num)) {
                $global:mem.Add($num, $val)
            }
        }
        return $val
    }
    elseif ($num.indexOf('|') -ge 0) {
        #List with options
        $ret = @()
        $parts = $num.split(' | ')
        foreach ($part in $parts) {
            $r = parseRule $part ($depth + 1)
            if ($null -ne $r) {
                $ret += $r
            }
        }
        $val = $null
        if ($ret.length -gt 0) {
            $val = "("
            $val += $ret -join '|'
            $val += ")"
            if (!$global:mem.ContainsKey($num)) {
                    $global:mem.Add($num, $val)
                }
            }
            return $val
        }
        else {
            #list of numbers
            $ret = ""
            foreach ($p in $num.split(' ').Trim()) {
                $ret += parseRule $p ($depth + 1)
            }
            if ($ret.Length -gt 0) {
                if (!$global:mem.ContainsKey($num)) {
                    $global:mem.Add($num, $ret)
                }
            }
            else {
                $ret = $null
            }
            return $ret
        }
    }

    $pattern = "^" + (parseRule "0") + "$"
    #write-host $pattern

    $validMessages = 0
    foreach ($m in $messages) {
        if ($m -match $pattern) {
            $validMessages++
        }
    }

    write-host ("Found {0} valid messages." -f $validMessages)
