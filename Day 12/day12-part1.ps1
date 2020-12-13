

$instructions = Get-Content day12-input.txt

$direction = "E"

$north = 0
$east = 0

function Change-Direction {
	param(
		[Parameter()]
		[int]$amount,
		[string]$turn
	)
	
	switch ($direction) {
		"N" { $current = 0 }
		"E" { $current = 90 }
		"S" { $current = 180 } 
		"W" { $current = 270 }
	}
	
	switch ($turn) {
		"L" { $current -= $amount }
		"R" { $current += $amount }
	}
	
	if ($current -lt 0) {
		$currnet = ($current * -1) % 360
	
	}
	
	switch ((($current % 360) + 360)%360) {
		0 { $direction = "N" }
		90 { $direction = "E" } 
		180 { $direction = "S" }
		270 { $direction = "W"}
	}
	$direction
}

foreach ($instruction in $instructions) {

	$move = $instruction.Substring(0,1)
	$amount = $instruction.Substring(1)

	Write-Host "Moving $($move) for $($amount)"

	if ($move -eq "F") { $move = $direction }
	
	switch ($move) {
	
	"N" { $north += $amount }
	"S" { $north -= $amount}
	"E" { $east += $amount }
	"W" { $east -= $amount }
	"L" { $direction = Change-Direction -amount $amount -turn $move }
	"R" { $direction = Change-Direction -amount $amount -turn $move }
	}

}

Write-Host "Final position is North: $($north), East: $($east). Manhattan Distance: $([Math]::Abs($north) + [Math]::Abs($east))"



