[int[]]$in = Get-Content .\test2.txt

$adapters = $in | sort

$outlet = 0
$rating = ($in | sort | select -last 1)+3

function getPaths([int]$adapter,[int[]]$list, [string]$path) {
    $path += "$adapter, "
    if($list.length -eq 1) {
        #We reached the end
        return "$($path)$($list[0]), ($($rating))"
    }
    for($i=0;$i -lt $list.length;$i++) {
        if($list[$i] -le ($adapter +3)) {
            getPaths $list[$i] $list[($i+1)..($list.Length)] $path
        } else {
            break
        }
    }
}

$paths = getPaths $outlet $adapters ""
