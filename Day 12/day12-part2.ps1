

$instructions = Get-Content day12-input.txt

$north = 0
$east = 0

$global:northWay = 1
$global:eastWay = 10

function Change-WayDirection {
	param(
		[Parameter()]
		[int]$amount,
		[string]$turn
	)

	switch ($turn) {
		"L" {
			for ($i = 1; $i -le ($amount / 90); $i++) {
				$t = $northWay
				$global:northWay = $eastWay
				$global:eastWay = -$t
			}
		} "R" {
			for ($i = 1; $i -le ($amount / 90); $i++) {
				$t = $eastway
				$global:eastway = $northWay
				$global:northway = -$t
			}
		}
	}

		$northway
		$eastway
}

# lol!
foreach ($instruction in $instructions) {

	$move = $instruction.Substring(0,1)
	$amount = $instruction.Substring(1)

	Write-Host "Moving $($move) for $($amount)..."
	
	switch ($move) {
		"N" { $northWay += $amount }
		"S" { $northWay -= $amount}
		"E" { $eastWay += $amount }
		"W" { $eastWay -= $amount }
		"L" { Change-WayDirection -amount $amount -turn $move }
		"R" { Change-WayDirection -amount $amount -turn $move }
		"F" {
			$north += $northWay * $amount
			$east += $eastWay * $amount
		}
	}
	
	Write-Host "`t...position is North: $($north), East: $($east)."
	Write-Host "`t...way position is North: $($northway), East: $($eastway)."

}

Write-Host "Final position is North: $($north), East: $($east). Manhattan Distance: $([Math]::Abs($north) + [Math]::Abs($east))"



