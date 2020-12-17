$in = Get-Content .\input.txt

class rule {
    [int]$start1
    [int]$end1
    [int]$start2
    [int]$end2

    rule ([string]$i) {
        if ($i -match "^\w+: (?<n1>\d+)-(?<n2>\d+) or (?<n3>\d+)-(?<n4>\d+)$") {
            $this.start1 = $Matches.n1
            $this.end1 = $Matches.n2
            $this.start2 = $Matches.n3
            $this.end2 = $Matches.n4
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
$myTicket = $in[$i]

$i += 3
while($i -lt $in.Length) {
    $tickets += ,[int[]]($in[$i++] -split ',')
}

$scanErrorRate = 0

foreach($t in $tickets) {
    foreach($n in $t){
        $isValid = $false
        foreach($r in $rules) {
            if($r.isValid($n)) {
                $isValid = $true
                break
            }
        }
        if(!$isValid) {
            $scanErrorRate += $n
        }
    }
}

write-host ("ticket scanning error rate for {0} tickets is {1}" -f $tickets.Length,$scanErrorRate)
