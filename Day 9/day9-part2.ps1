
$data = Get-Content .\input.txt
$p = 25

function Check-Sum {
	param(
		[Parameter()]
		[int[]]$array,
		[int]$sum
	)
	$found = $false
	for ($j = 0; ($j -lt $array.length) -AND !($found); $j++) {
		for ($k = 0; ($k -lt $array.length) -AND !($found); $k++) {
			if ((([int]$array[$j] + [int]$array[$k]) -eq [int]$sum) -AND ($j -ne $k)) {
				$found = $true
			}
		}
	}
	return $found
}

$i = $p -1
$found = $true
while ($i -lt $data.length -AND ($found)) {
	$i++
	$found = Check-Sum -Array $data[($i - $p)..($i-1)] -Sum $data[$i]

}

$target = $data[$i]

$found = $false
for ($i = 0; (($i -lt $data.length) -and !($found) ); $i++) {
	$i
	$aSum = @()
	$j = 0
	while (($aSum | Measure-Object -sum).Sum -lt [int64]$target) {
		$aSum += [int64]$data[$i + $j]
		$j++
	}
	
	if (($aSum | Measure-Object -sum).Sum -eq [int64]$target) {
		$found = $true
	}
}

$res = ($aSum | measure-object -Maximum -Minimum)
$res.Maximum + $res.Minimum
