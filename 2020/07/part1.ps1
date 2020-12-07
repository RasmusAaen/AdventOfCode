$in = Get-Content .\input.txt

#parse rules
$global:rules = @()
foreach($line in $in) {
    $color,$rest = ($line -split ' bags contain ')
    $b = [PSCustomObject]@{
        Color = [string]$color.Trim()
        Content = @{}
    }
    foreach($c in ($rest -split ,',')) {
        if($c -match "(?<num>\d+) (?<color>.+) bag") {
            $b.Content.Add([string]$Matches.color.Trim(),[int]$Matches.num)
        }
    }
    $global:rules += $b
}

#Very iniefficient way - I should store the recursive results for each bag as we go
#instead of calculating every one again and again.
function canContain([string]$find,[string]$bag) {
    $b = $Global:rules | Where-Object -Property Color -EQ -Value $bag
    if($b.Content.ContainsKey($find)) {
        return $true
    }
    $found = $false
    foreach($c in $b.Content.Keys) {
        if(canContain $find $c) {
            $found = $true
            break
        }
    }
    return $found
}

$find = "shiny gold"
$count  = 0
$progress = 0
foreach($bag in $Global:rules) {
    #write-host "." -NoNewLine
    Write-Progress -Activity "Finding bags..." -Status "Researching $($bag.Color)" -PercentComplete (($progress++/$global:rules.Count)*100)
    if(canContain $find $bag.Color) {
        $count++
    }
}

Write-Output ("Number of bags that can contain a {0} bag is {1}" -f $find,$count)


