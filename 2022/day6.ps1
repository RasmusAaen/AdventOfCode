$in = Get-Content -Raw .\input_day6.txt

for($i = 3; $i -lt $in.Length; $i++){
  $uniq = ($in[($i-3)..$i] | select -Unique).count
  if($uniq -eq 4) {
    $i+1
    break
  }
}

for($i = 14; $i -lt $in.Length; $i++){
  $uniq = ($in[($i-14)..$i] | select -Unique).count
  if($uniq -eq 14) {
    $i+1
    break
  }
}
