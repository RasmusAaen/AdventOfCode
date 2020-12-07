$in = Get-Content .\input.txt

#parse rules
$global:rules = @()
foreach ($line in $in) {
    $color, $rest = ($line -split ' bags contain ')
    $b = [PSCustomObject]@{
        Color      = [string]$color.Trim()
        Content    = @{}
        CanContain = @()
    }
    foreach ($c in ($rest -split , ',')) {
        if ($c -match "(?<num>\d+) (?<color>.+) bag") {
            $b.Content.Add([string]$Matches.color.Trim(), [int]$Matches.num)
        }
    }
    $global:rules += $b
}

#Add canContain info to each bag type 
function getCanContain([object]$bag) {
    $idx = $global:rules.IndexOf($bag)
    foreach ($color in $bag.Content.Keys) {
        $global:rules[$idx].canContain += $color
        $b = $global:rules | where { $_.color -eq $color }
        if ($b.canContain.length -eq 0) {
            getCanContain $b
        }
        $global:rules[$idx].canContain += $b.CanContain
    }
    $global:rules[$idx].canContain = $global:rules[$idx].canContain | select -Unique
}

$c=0
foreach ($bag in $Global:rules) {
    Write-Progress -Activity "Processing bag colors" -Status $bag.Color -PercentComplete (($c++/$global:rules.Count)*100)
    if ($bag.CanContain.Length -eq 0) {
        getCanContain $bag
    }
}

$find = "shiny gold"
$count = ($global:rules | where{$_.canContain -contains $find}).count

Write-Host ("Found {0} bags that can contain a {1} bag" -f $count,$find)
