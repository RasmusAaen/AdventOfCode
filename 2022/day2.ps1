$in = Get-Content .\input_day2.txt

$score = 0

$sc = @{
  'X' = 1
  'Y' = 2
  'Z' = 3
}

foreach($round in $in) {
  $op,$me = $round -split ' '
  $score += $sc[$me]
  if($me -eq 'X') {
    if($op -eq 'A') {
      $score += 3
    } elseif ($op -eq 'C') {
      $score += 6
    }
  }
  if($me -eq 'Y') {
    if($op -eq 'B') {
      $score += 3
    } elseif ($op -eq 'A') {
      $score += 6
    }
  }
  if($me -eq 'Z') {
    if($op -eq 'C') {
      $score += 3
    } elseif ($op -eq 'B') {
      $score += 6
    }
  }
}
$score

$score = 0

foreach ($round in $in) {
  $op,$res = $round -split ' '
  switch ($res) {
    'X' {}
    'Y' { $score += 3}
    'Z' { $score += 6}
  }

  if($op -eq 'A') {
    if($res -eq 'X') {
      $me = 'Z'
      $score += $sc[$me]
    } elseif ($res -eq 'Y') {
      $me = 'X'
      $score += $sc[$me]
    } else {
      $me = 'Y'
      $score += $sc[$me]
    }
  }
  if($op -eq 'B') {
    if($res -eq 'X') {
      $me = 'X'
      $score += $sc[$me]
    } elseif ($res -eq 'Y') {
      $me = 'Y'
      $score += $sc[$me]
    } else {
      $me = 'Z'
      $score += $sc[$me]
    }
  }
  if($op -eq 'C') {
    if($res -eq 'X') {
      $me = 'Y'
      $score += $sc[$me]
    } elseif ($res -eq 'Y') {
      $me = 'Z'
      $score += $sc[$me]
    } else {
      $me = 'X'
      $score += $sc[$me]
    }
  }
}

$score
