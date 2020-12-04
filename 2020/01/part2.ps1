$in = [int[]](Get-Content .\input.txt)
for($i=0;$i -lt $in.count;$i++) {
  for($j=0;$j -lt $in.count;$j++) {
    for($k=0;$k -lt $in.count;$k++) {
      $res = $in[$i] + $in[$j] + $in[$k]
      if($res -eq 2020) {
	    write-host ("{0} + {1} + {2} = 2020" -f $in[$i],$in[$j],$in[$k])
	    write-host ("Answer: {0}" -f ($in[$i] * $in[$j] * $in[$k]))
	    return
	  }
	}
  }
}
