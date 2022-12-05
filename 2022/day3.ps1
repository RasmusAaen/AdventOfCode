$in = Get-Content .\input_day3.txt
$pri = [hashtable]::new()
$cnt = 1
'a'..'z' | foreach {$pri.Add($_,$cnt++)}
'A'..'Z' | foreach {$pri.Add($_,$cnt++)}

#Part 1
$res = 0
foreach ($rucksac in $in) {
  $mid = [math]::Floor((($rucksac.Length+1)/2))
  $c1 = [char[]]($rucksac[0..($mid-1)])
  $c2 = [char[]]($rucksac[$mid..($rucksac.Length-1)])
  for($i=0;$i -lt $c1.Length;$i++) {
    if($c2 -ccontains $c1[$i]) {
      $res += $pri[$c1[$i]]
      break
    }
  }
}
$res

#Part2
$res = 0
$i = 0
while ($i -lt $in.Length) {
  $r1 = [char[]]$in[$i]
  $r2 = [char[]]$in[$i+1]
  $r3 = [char[]]$in[$i+2]
  for($j = 0; $j -lt $r1.length; $j++) {
    if($r2 -ccontains $r1[$j] -and $r3 -ccontains $r1[$j]) {
      $res += $pri[$r1[$j]]
      break
    }

  }
  $i += 3
}

$res
