$in = Get-Content .\input.txt

$count = 0
for ($i = 0; $i -lt $in.Length; $i++) {
    #get all answers for group
    while ($in[$i] -ne "" -and $i -lt $in.Length) {
        $groupCount = 0
        $group = @{}
        while ($in[$i] -ne "" -and $i -lt $in.Length) {
            $in[$i].toCharArray() | % {
                if ($group.ContainsKey($_)) {
                    $group[$_]++
                }
                else {
                    $group.Add($_, 1)
                }
            }
            $i++
            $groupCount++
        }
        foreach($key in $group.Keys) {
            if($group[$key] -eq $groupCount) {
                $count++
            }
        }
    }
}
Write-Host ("Total number of yes answers is {0}" -f $count)
