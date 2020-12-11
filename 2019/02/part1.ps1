$in = [int[]]((Get-Content .\input.txt) -split ',')

#load intCode computer
. ..\intCode.ps1

$mem = [int[]](cloneObject $in)
$mem[1] = 12
$mem[2] = 2
$out = [int](runIntcode $mem)

Write-Host ("Result: {0}" -f $out)
