$in = Get-Content .\input_day10.txt

$global:cycle = 1
$global:investigate = 20
$global:x = 1

$global:sigStrength = 0

function checkCycle {
  if($cycle -eq $investigate) {
    $global:sigStrength += $x*$cycle
    $global:investigate += 40
  }
}

for($i =0 ; $i -lt $in.Length; $i++) {
  if($in[$i] -eq 'noop'){
    checkCycle
    $cycle += 1
  } else {
    $n = [int]$in[$i].split(' ')[1]
    checkCycle
    $cycle += 1
    checkCycle
    $cycle += 1
    $x += $n
  }
}

Write-host "Part1: $sigStrength"

$global:crt = $null
$global:crt = New-Object 'char[,]' 6, 40
$global:cycle = 1
$global:x = 1

function showCRT {
  for ($i = 0; $i -lt 6; $i++) {
    $o = ''
    for ($j = 0; $j -lt 40; $j++) {
      $o += $global:crt[$i, $j]
    }
    $o
  }
}
function drawSprite {
  $l = [Math]::floor(($cycle - 1) / 40)
  $r = ($cycle % 40)
  if ($r -ge ($x) -and $r -le ($x + 2)) {
    $global:crt[$l, ($r-1)] = [char]'#'
  }
  else {
    $global:crt[$l, ($r-1)] = [char]'.'
  }
}

for ($i = 0 ; $i -lt $in.Length; $i++) {
  if ($in[$i] -eq 'noop') {
    drawSprite
    $cycle += 1
  }
  else {
    $n = [int]$in[$i].split(' ')[1]
    drawSprite
    $cycle += 1
    drawSprite
    $cycle += 1
    $x += $n
  }
}

Write-Host "Part 2:"
showCRT
