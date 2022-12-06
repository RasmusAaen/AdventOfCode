$in = Get-Content -Raw .\input_day5.txt
$stacks, $moves = $in.Split([System.Environment]::NewLine + [System.Environment]::NewLine,[System.StringSplitOptions]::RemoveEmptyEntries)
$stacks = $stacks.Split([System.Environment]::NewLine)
$stacks[-1] -match '(\d+)$' | Out-Null
[int]$numStacks = $Matches[0]

$moves = $moves.Split([System.Environment]::NewLine,[System.StringSplitOptions]::RemoveEmptyEntries)

$stacklist = [System.Collections.ArrayList]::new()
for ($i=0; $i -le $numStacks; $i++) {
  $stackList.Add([System.Collections.Stack]::new()) | Out-Null
}

for ($i=$stacks.Length-2; $i -ge 0; $i--) {
  $cnt = 1
  for($j = 1; $j -lt $stacks[$i].length; $j += 4){
    $v = $stacks[$i][$j]
    if ($v -ne ' ') {
      $stacklist[$cnt].Push($v)
    }
    $cnt++
  }
}

foreach($move in $moves) {
  $move -match 'move (\d+) from (\d+) to (\d+)' | Out-Null
  $num,$from,$to = $matches[1..3]
  for($i = 0; $i -lt $num; $i++) {
    $stacklist[$to].Push($stacklist[$from].Pop())
  }
}

$res = ''
for($i = 1;$i -lt $stacklist.Count; $i++){
  $res += $stacklist[$i].Peek()
}
write-host ("Part 1: " + $res)

$stacklist = [System.Collections.ArrayList]::new()
for ($i=0; $i -le $numStacks; $i++) {
  $stackList.Add([System.Collections.Stack]::new()) | Out-Null
}

for ($i=$stacks.Length-2; $i -ge 0; $i--) {
  $cnt = 1
  for($j = 1; $j -lt $stacks[$i].length; $j += 4){
    $v = $stacks[$i][$j]
    if ($v -ne ' ') {
      $stacklist[$cnt].Push($v)
    }
    $cnt++
  }
}

foreach($move in $moves) {
  $move -match 'move (\d+) from (\d+) to (\d+)' | Out-Null
  $num,$from,$to = $matches[1..3]
  $tmp = [System.Collections.Stack]::new()
  for($i = 0; $i -lt $num; $i++) {
    $tmp.Push($stacklist[$from].Pop())
  }
  for($i = 0; $i -lt $num; $i++) {
    $stacklist[$to].Push($tmp.Pop())
  }
}
$res = ''
for($i = 1;$i -lt $stacklist.Count; $i++){
  $res += $stacklist[$i].Peek()
}
write-host ("Part 2: " + $res)
