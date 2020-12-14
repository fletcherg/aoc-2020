

$code = Get-Content Day14-input.txt
$mask = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX".ToCharArray()
$bMask = "000000000000000000000000000000000000"
$mem = @{};

### fuck i can't figure out how to do 36bit shit in powershell. this is hacky don't look at this pls ;<
foreach ($line in $code) {
	if ($line -like "mask*") {
		$mask = ($line.split("=")[1].trim()).ToCharArray()
	} elseif ($line -like "mem*") {
		$location = $line.split("=")[0].trim().split("[")[1].split("]")[0]
		$value = $line.split("=")[1].trim()
		#$value = [Convert]::ToString( $line.split("=")[1].trim(), 2)
		
		
		$bValue = ([Convert]::ToString($value,2))
		$bValue = ($bMask.Substring($bValue.length) + $bValue).ToCharArray()

		$r = ""
		for ( $i = 0; $i -lt $bValue.length; $i++) {
			if ($mask[$i] -eq "X") { $r += $bValue[$i]
			} else { $r += $mask[$i] }
		}
		$value = [Convert]::ToInt64($r,2)
		$value
		write-host "Updating $($location) with $($value)"
		if ($mem.$location -eq $null) {
			$mem.add($location, $value)
		} else {
			$mem.$location = $value
		}
	}
}


($mem.Values | measure-object -sum).Sum