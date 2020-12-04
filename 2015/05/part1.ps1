$in = Get-Content .\input.txt

$nice = 0
foreach($line in $in) {
    #at least three vovels
    $vovels = [regex]::Matches($line,"[aeiou]").Count
    if($vovels -lt 3) {continue}
    
    #at least one letter twice in a row
    if($line -notmatch "(.)\1{1}") {continue}

    #no forbidden strings
    if($line -match "(ab|cd|pq|xy)") {continue}

    $nice++
}
Write-Host ("Found {0} nice strings" -f $nice)
