

$passports = (Get-Content day4input.txt | Out-String) -Split "$([System.Environment]::NewLine)$([System.Environment]::NewLine)"

$validPassports = "byr,cid,ecl,eyr,hcl,hgt,iyr,pid","byr,ecl,eyr,hcl,hgt,iyr,pid"

$valid = 0
foreach ($passport in $passports) {

	$passportData = @{}
	($passport.split(" ").split("`r`n") |?{$_}) | % {
		$passPortData.Add($_.split(":")[0],$_.split(":")[1])
	}
	
	if ($validPassports -contains (($passportData.keys | Sort-Object) -join ",")) {
		$valid++
	}
}