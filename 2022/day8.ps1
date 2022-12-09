$in = Get-Content .\input_day8.txt

$forest = New-Object 'int[,]' $in.Length,$in[0].Length
$visible = New-Object 'int[,]' $in.Length,$in[0].Length

for($i = 0; $i -lt $in.length; $i++) {
  for ($j=0;$j -lt $in[0].length; $j++) {
    $forest[$i,$j] = [int]$in[$i][$j].toString()
  }
}

# $i = vertical
# $j = horizontal

for($i = 0; $i -lt $in.Length ; $i++) {
  #From left to right
  $max = -1
  for ($j = 0; $j -lt $in[0].Length; $j++) {
    if($forest[$i,$j] -gt $max) {
      $visible[$i,$j] = 1
      $max = $forest[$i,$j]
    }
    if ($max -eq 9) {
      break
    }
  }
  #From right to left
  $max = -1
  for ($j = $in[0].Length -1; $j -ge 0; $j--) {
    if($forest[$i,$j] -gt $max) {
      $visible[$i,$j] = 1
      $max = $forest[$i,$j]
    }
    if ($max -eq 9) {
      break
    }
  }
}
for($j = 0; $j -lt $in[0].length; $j++) {
  #Top to bottom
  $max = -1
  for ($i = 0; $i -lt $in.Length; $i++) {
    if($forest[$i,$j] -gt $max) {
      $visible[$i,$j] = 1
      $max = $forest[$i,$j]
    }
    if ($max -eq 9) {
      break
    }
  }
  #Bottom to top
  $max = -1
  for ($i = $in.Length -1; $i -ge 0; $i--) {
    if($forest[$i,$j] -gt $max) {
      $visible[$i,$j] = 1
      $max = $forest[$i,$j]
    }
    if ($max -eq 9) {
      break
    }
  }
}

# Output forest
# for($i = 0; $i -lt $in.Length; $i++) {
#   $l = ''
#   for ($j = 0; $j -lt $in[0].length; $j++) {
#     $l += $forest[$i,$j].toString()
#   }
#   Write-Host $l
# }

# Output visible
# for($i = 0; $i -lt $in.Length; $i++) {
#   $l = ''
#   for ($j = 0; $j -lt $in[0].length; $j++) {
#     $l += $visible[$i,$j].toString()
#   }
#   Write-Host $l
# }

$cnt = $visible | Measure-Object -Sum  | Select-Object -ExpandProperty Sum
write-host "part 1: $cnt"

$max = 0

for($i=0; $i -lt $in.Length; $i++){
  for ($j=0; $j -lt $in[0].length; $j++) {
    $val = New-Object 'int[]' 4
    #Up
    $k = $i - 1
    while($k -ge 0) {
      $val[0]++
      if($forest[$k,$j] -ge $forest[$i,$j]) {
        break
      }
      $k--
    }
    #Right
    $k = $j + 1
    while($k -lt $in[0].length) {
      $val[1]++
      if($forest[$i,$k] -ge $forest[$i,$j]) {
        break
      }
      $k++
    }
    #Down
    $k = $i + 1
    while($k -lt $in.Length) {
      $val[2]++
      if($forest[$k,$j] -ge $forest[$i,$j]) {
        break
      }
      $k++
    }
    #left
    $k = $j - 1
    while($k -ge 0) {
      $val[3]++
      if($forest[$i,$k] -ge $forest[$i,$j]) {
        break
      }
      $k--
    }
    $score = $val[0] * $val[1] * $val[2] * $val[3]
    if($score -gt $max) {
      $max = $score
    }
  }
}

write-host "part 2: $max"
