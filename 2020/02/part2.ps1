$in = get-content .\input.txt
$valid = 0
foreach($line in $in) {
  $pattern = "^(\d+)-(\d+)\s(.):\s(.+)$"
  if($line -match $pattern) {
    $pos1,$pos2,$letter,$pw = $matches[1..4]
    if(($pw[$pos1-1] -eq $letter -and $pw[$pos2-1] -ne $letter) -or ($pw[$pos1-1] -ne $letter -and $pw[$pos2-1] -eq $letter)) {
      $valid++
    }
  } else {
	  "no match"
  }
}
Write-host ("Found {0} valid passwords" -f $valid)
