$in = Get-Content -Path .\input_day11.txt

$global:monkeys = @()

#Part 1 was straight-forward calculation
#Part 2 requires using The Chinese Remainter theorem - https://en.wikipedia.org/wiki/Chinese_remainder_theorem
#Had to look at reddit solutions to find this answer
#As all test divisors are primes, ww can reduce all worry values to $worry % (product of all divisors)
$global:divisorProduct = 1

class monkey {
  [System.Collections.Generic.List[Int64]]$items
  [string]$op
  [int]$test
  [int]$t
  [int]$f
  [int]$insp = 0

  [void]throwItems([bool]$part2 = $false) {
    while ($this.items.Count -gt 0) {
      $this.insp++
      $it = $this.items[0]
      $this.items.RemoveAt(0)
      $it = [int64](Invoke-Expression ($this.op.Replace('old', $it)))
      if (!$part2) {
        $it = [Math]::floor($it / 3)
      }
      $m = (($it % $this.test) -eq 0) ? $this.t : $this.f
      $global:monkeys[$m].items.Add(($it % $global:divisorProduct))
    }
  }
}

#Parse input
function parseInput {
  $global:monkeys = @()
  $global:divisorProduct = 1
  for ($i = 0; $i -lt $in.Length; $i++) {
    if ($in[$i] -like 'Monkey*') {
      $m = [monkey]::new()
      $i++
      $m.items = ($in[$i] -split ': ')[1] -split ', '
      $i++
      $m.op = (($in[$i] -split ': ')[1] -split '= ')[1]
      $i++
      $m.test = [int](($in[$i] -split 'by ')[1])
      $global:divisorProduct *= $m.test
      $i++
      $m.t = [int](($in[$i] -split 'monkey ')[1])
      $i++
      $m.f = [int](($in[$i] -split 'monkey ')[1])
      $global:monkeys += $m
    }
  }
}

function monkeyBusiness([int]$rounds, [bool]$part2) {
  parseInput
  for ($i = 0; $i -lt $rounds; $i++) {
    foreach ($monkey in $global:monkeys) {
      $monkey.throwItems($part2)
    }
    if(($i % 1000) -eq 0) {
      Write-Host '.' -NoNewline
    }
  }
  Write-Host ''
  $m1, $m2 = $monkeys | Select-Object -ExpandProperty insp | Sort-Object -Descending | Select-Object -First 2
  return $m1*$m2
}

write-host "Part1: $(monkeyBusiness 20 $false)"
write-host "Part2: $(monkeyBusiness 10000 $true)"
