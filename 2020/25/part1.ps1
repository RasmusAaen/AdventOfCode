$in = Get-Content .\input.txt

class device {
    [int]$publicKey
    [int]$privateKey
    [int]$subjectNumber
    [int]$loopSize

    device([int]$k, [int]$s) {
        $this.publicKey = $k
        $this.subjectNumber = $s
        $this.loopSize = 0
        $this.privateKey = -1
    }
}

$card = [device]::new($in[0], 7)
$door = [device]::new($in[1], 7)


$val = 1
do {
    $val = ($val * $card.subjectNumber) % 20201227
    $card.loopSize++
} while ($val -ne $card.publicKey)

$val = 1
for ($i = 0; $i -lt $card.loopSize; $i++) {
    $val = ($val * $door.publicKey) % 20201227
}

Write-Host ("Encryption key is {0}" -f $val)


