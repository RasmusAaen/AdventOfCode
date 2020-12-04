class passport {
    [string]$birthYear
    [string]$issueYear
    [string]$expirationYear
    [string]$height
    [string]$hairColor
    [string]$eyeColor
    [string]$passportId
    [string]$countryId

    [bool]birthYearIsValid() {
        if ($null -eq $this.birthYear) { return $false }
        if ($this.birthYear -notmatch "\d{4}") { return $false }
        if (($this.birthYear -lt 1920 -or $this.birthYear -gt 2002)) { return $false }
        return $true
    }
    
    [bool]issueYearIsValid() {
        if ($null -eq $this.issueYear) { return $false }
        if ($this.issueYear -notmatch "\d{4}") { return $false }
        if (($this.issueYear -lt 2010 -or $this.issueYear -gt 2020)) { return $false }
        return $true
    }

    [bool]expirationYearIsValid() {
        if ($null -eq $this.expirationYear) { return $false }
        if ($this.expirationYear -notmatch "\d{4}") { return $false }
        if (($this.expirationYear -lt 2020 -or $this.expirationYear -gt 2030)) { return $false }
        return $true
    }

    [bool]heightIsValid() {
        if ($null -eq $this.height) { return $false }
        $pattern = "^(\d+)(in|cm)$"
        if ($this.height -match $pattern) {
            $h, $u = $Matches[1..2]
            switch ($u) {
                "cm" {
                    if ($h -lt 150 -or $h -gt 193) { return $false }
                }
                "in" {
                    if ($h -lt 59 -or $h -gt 76) { return $false }
                }
            }
        }
        else {
            return $false
        }
        return $true
    }

    [bool]hairColorIsValid() {
        if ($null -eq $this.hairColor) { return $false }
        $pattern = "^#[a-zA-Z0-9]{6}$"
        if ($this.hairColor -notmatch $pattern) { return $false }
        return $true
    }

    [bool]eyeColorIsValid() {
        $pattern = "^(amb|blu|brn|gry|grn|hzl|oth)$"
        if ($this.eyeColor -notmatch $pattern) { return $false }
        return $true
    }

    [bool]passportIdIsValid() {
        $pattern = "^\d{9}$"
        if ($this.passportId -notmatch $pattern) { return $false }
        return $true
    }

    [bool]isValidTask2() {
        if ($this.birthYearIsValid() -and `
                $this.issueYearIsValid() -and `
                $this.expirationYearIsValid() -and `
                $this.heightIsValid() -and `
                $this.hairColorIsValid() -and `
                $this.eyeColorIsValid() -and `
                $this.passportIdIsValid()) {
            return $true
        }
        else {
            return $false
        }
        
    }

    [bool]isValidTask1() {
        if($null -eq $this.birthYear) {return $false}
        if($null -eq $this.issueYear) {return $false}
        if($null -eq $this.expirationYear) {return $false}
        if($null -eq $this.height) {return $false}
        if($null -eq $this.hairColor) {return $false}
        if($null -eq $this.eyeColor) {return $false}
        if($null -eq $this.passportId) {return $false}
        return $true
    }
}
function parsePassport ($str) {
    $p = [passport]::new()
    foreach ($item in ($str -split ' ')) {
        $k, $v = $item -split ':'
        switch ($k) {
            "byr" { $p.birthYear = $v; break }
            "iyr" { $p.issueYear = $v; break }
            "eyr" { $p.expirationYear = $v; break }
            "hgt" { $p.height = $v; break }
            "hcl" { $p.hairColor = $v; break }
            "ecl" { $p.eyeColor = $v; break }
            "pid" { $p.passportId = $v; break }
            "cid" { $p.countryId = $v; break }
            "default" { Write-Error "Field $k not recognised" }
        }
    }
    return $p
}

#Main
$in = get-content .\input.txt
#$in = get-content .\valid.txt

#parse text file
$passports = @()
for ($i = 0; $i -lt $in.Length; $i++) {
    $str = ""
    while ($in[$i].Length -ne 0) {
        $str += $in[$i++] + " "
    }
    $passports += (parsePassport $str)
}

#count task1 valid passports
$valid = 0
foreach ($passport in $passports) {
    if ($passport.isValidTask1()) {
        $valid++
    }
}
Write-Host ("Found {0} valid passports in taks 1" -f $valid)

#count task2 valid passports
$valid = 0
foreach ($passport in $passports) {
    if ($passport.isValidTask2()) {
        $valid++
    }
}
Write-Host ("Found {0} valid passports in task 2" -f $valid)
