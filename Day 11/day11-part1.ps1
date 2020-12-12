

$puzzleinput = Get-Content day11-input

# this seems a bit lame
$grid = New-Object 'object[,,]' $puzzleinput[0].length,$puzzleinput.length,500

for ($i=0; $i -lt $puzzleinput.length; $i++) {
	for($j=0; $j -lt $puzzleinput[$i].length; $j++) {
		$grid[$j,$i,0] = $puzzleinput[$i][$j]
	}
}

function Get-AdjacentSeats {
	param(
		[Parameter()]
		[int]$x,
		[int]$y,
		[int]$height,
		[int]$width,
		[int]$currentStep
	)
	#write-host $currentStep
	if ($x -eq 0 -AND $y -eq 0) {
		# Top left
		$cur = $grid[0,1,$currentStep] + $grid[1,1,$currentStep] + $grid[1,0,$currentStep]
	} elseif (($x -eq $width - 1) -AND ($y -eq $height - 1)) {
		# bottom right
		$cur = $grid[ ($x - 1), $y, $currentStep] + $grid[ $x, ($y - 1), $currentStep] `
				+ $grid[ ($x - 1), ($y - 1), $currentStep]
	} elseif (($x -eq 0) -AND ($y -eq $height - 1)) {
		# bottom left
		$cur = $grid[ $x, ($y -1), $currentStep] + $grid[ ($x +1), ($y -1), $currentStep] `
				+ $grid[ ($x +1), $y, $currentStep] 
	} elseif (($x -eq $width - 1) -AND ($y -eq 0)) {
		# top right
		$cur = $grid[ ($x - 1), ($y + 1), $currentStep] + $grid[ $x, ($y + 1), $currentStep] `
				+ $grid[ ($x - 1), $y, $currentStep] 
	} elseif ($x -eq 0) {
		# left
		$cur = $grid[$x,($y + 1),$currentStep] + $grid[$x,($y - 1),$currentStep] `
				+ $grid[($x +1),($y + 1),$currentStep] + $grid[($x +1),($y - 1),$currentStep] + $grid[($x +1),$y,$currentStep]
		
	} elseif ($y -eq 0) {
		# top
		$cur = $grid[$x,($y + 1),$currentStep] + $grid[($x -1),($y + 1),$currentStep] `
				+ $grid[($x +1),($y + 1),$currentStep] + $grid[($x -1),$y,$currentStep] + $grid[($x +1),$y,$currentStep]
		
	} elseif ($x -eq $width - 1) {
		# right
		$cur = $grid[$x, ($y + 1), $currentstep] + $grid[$x,($y - 1),$currentStep] `
				+ $grid[($x - 1),($y + 1), $currentstep] + $grid[($x - 1),($y - 1),$currentStep] + $grid[($x -1),$y,$currentStep]
		
	} elseif ($y -eq $height - 1) {
		# bottom
		$cur = $grid[($x - 1),($y - 1),$currentStep] + $grid[($x + 1),($y - 1),$currentStep] `
				+ $grid[$x,($y - 1),$currentStep] + $grid[($x - 1),$y,$currentStep] + $grid[($x + 1),$y,$currentStep]
		
	} else {
		# middle
		$cur = $grid[($x - 1),($y - 1),$currentStep] + $grid[($x + 1),($y - 1),$currentStep] `
				+ $grid[($x - 1),($y + 1),$currentStep] + $grid[($x + 1),($y + 1),$currentStep] `
				+ $grid[($x - 1),$y,$currentStep] + $grid[($x + 1),$y,$currentStep] `
				+ $grid[$x,($y - 1),$currentStep] + $grid[$x,($y + 1),$currentStep]
	}
	$cur.replace(".","").replace("L","").length
}

function Progress-Cell {
	param(
		[Parameter()]
		[int]$x,
		[int]$y,
		[int]$height,
		[int]$width,
		[int]$currentStep
	)
	$change = $false
	$grid[$x,$y,($currentStep +1)] = $grid[$x,$y,$currentStep]
	
	switch ( $grid[$x, $y, $currentStep] )
	{
		"#" {
			$adj = Get-AdjacentSeats -x $x -y $y -currentStep $currentStep -height $height -width $width
				if ($adj -ge 4) {
				$grid[$x, $y, ($currentStep +1)] = "L"
				$change = $true
			}
		} "L" {
			$adj = Get-AdjacentSeats -x $x -y $y -currentStep $currentStep -height $height -width $width
			if ($adj -eq 0) {
				$grid[$x, $y, ($currentStep +1)] = "#"
				$change = $true
			}
		}
	
	}
	
	$change
}

function Progress-Step {
	param(
		[Parameter()]
		[int]$currentStep
	)
	$seatchanges = 0
	for ($i=0; $i -lt $puzzleinput.length; $i++) {
		for($j=0; $j -lt $puzzleinput[$i].length; $j++) {
			$res = Progress-Cell -x $j -y $i -currentStep $currentStep -height $puzzleinput.length -width $puzzleinput[$i].length
			if ($res) { $seatchanges++ }
		}
	}
	Write-Host "Step $($currentStep) completed with $($seatchanges) seat changes"
	return $seatChanges
}

function Print-Grid {
	param(
		[Parameter()]
		[int]$currentStep
	)
	for ($i=0; $i -lt $puzzleinput.length; $i++) {
		for($j=0; $j -lt $puzzleinput[$i].length; $j++) {
			Write-Host "$($grid[$j,$i,$currentStep])" -nonewline
		}
		Write-Host
	}
}



function Count-Seats {
	param(
		[Parameter()]
		[int]$currentStep
	)
	$occupiedSeats = 0
	for ($i=0; $i -le $puzzleinput.length; $i++) {
		for($j=0; $j -le $puzzleinput[$i].length; $j++) {
		if ($grid[$i,$j,$currentStep] -eq "#") { $occupiedSeats++ }
		}
	}
	$occupiedSeats
}

$progress = -1
do {
	$progress++
	$seatChanges = Progress-Step -currentStep $progress
} while ($seatChanges -ne 0)

$occupiedSeats = 0
for ($i=0; $i -le $puzzleinput.length; $i++) {
		for($j=0; $j -le $puzzleinput[$i].length; $j++) {
		if ($grid[$i,$j,$progress] -eq "#") { $occupiedSeats++ }
		}
	}

#$occupiedSeats = $total.replace(".","").replace("L","").length
Write-Host "$($occupiedSeats) Occupied steps after $($progress) interations"




if ($grid[$x, $y, $currentStep] -eq ".") {
		$grid[$x, $y, ($currentStep +1)] = "."
	} else {
		$adj = Get-AdjacentSeats -x $x -y $y -currentStep $currentStep -height $height -width $width
		if ($adj -eq 0) {
			# mark as occupied
			if ($grid[$x, $y, $currentStep] -ne "#") {
				$grid[$x, $y, ($currentStep +1)] = "#"
				$change = $true
			}
		} elseif ( ($grid[$x, $y, $currentStep] -eq "#") -AND ($adj -ge 4) ) {
			#mark as empty
			$grid[$x,$y,($currentStep +1)] = "L"
			$change = $true
		}
	}