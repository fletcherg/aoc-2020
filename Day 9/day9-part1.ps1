
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

$data[$i]
