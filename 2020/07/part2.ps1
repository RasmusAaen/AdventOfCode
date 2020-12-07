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

function getBagCount([string]$color) {
    $count = 0
    $b = $Global:rules | Where-Object -Property Color -EQ -Value $color
    foreach($bag in $b.Content.Keys) {
        $count += $b.Content[$bag]
        $count += ($b.Content[$bag] * (getBagCount $bag))
    }
    return $count
}

$find = "shiny gold"
$count = getBagCount $find

Write-Output ("total number of bags in a {0} bag is {1}" -f $find,$count)
