

$notes = Get-Content Day13-input.txt

$min = $notes[0]
$buses = $notes[1].split(",") | ?{$_ -ne "x"}

$wait = @()
foreach ($bus in $buses) {
$wait += [PSCustomObject]@{
	"Bus" = [int]$bus
	"Wait" = ((2 * [int]$bus) * [int]$min) % [int]$min
}
}

$wait = 0
$continue = $true
do {
	foreach ($bus in $buses) {
		if ((([int]$min + [int]$wait) % [int]$bus) -eq 0) {
			Write-Host "Bus: $($bus), Wait: $($wait)"
			$continue = $false
		}
	}
	$wait++
	
} while ($continue)

$bus * $wait