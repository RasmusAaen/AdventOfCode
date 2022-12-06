$in = Get-Content .\input_day4.txt

$cnt = 0
foreach ($ln in $in) {
  $e1,$e2 = $ln -split ','
  [int]$e1a,[int]$e1b = $e1 -split '-'
  [int]$e2a,[int]$e2b = $e2 -split '-'
  if(($e1a -le $e2a -and $e1b -ge $e2b) -or ($e2a -le $e1a -and $e2b -ge $e1b)) {
    $cnt ++
  }
}
$cnt

$cnt = 0
foreach ($ln in $in) {
  $e1,$e2 = $ln -split ','
  [int]$e1a,[int]$e1b = $e1 -split '-'
  [int]$e2a,[int]$e2b = $e2 -split '-'
  $r1 = $e1a..$e1b
  $r2 = $e2a..$e2b
  foreach($num in $r1) {
    if ($r2 -contains $num) {
      $cnt++
      break
    }
  }
}
$cnt
