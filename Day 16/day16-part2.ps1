
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
			$er += 1
		}
	}
	if ($er -eq 0) {
		return $true
	} else { return $false }
} 

$validTickets = @()
$errorTotal = 0
$l = $content.IndexOf("nearby tickets:") + 1

while ($l -lt $content.length) {
	
	if( Check-Ticket $content[$l].split(",") ) {
		$validTickets += $content[$l]
	}
	$l++
}

$l = $content.IndexOf("your ticket:") + 1
$myTicket = ([int[]]($content[$l].split(",")))
$validTickets += $content[$l]

## Initialise
$validRules = [object[]]::new( $validTickets[0].split(",").length )
for ($i = 0; $i -lt $validTickets[0].split(",").length; $i++) { $validRules[$i] = [System.Collections.ArrayList]::new() }

$ruleHead = $content |  ? {$_ -like "*or*"} | % { $_.split(":")[0].trim() }

$col = $validTickets[0].split(",").length
$fields = [object[]]::new( $col )
for ($i = 0; $i -lt $col; $i++) { $fields[$i] = [System.Collections.ArrayList]::new()
	$rulehead | % { [void]$fields[$i].Add( $_ ) }
}

for ($i = 0; $i -lt $rule.length; $i++) {
	$r = $rule[$i] -csplit " or "
	
	for ($c = 0; $c -lt $col; $c++) {
		$res = $validTickets | ? { 	((([int]($_.Split(",")[$c]) -lt [int]($r[0].split("-")[0])) -OR `
									([int]($_.Split(",")[$c]) -gt [int]($r[0].split("-")[1]))) -AND `
				(([int]($_.Split(",")[$c]) -lt [int]($r[1].split("-")[0])) -OR `
					([int]($_.Split(",")[$c]) -gt [int]($r[1].split("-")[1])))) }
					
		if ($res) {
			if($c -eq 9) { 
			$res }
			$fields[$c].remove("$($rulehead[$i])")
		}
	}
}

### calculate fields
do {
	for ($c = 0; $c -lt $col; $c++) {
		if ($fields[$c].count -eq 1) {
			for ($d = 0; $d -lt $col; $d++) {
				if ($c -ne $d) {
					$fields[$d].Remove("$($fields[$c])")
				}
			}
		}
	}
	$totalFields = ($fields | % { $_ }  | Measure-Object).Count
} while ($totalFields -gt $col)
$fieldMap = @{}; for ($c = 0; $c -lt $col; $c++) { $fieldMap.Add([string]$fields[$c], $c) }

$departureFields = 1
for ($c = 0; $c -lt $col; $c++) {
	if( $ruleHead[$c] -like "departure*") {
		$departureFields = $departureFields * $myticket[$fieldmap.$($rulehead[$c])]

	}

}

$departureFields
