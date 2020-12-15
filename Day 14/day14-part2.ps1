

$code = Get-Content Day14-input.txt
#$mask = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX".ToCharArray()
$bMask = "000000000000000000000000000000000000"
$mem = @{};

function permuteR {
	param(
		[Parameter()]
		[String]$s
	)
	$ret = @()
	$reg = [regex]"X"
	
	$c = ($s.ToChararray() | ?{$_ -eq "X"} | measure-object).Count
	(1..[Math]::Pow(2,$c)) | % { $ret += $s }
	
	foreach ($col in (1..($c))) {
		$p = [Math]::Pow(2,($c - $col) + 1)
		for ($j = 0; $j -lt [Math]::Pow(2,($c)); $j++) {
			 if (($j % $p) -lt ($p / 2)) {
				$ret[$j] = $reg.replace($ret[$j], "1", 1)
			 } else {
				$ret[$j] = $reg.replace($ret[$j], "0", 1)
			}
		}
	}
	return $ret
}

foreach ($line in $code) {
	if ($line -like "mask*") {
		$mask = ($line.split("=")[1].trim()).ToCharArray()
	} elseif ($line -like "mem*") {
		$location = $line.split("=")[0].trim().split("[")[1].split("]")[0]
		$value = $line.split("=")[1].trim()
		
		$bLocation = ([Convert]::ToString($location,2))
		$bLocation = ($bMask.Substring($bLocation.length) + $bLocation).ToCharArray()
		
		$r = ""
		for ( $i = 0; $i -lt $bLocation.length; $i++) {
		
			if ($mask[$i] -eq "0") {
				$r += $bLocation[$i]
			} elseif ($mask[$i] -eq "1") {
				$r += $mask[$i]
			} else {
				$r += "X"
			}
		}
		
		foreach ($memAddress in (PermuteR $r | %{ [Convert]::ToInt64($_, 2) })) {
			#write-host "Updating $($memAddress) with $($value)"
			if ($mem.$memAddress -eq $null) {
				$mem.add($memAddress, $value)
			} else {
				$mem.$memAddress = $value
			}
		}	
	}
}


($mem.Values | measure-object -sum).Sum
