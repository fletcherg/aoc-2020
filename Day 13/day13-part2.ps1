

$notes = Get-Content Day13-input.txt

$buses = $notes[1].split(",")
$busWaits = @()
for ($i = 0; $i -lt $buses.length; $i++) {
	if ($buses[$i] -ne "x") {
		$busWaits += [PSCustomObject]@{
			"Bus" = [int]$buses[$i]
			"NeedWait" = [int]$i
			"pdiv" = [int64]$NULL
			"inverse" = [int64]$NULL
			}
		}
}

# extended euclidean algorithm
function Get-Inverse {
	param(
		[Parameter()]
		[int64]$num,
		[int64]$mod
	)

	if ($num -lt 0) { $num = -$num }
	if ($mod -lt 0) { $num = $mod - ((-$num) % $mod) }
	
	$t = 0
	$newt = 1
	$r = $mod
	$newr = $num % $mod
	while ($newr -ne 0) {
		$q = [Math]::truncate($r/$newr)
		$tmp = $newt
		$newt = $t - $q*$newt
		$t = $tmp
		$tmp = $newr
		$newr = $r - $q*$newr
		$r = $tmp
	}
	if ($r -gt 1) {return -1}
	if ($t -lt 0) {$t += $mod}
	return $t
}

[bigint]$M = 1; $buswaits.bus | % { $M *= $_ }
[bigint]$x = 0
foreach ($busWait in $busWaits) {
	$busWait.pdiv = $M / $BusWait.Bus
	$busWait.inverse = Get-Inverse -num $busWait.pdiv -mod $busWait.Bus
	$x -= $busWait.Needwait * $busWait.pdiv * $busWait.inverse
}

$x *= -1
$timestamp = $M - $x % $M

$timestamp