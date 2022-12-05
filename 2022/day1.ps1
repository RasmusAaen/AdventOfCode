$in = Get-Content .\input_day1.txt
$cals = @()
$c = 0
foreach($ln in $in) {
  if($ln -eq '') {
    $cals += $c
    $c = 0
  } else {
    $c += [int]$ln
  }
}
$cals | sort -Descending| select -first 1

($cals | sort -Descending | select -First 3 | measure -Sum).Sum

