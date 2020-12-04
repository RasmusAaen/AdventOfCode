$in = get-content .\input.txt
$valid = 0
foreach($line in $in) {
  $pattern = "(\d+)-(\d+)\s(.):\s(.+)"
  $line -match $pattern | out-null
  $min = $Matches[1]
  $max = $Matches[2]
  $letter = $Matches[3]
  $pw = $matches[4]
  $count = [regex]::Matches($pw,$letter).Count
  if($count -ge $min -and $count -le $max) {
    $valid++
  }
}
Write-host ("Found {0} valid passwords" -f $valid)
