$in = [int[]](Get-Content .\input.txt)
for($i=0;$i -lt $in.count;$i++) {
  for($j=0;$j -lt $in.count;$j++) {
    $res = $in[$i] + $in[$j]
	if($res -eq 2020) {
	  write-host "$($in[$i]) + $($in[$j]) = 2020"
	  $sum = $in[$i] * $in[$j]
	  write-host "Answer: $sum"
	  return
	}
  }
}
