
$map = Get-Content day3-input.txt

$pairs = (1,1), (1,3), (1,5), (1,7),(2,1)

$w = $map[0].length

$totalTrees = 1

foreach ($p in $pairs) {
	$y = 0
	$trees = 0
	$i = 0
	while ($i -lt $map.length) {
		if ($map[$i][$y] -eq "#") { $trees++ }
		$i += $p[0]
		$y = ($y + $p[1]) % $w
	}
	$totalTrees *= $trees
}

$totalTrees
