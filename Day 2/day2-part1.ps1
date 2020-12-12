

$passwords = Get-Content day2input.txt
$invalid=0
$valid=0
foreach ($password in $passwords) {
	$example = $password.split(":")[1].trim()
	$char = $password.split(":")[0].split(" ")[1]
	$minFind = $password.split(":")[0].split(" ")[0].split("-")[0]
	$maxFind = $password.split(":")[0].split(" ")[0].split("-")[1]
	$count = ($example.ToCharArray() | ?{ $_ -eq $char } | measure-object).Count
	if (($count -gt $maxFind) -OR ($count -lt $minFind)) {
		$invalid++
	} else {
		$valid++
	}
}


