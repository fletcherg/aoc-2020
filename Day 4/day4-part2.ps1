

$passports = (Get-Content day4input.txt | Out-String) -Split "$([System.Environment]::NewLine)$([System.Environment]::NewLine)"

$validPassports = "byr,cid,ecl,eyr,hcl,hgt,iyr,pid","byr,ecl,eyr,hcl,hgt,iyr,pid"
$validEyeColours = "amb","blu","brn","gry","grn","hzl","oth"
$valid = 0

foreach ($passport in $passports) {

	$passportData = @{}
	($passport.split(" ").split("`r`n") |?{$_}) | % {
		$passportData.Add($_.split(":")[0],$_.split(":")[1])
	}
	
	if ($validPassports -contains (($passportData.keys | Sort-Object) -join ",")) {
		$validation = $true
		if (($passportData.byr -lt 1920) -OR ($passportData.byr -gt 2002)) { $validation = $false }
		if (($passportData.iyr -lt 2010) -OR ($passportData.iyr -gt 2020)) { $validation = $false }
		if (($passportData.eyr -lt 2020) -OR ($passportData.eyr -gt 2030)) { $validation = $false }
		if ($passportData.hgt -match "^[0-9][0-9][0-9]cm$") {
			if (( $passportData.hgt.split("cm")[0] -lt 150 ) -OR ( $passportData.hgt.split("cm")[0] -gt 193 )) { $validation = $false }
		} elseif ($passportData.hgt -match "^[0-9][0-9]in$") {
			if (( $passportData.hgt.split("in")[0] -lt 59 ) -OR ( $passportData.hgt.split("in")[0] -gt 76 )) { $validation = $false }
		} else {
			$validation = $false
		}
		if ( ! ($passportData.hcl -match "^#[0-9A-F]{6}$" )) { $validation = $false }
		if ( $validEyeColours -notcontains $passportData.ecl ) { $validation = $false }
		if ( ! ($passportData.pid -match "^[0-9]{9}$")) { $validation = $falase }
		if ($validation) {
			$valid++
		}
	}
}
