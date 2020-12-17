$in = Get-Content .\input.txt

class rule {
    [string]$name
    [int]$start1
    [int]$end1
    [int]$start2
    [int]$end2
    [int[]]$rows

    rule ([string]$i) {
        if ($i -match "^(?<n>.+): (?<n1>\d+)-(?<n2>\d+) or (?<n3>\d+)-(?<n4>\d+)$") {
            $this.name = $Matches.n
            $this.start1 = $Matches.n1
            $this.end1 = $Matches.n2
            $this.start2 = $Matches.n3
            $this.end2 = $Matches.n4
            $this.rows = [int[]]@()
        }
    }
    
    [bool]isValid([int]$i) {
        return (($i -ge $this.start1 -and $i -le $this.end1) -or ($i -ge $this.start2 -and $i -le $this.end2))
    }
}

#Parse input
$rules = @()
$tickets = @()

$i = 0
while ($in[$i] -ne '') {
    $rules += [rule]::New($in[$i++])
}
$i += 2
$myTicket = [int[]]($in[$i] -split ',')

$i += 3
while ($i -lt $in.Length) {
    $tickets += , [int[]]($in[$i++] -split ',')
}

#Find valid tickets
$validTickets = @()
:loop1 foreach ($t in $tickets) {
    foreach ($n in $t) {
        $isValid = $false
        foreach ($r in $rules) {
            if ($r.isValid($n)) {
                $isValid = $true
                break
            }
        }
        if (!$isValid) {
            continue loop1
        }
    }
    $validTickets += , $t
}

#Determine which rows are valid for which rules
for ($i = 0; $i -lt $validTickets[0].Length; $i++) {
    $nums = $validTickets | foreach { $_[$i] }
    foreach ($r in $rules) {
        $isValid = $true
        foreach ($n in $nums) {
            if (!$r.isValid($n)) {
                #write-host ("{0} is not valid as {1}" -f $n,$r.name)
                $isValid = $false
                break
            }
        }
        if ($isValid) {
            $r.rows += $i
        }
    }
}

#Find order of fields by verifying which field has only one valid row
$fieldOrder = @("") * 20
while ($fieldOrder -contains "") {
    $foundRows = @()
    foreach ($r in $rules | where { $_.rows.Length -eq 1 }) {
        $fieldOrder[$r.rows[0]] = $r.name
        $foundRows += $r.rows[0]
    }
    foreach ($row in $foundRows) {
        foreach ($r in $rules) {
            $r.rows = $r.rows | where { $_ -ne $row }
        }
    }
}

#Calculate result
$res = 1
for ($i = 0; $i -lt $fieldOrder.Length; $i++) {
    if ($fieldOrder[$i] -like 'departure*') {
        $res = $res * $myTicket[$i]
    }
}

write-host ("Answer for part 2 is {0}" -f $res)
