$in = Get-Content .\input_day9.txt

function move-rope ([string[]]$moves, [int]$num) {
  $knots = @()
  $visit = @{'0,0' = 1 }
  for ($i = 0; $i -lt $num; $i++) {
    $knots += , @(0, 0)
  }
  foreach ($move in $in) {
    [string]$d, [int]$c = $move -split ' '
    for ($i = 1; $i -le $c; $i++) {
      switch ($d) {
        'U' { $knots[0][0] += 1 ; break }
        'D' { $knots[0][0] -= 1 ; break }
        'R' { $knots[0][1] += 1 ; break }
        'L' { $knots[0][1] -= 1 ; break }
      }
      for ($k = 1; $k -lt $num; $k++) {
        $dist = [Math]::Sqrt([math]::Pow(($knots[$k - 1][0] - $knots[$k][0]), 2) + [math]::Pow(($knots[$k - 1][1] - $knots[$k][1]), 2))
        if ($dist -ge 2) {
          if ($knots[$k][0] -eq $knots[$k - 1][0]) {
            #same x pos - move y
            if ($knots[$k - 1][1] -gt $knots[$k][1]) {
              $knots[$k][1] += 1
            }
            else {
              $knots[$k][1] -= 1
            }
          }
          #same y pos - move x
          elseif ($knots[$k][1] -eq $knots[$k - 1][1]) {
            if ($knots[$k - 1 ][0] -gt $knots[$k][0]) {
              $knots[$k][0] += 1
            }
            else {
              $knots[$k][0] -= 1
            }
          }
          # diagonal diff
          else {
            if ([Math]::Abs($knots[$k][0] - $knots[$k - 1][0]) -gt ($knots[$k][1] - $knots[$k - 1][1])) {
              #diff is in x axis
              if ($knots[$k - 1][0] -gt $knots[$k][0]) {
                $knots[$k][0] += 1
              }
              else {
                $knots[$k][0] -= 1
              }
              if ($knots[$k - 1][1] -gt $knots[$k][1]) {
                $knots[$k][1] += 1
              }
              else {
                $knots[$k][1] -= 1
              }
            }
            else {
              if ($knots[$k - 1][1] -gt $knots[$k][1]) {
                $knots[$k][1] += 1
              }
              else {
                $knots[$k][1] -= 1
              }
              if ($knots[$k - 1][0] -gt $knots[$k][0]) {
                $knots[$k][0] += 1
              }
              else {
                $knots[$k][0] -= 1
              }
            }
          }
          if ($k -eq $knots.Length - 1) {
            $key = "$($knots[-1][0]),$($knots[-1][1])"
            if (!$visit.ContainsKey($key)) {
              $visit.Add($key, 1)
            }
          }
        }
      }
    }
  }
  return $visit.Keys.Count
}


$p1 = move-rope $in 2
Write-Host "Part 1: $p1"

$p2 = move-rope $in 10
Write-Host "Part 2: $p2"
