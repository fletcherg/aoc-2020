


$puzzleInput = Get-Content day8input.txt
$code = @()
foreach ($instr in $puzzleInput) {
	$code += [PSCustomObject]@{
		Code = $instr.split(" ")[0]
		Value = [int]($instr.split(" ")[1])
		Run = $false
	}
}

$accumulator = 0
$noLoop = $true
$ptr = 0

while ($noLoop) {

	if($code[$ptr].Run) {
		$noLoop = $false
	} else {
		$code[$ptr].Run = $true
		Switch ($code[$ptr].code) {
			"nop" { $ptr++ }
			"acc" { $accumulator += $code[$ptr].Value; $ptr++ }
			"jmp" { $ptr += $code[$ptr].Value }
		}
	}
}

$accumulator