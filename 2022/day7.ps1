$in = Get-Content .\input_day7.txt

class Folder {
  [string]$name
  [File[]]$files
  [Folder[]]$folders
  [int]$size
  [int]$subSize
  [Folder]$parent

  Folder([string]$n, [Folder]$f) {
    $this.name = $n
    $this.files = [File[]]@()
    $this.folders = [Folder[]]@()
    $this.size = 0
    $this.subSize = 0
    $this.parent = $f
  }
}

class File {
  [int]$Size
  [string]$Name

  File($s, $n) {
    $this.Size = $s
    $this.Name = $n
  }
}

$disk = [Folder]::new('/', $null)
$curDir = $null
for ($i = 0; $i -lt $in.Length; $i++) {
  switch -Regex ($in[$i].Trim()) {
    "^\$ cd \/$" {
      $curDir = $disk
      break
    }
    "^\$ ls$" {
      while ($in[$i + 1] -notlike '$ *' -and $i -le $in.Length) {
        if ($in[$i + 1] -like 'dir *') {
          $curDir.folders += [Folder]::new(($in[$i + 1] -split ' ')[1], $curDir)
        }
        else {
          $s, $f = $in[$i + 1] -split ' '
          $curDir.files += [File]::new($s, $f)
          $curDir.size += $s
        }
        $i++
      }
      break
    }
    "^\$ cd (\w+)$" {
      $curDir = $curDir.folders | where Name -eq $Matches[1]
      break
    }
    "^\$ cd \.\.$" {
      $t = $curDir.size + $curDir.subSize
      $curDir = $curDir.parent
      $curDir.subSize += $t
      break
    }
  }
}
# cd .. out to root to update sizes
while ($curDir.Name -ne '/') {
  $t = $curDir.size + $curDir.subSize
  $curDir = $curDir.parent
  $curDir.subSize += $t
}

function getFolders ([Folder]$f,$maxSize) {
  $res = 0
  $t = $f.size + $f.subSize
  if($f.size + $f.subSize -le $maxSize) {
    $res += $t
  }
  foreach ($sub in $f.folders) {
    $res += getFolders $sub $maxSize
  }
  return $res
}

$total = getFolders $disk 100000
Write-host "Part 1: $total"

$disksize = 70000000
$freeTarget = 30000000

$curFree = $disksize - ($disk.size + $disk.subSize)

$minSize = $freeTarget - $curFree

function getFolders1 ([Folder]$f,$minSize) {
  $res = @()
  $t = $f.size + $f.subSize
  if($f.size + $f.subSize -ge $minSize) {
    $res += $t
  }
  foreach ($sub in $f.folders) {
    $res += getFolders1 $sub $minSize
  }
  return $res
}

$part2 = getFolders1 $disk $minSize | where {$_ -gt 0} | sort | select -First 1

Write-Host "Part 2: $part2"
