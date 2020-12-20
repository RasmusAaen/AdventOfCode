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
write-host ("Image dimension is {0}x{1} tiles" -f $dimension, $dimension)

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
    $image += , $row
    $currentTile = $tiles | where { $_.number -eq $row[0].partnerbottom }
}

#Stitch image together
write-host "Stitching image together and removing borders..."
$imgData = @()
foreach ($row in $image) {
    for ($i = 1; $i -lt $row[0].data.Length - 1; $i++) {
        [string]$line = ""
        foreach ($tile in $row) {
            $line += $tile.data[$i].substring(1, $tile.data[$i].length - 2)
        }
        $imgData += $line
    }
}

$finalImage = [tile]::New("a", $imgData)

write-host "Get all possible images by rotating and flipping..."
$imageList = @()
$imageList += , $finalImage.data
$i = $finalImage.rotateLeft()
$imagelist += , $i.data
$i = $i.rotateLeft()
$imagelist += , $i.data
$i = $i.rotateLeft()
$imagelist += , $i.data
$i = $i.flip()
$imagelist += , $i.data
$i = $i.rotateLeft()
$imagelist += , $i.data
$i = $i.rotateLeft()
$imagelist += , $i.data
$i = $i.rotateLeft()
$imagelist += , $i.data

$imgDimension = $finalImage.data.Length
Write-Host ("Final image dimension is {0}x{1}" -f $imgDimension, $imgDimension)

$monster = @(
    "                  # ",
    "#    ##    ##    ###",
    " #  #  #  #  #  #   ")

$monsterLength = $monster[0].length
$monsterHeight = $monster.Length
$monsterPos = @()
write-host "Getting monster positions"
for ($y = 0; $y -lt $monsterHeight; $y++) {
    for ($x = 0; $x -lt $monsterLength; $x++) {
        if ($monster[$y][$x] -eq "#") {
            $monsterPos += , @($y, $x)
        }
    }
}

$monsterCount = $null
$correctImage = $null
write-host "Analyzing images for monsters..."
$cnt = 1
foreach ($image in $imageList) {
    write-host ("  Image {0}" -f $cnt++)
    $monsterCount = 0
    for ($y = 0; $y -lt $imgDimension - $monsterHeight; $y++) {
        for ($x = 0; $x -lt $imgDimension - $monsterLength; $x++) {
            $monsterFound = $true
            foreach ($point in $monsterPos) {
                if ($image[$y + $point[0]][$x + $point[1]] -ne "#") {
                    $monsterFound = $false
                    break
                }
            }
            if (!$monsterFound) {
                continue
            }
            $monsterCount++
        }
    }
    if ($monsterCount -gt 0) {
        $correctImage = $image
        break
    }
}

write-host ("{0} monsters found!" -f $monsterCount)

$waveCount = 0
foreach($line in $correctImage) {
    $line.ToCharArray() | %{if($_ -eq '#'){$waveCount++}}
}

write-host ("Number of '#' in image that are not part of a monster is {0}" -f ($waveCount - ($monsterPos.Length * $monsterCount)))
