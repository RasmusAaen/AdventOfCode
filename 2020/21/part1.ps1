$in = Get-Content .\input.txt

$allIngredients = @()
$allergens = @{}
$ingredients = @{}

foreach($line in $in) {
    $ing,$all = $line.split(' (contains ')
    [string[]]$ing = $ing.Split(' ')
    [string[]]$all = $all.TrimEnd(')').Split(', ')
    $allIngredients += $ing
    #Count ocurrences
    foreach($i in $ing) {
        if($ingredients.ContainsKey($i)) {
            $ingredients[$i]++
        } else {
            $ingredients.Add($i,1)
        }
    }
    
    #Find the intersections
    foreach($a in $all) {
        if($allergens.ContainsKey($a)) {
            $allergens[$a] =  [string[]]($allergens[$a] | where{$ing -contains $_})
        } else {
            $allergens.Add($a,[string[]]$ing)
        }
    }
}

$count = 0
$suspect = @()
$allergens.Values | %{$suspect += $_}
foreach($k in $ingredients.Keys) {
    if($suspect -notContains $k) {
        $count += $ingredients[$k]
    }
}

write-host ("ingredient count that does not contain allergens is {0}" -f $count)

$ingrCount = ($allergens.values | %{$_} | select -Unique).count
$identified = @{}
while($identified.Count -lt $ingrCount) {
    foreach($k in $allergens.Keys) {
        $ident = $identified.Values | %{$_}
        $possible = $allergens[$k] | where{$ident -notcontains $_}
        if($possible.count -eq 1) {
            $identified.Add($k,[string]$possible)
        }
    }
}
$ingList = @()
foreach($k in ($identified.Keys | sort)) {
    $ingList += $identified[$k]
}

$list = $ingList -join ','

write-host ("Canonical ingredient list: {0}" -f $list)
