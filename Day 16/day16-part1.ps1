
$content = Get-Content .\day16.txt
$rule = $content |  ? {$_ -like "*or*"} | % { $_.split(":")[1].trim() }

function Check-Ticket {
	param(
		[Parameter()]
		[int[]]$toCheck
	)
	$er = 0
	for ($n = 0; $n -lt $toCheck.length; $n++) {
		$match = $false
		for ($i = 0; $i -lt $rule.length; $i++) {
			$r = $rule[$i] -csplit " or "
			if((([int]$toCheck[$n] -ge [int]$r[0].split("-")[0]) -AND ([int]$toCheck[$n] -le [int]$r[0].split("-")[1])) -OR `
						(([int]$toCheck[$n] -ge [int]$r[1].split("-")[0]) -AND ([int]$toCheck[$n] -le [int]$r[1].split("-")[1]))) {
				$match = $true
			}
		}
		if (! $match) {
			$er += [int]($toCheck[$n])
		}
	}
	return $er
}

$errorTotal = 0
$l = $content.IndexOf("nearby tickets:") + 1

while ($l -lt $content.length) {
	
	$errorTotal += Check-Ticket $content[$l].split(",")
	$l++
}

$errorTotal
