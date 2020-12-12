


$responses = (Get-Content day6input.txt | Out-String) -Split "$([System.Environment]::NewLine)$([System.Environment]::NewLine)"

$sum = 0
foreach ($response in $responses) {
	$sum += (($response.split() | ?{$_}).ToCharArray() | Sort-Object | Get-Unique | Measure-Object).Count
}
$sum