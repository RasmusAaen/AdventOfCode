$in = [int[]]((Get-Content .\input.txt) -split ',')

#load intCode computer
. ..\intCode.ps1

#Look for two start values that result in 19690720
:loop1 for ($i = 0; $i -le 99; $i++) {
    :loop2 for ($j = 0; $j -le 99; $j++) {
        $mem = [int[]](cloneObject $in)
        $mem[1] = $i
        $mem[2] = $j
        $out = [int](runIntcode $mem)
        
        if ($out -eq 19690720) {
            write-host ("Result found with input {0} and {1}. Answer is {2}" -f $i, $j, ([int](100 * $i) + [int]$j))
            break loop1
        }
    }
}
