$in = get-content .\input.txt

function reverse([string]$a) {
    return ([regex]::Matches($a, '.', 'RightToLeft') | ForEach { $_.value }) -join '' 
}

class tile {
    [string]$number
    [string[]]$data
    [string]$edgeRight
    [string]$edgeLeft
    [string]$edgeTop
    [string]$edgeBottom
    [string]$partnerRight
    [string]$partnerLeft
    [string]$partnerTop
    [string]$partnerBottom

    tile([string]$a, [string[]]$d) {
        $this.number = $a
        $this.data = $d

        $this.edgeLeft = (($this.data | foreach { $_[0] }) -join '')
        $this.edgeRight = (($this.data | foreach { $_[-1] }) -join '')
        $this.edgeTop = ($this.data[0])
        $this.edgeBottom = ($this.data[-1])

        $this.partnerRight = ""
        $this.partnerLeft = ""
        $this.partnerTop = ""
        $this.partnerBottom = ""

    }

    [tile]rotateLeft() {
        $v = @()
        for ($i = 0; $i -lt $this.data.Length; $i++) {
            $v += reverse(($this.data | foreach { $_[$i] }) -join '')
        }
        return [tile]::New($this.number, $v)
    }

    [tile]flip() {
        $v = @()
        for ($i = $this.data.Length - 1; $i -ge 0; $i--) {
            $v += $this.data[$i]
        }
        return [tile]::New($this.number, $v)
    }
}

#bulid tiles
write-host "Getting input and building tiles..."
$tiles = @()
for ($i = 0; $i -lt $in.length; $i++) {
    $num = $in[$i++].TrimStart('Tile ').TrimEnd(':')
    $t = @()
    while ($in[$i] -ne '' -and $i -lt $in.length) {
        $t += $in[$i++]
    }
    $tiles += [tile]::New($num, $t)
}

$dimension = [math]::Sqrt($tiles.count)
write-host "Image dimension is {0}x{1}" -f $dimension,$dimension

write-host ("Building every possible version of tile collection...")
#Get every possible copy of a tile
$versions = @()
foreach ($t in $tiles) {
    $t1 = $t.rotateLeft()
    $t1.number = $t.number + 'a'
    $versions += $t1
    $t2 = $t1.rotateLeft()
    $t2.number = $t.number + 'aa'
    $versions += $t2
    $t3 = $t2.rotateLeft()
    $t3.number = $t.number + 'aaa'
    $versions += $t3
    $t4 = $t.flip()
    $t4.number = $t.number + 'aaaa'
    $versions += $t4
    $t5 = $t4.rotateLeft()
    $t5.number = $t.number + 'aaaaa'
    $versions += $t5
    $t6 = $t5.rotateLeft()
    $t6.number = $t.number + 'aaaaaa'
    $versions += $t6
    $t7 = $t6.rotateLeft()
    $t7.number = $t.number + 'aaaaaaa'
    $versions += $t7
}

$tiles += $versions

Write-Host ("Matching tile edges...")
#find matching tiles
foreach ($tile in $tiles) {
    $t = $tiles | where { $_.edgeLeft -eq $tile.edgeRight -and $_.number.TrimEnd('a') -ne $tile.number.TrimEnd('a') }
    if ($t) {
        $tile.partnerRight = $t.number
    }
    $t = $tiles | where { $_.edgeRight -eq $tile.edgeLeft -and $_.number.TrimEnd('a') -ne $tile.number.TrimEnd('a') }
    if ($t) {
        $tile.partnerLeft = $t.number
    }
    $t = $tiles | where { $_.edgeTop -eq $tile.edgeBottom -and $_.number.TrimEnd('a') -ne $tile.number.TrimEnd('a') }
    if ($t) {
        $tile.partnerBottom = $t.number
    }
    $t = $tiles | where { $_.edgeBottom -eq $tile.edgeTop -and $_.number.TrimEnd('a') -ne $tile.number.TrimEnd('a') }
    if ($t) {
        $tile.partnerTop = $t.number
    }
}

#build image
write-host "Building image..."
$image = [tile[][]]@()
#Find one of the corner pieces and start from there
$currentTile = $tiles | where { $_.partnerLeft -eq '' -and $_.partnerTop -eq '' } | select -first 1
for ($i = 0; $i -lt $dimension; $i++) {
    $row = @()
    for ($j = 0; $j -lt $dimension; $j++) {
        $row += $currentTile
        $currentTile = $tiles | where { $_.number -eq $currentTile.partnerRight }
    }
    $image += ,$row
    $currentTile = $tiles | where { $_.number -eq $row[0].partnerbottom }
}

write-host "Finished image tiles:"
foreach($r in $image) {
    write-host (($r |foreach{$_.number.TrimEnd('a')}) -join ' ')
}
[int64]$val = 1
$val *= [int]$image[0][0].Number.trimEnd('a')
$val *= [int]$image[0][-1].Number.trimEnd('a')
$val *= [int]$image[-1][0].Number.trimEnd('a')
$val *= [int]$image[-1][-1].Number.trimEnd('a')
write-host ("Product of corner pieces is {0}" -f $val)

