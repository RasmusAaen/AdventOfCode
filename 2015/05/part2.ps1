$in = Get-Content .\input.txt

$nice = 0
foreach($line in $in) {
    #any two letters that appears at least twice
    if($line -notmatch "(..).*\1") {continue}

    #contains at least one letter which repeats with exactly one letter between them
    if($line -notmatch "(.).\1") {continue}

    $nice++
}
Write-Host ("Found {0} nice strings" -f $nice)
