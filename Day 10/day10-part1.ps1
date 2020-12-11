
$puzzleinput = @(); Get-Content input.txt | % { $puzzleInput += [int]$_ }
$differences = @()

$currentJoltage = 0
$puzzleinput += ($puzzleinput |measure -Maximum).maximum + 3

$valid = $true; while ($valid) {
Write-host "Current joltage: $($currentJoltage)"
	$available = $puzzleinput | ? {$_ -gt $currentJoltage -AND ( ($_ - $currentJoltage) -le 3 ) }
	if ($available) {
		$select = ($available |measure -Minimum).minimum
		Write-Host "picking $($select)"
		$differences += $select - $currentJoltage
		$currentJoltage = $select
	} else {
		$valid = $false
	}
}

$differences | Group-Object
