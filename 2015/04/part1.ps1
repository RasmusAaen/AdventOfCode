$in = "bgvyzdsv"

$md5 = [System.Security.Cryptography.HashAlgorithm]::Create("MD5")
$enc = [system.Text.Encoding]::UTF8

$i=0
while($true) {
    if($i%100000 -eq 0) {Write-Host -NoNewline '.'}
    $data = $enc.GetBytes("$($in)$($i)") 
    $hash = [System.Convert]::ToHexString($md5.ComputeHash($data))
    if($hash -match "^0{5}") {
        Write-Host ("Lowest number to give a hash starting with 5 zeros: {0}" -f $i)
        break
    }
    $i++
}
