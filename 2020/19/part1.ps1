$in = Get-Content .\input.txt

$global:rules = @{}
$messages = @()
$i = 0
while ($in[$i] -ne '') {
    $r1,$r2 = $in[$i++].split(': ')
    $global:rules.Add([string]$r1,[string]$r2)
}
$i++
while ($i -lt $in.Length) {
    $messages += $in[$i++]
}

$global:mem = @{}

function parseRule([string]$num) {
    if ($global:mem.containsKey($num)) {
        #We have seen this before - return value from memory
        return $global:mem[$num]
    }
    elseif ($num -match '^\d+$') {
        #single rule number
        $r = $global:rules[$num]
        $val = ""
        if ($r -match '"(?<val>a|b)"') {
            $val = $Matches.val
        }
        else {
            $val = parseRule $r
        }
        $global:mem.Add($num, $val)
        return $val
    }
    elseif ($num.indexOf('|') -ge 0) {
        #List with options
        $val = "("
        $val += ($num.split(' | ') | % { parseRule $_ }) -join '|'
        $val += ")"
        $global:mem.Add($num, $val)
        return $val
    }
    else {
        #list of numbers
        $ret = ""
        foreach ($p in $num.split(' ').Trim()) {
            $ret += parseRule $p
        }
        $global:mem.Add($num, $ret)
        return $ret
    }
}

$pattern = "^" + (parseRule "0") + "$"
#write-host $pattern

$validMessages = 0
foreach($m in $messages) {
    if($m -match $pattern) {
        $validMessages++
    }
}

write-host ("Found {0} valid messages." -f $validMessages)
