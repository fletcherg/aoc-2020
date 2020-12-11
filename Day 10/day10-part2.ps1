
$puzzleinput = @(); Get-Content input3.txt | % { $puzzleInput += [int]$_ }
$puzzleinput += ($puzzleinput |measure -Maximum).maximum + 3
$puzzleinput = $puzzleinput | Sort-Object

# lol
$split = @(0)
for ($i = $puzzleinput.length - 1; $i -gt 0; $i--) {
	if ($puzzleinput[$i - 1] -eq $puzzleinput[$i] - 3) {
		$split += $puzzleinput[$i]
	} 
}

$split = $split | Sort-Object

function Get-AdapterPath{
	param(
		[Parameter()]
		[String]$adapterPath,
		[int]$currentJoltage,
		[int]$targetJoltage
	)
	$adapterPath += "$($currentJoltage), "
	$available = $puzzleinput | ? {$_ -gt $currentJoltage -AND ( ($_ - $currentJoltage) -le 3 ) -AND ($_ -le $targetJoltage) }
	if ($available) {
		foreach ($selection in $available) {
			Get-AdapterPath -adapterPath $adapterPath -currentJoltage $selection -targetJoltage $targetJoltage
		}
	} elseif (($targetJoltage - $currentJoltage) -le 3) {
		"$($adapterpath)($($targetJoltage))"
	} else {
		Write-Host "found a Dead end at $($adapterPath)"
	}
}

$pathcount = @()
for ($i = 0; $i -lt $split.length - 1; $i++) {
	$paths = Get-AdapterPath -currentJoltage $split[$i] -targetJoltage $split[$i + 1]
	$pathcount += ($paths | Measure-Object).count
}

$answer = $pathcount[0]
for ($i = 1; $i -lt $pathcount.length; $i++) {
	$answer *= $pathcount[$i]
}

$answer
