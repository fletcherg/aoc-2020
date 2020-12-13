
Function Get-SeatId {
	param(
		[Parameter()]
		[string]$pass
	)
	$row = 0
	$i = 6
	$pass.Substring(0,7).toCharArray() | % {
		if ($_ -eq "B") { $row += [Math]::Pow(2,$i) }
		$i--
	}

	$col = 0
	$i=2
	$pass.Substring(7).toCharArray() | % {
		if ($_ -eq "R") { $col += [Math]::Pow(2,$i) }
		$i--
	}
	
	return $row * 8 + $col
}

$SeatIDs = @()
Get-Content day5.txt | % {
	$SeatIDs += Get-SeatId $_
}

($SeatIDs | measure-object -Maximum).Maximum