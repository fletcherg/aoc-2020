

$puzzleInput = Get-Content day8input.txt
$code = @()
foreach ($instr in $puzzleInput) {
	$code += [PSCustomObject]@{
		Code = $instr.split(" ")[0]
		TryCode = [int]-1
		Value = [int]($instr.split(" ")[1])
		Run = $false
	}
}

$found = $false

for ($i = 0; $i -lt $code.length; $i++) {

	$code | %{ $_.Run = $false }

	if ($found) {
		break
	}

	$accumulator = 0
	$running = $true
	$ptr = 0
	$code[$i].TryCode = $i

	while ($running) {
		if($code[$ptr].Run) {
			$running = $false # loop
		} elseif(($ptr -gt $code.length) -OR ($ptr -lt 0)) {
			$running = $false # out of bounds
		} elseif($ptr -eq ($code.length)) {
			$running = $false
			$found = $true
		} else {
			$code[$ptr].Run = $true
			Switch ( $code[$ptr].code ) {
				"nop" { if ($code[$ptr].TryCode -eq $i) { $ptr += $code[$ptr].Value } else { $ptr++ } }
				"acc" { $accumulator += $code[$ptr].Value; $ptr++ }
				"jmp" { if ($code[$ptr].TryCode -eq $i) { $ptr++ } else { $ptr += $code[$ptr].Value } }
			}
		}
	}
	
}

$accumulator
