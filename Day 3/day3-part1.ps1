
$map = Get-Content day3-input.txt

$w = $map[0].length
$d = 1
$y = 0
$trees = 0
for ($i = 0; $i -lt $map.length; $i++) {
	if ($map[$i][$y] -eq "#") { $trees ++ }
	$y = ($y + 3) % $w
}

$trees
