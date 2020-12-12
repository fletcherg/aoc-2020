

$passwords = Get-Content day2input.txt
$invalidPass=0
$validPass=0
foreach ($password in $passwords) {
	$example = $password.split(":")[1].trim()
	$char = $password.split(":")[0].split(" ")[1]
	$firstPosition = $password.split(":")[0].split(" ")[0].split("-")[0] - 1
	$secondPosition = $password.split(":")[0].split(" ")[0].split("-")[1] - 1
	
	$valid = $false
	if ($example.ToCharArray()[$firstPosition] -eq $char) { $valid = $true}
	if ($example.ToCharArray()[$secondPosition] -eq $char) { if ($valid) { $valid = $false } else { $valid = $true } }
	
	if ($valid) { $validPass++ } else { $invalidPass++ } 

}