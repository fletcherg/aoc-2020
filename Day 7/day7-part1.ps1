
$content = Get-Content .\input.txt

$bags = @{}
$bagNames = @()
foreach ($c in $content) {
	$c = $c -csplit " contain "	
	$bags.Add(($c[0].split(" ")[0..1] -join " "),(($c[1].split(",").trim() | %{ $_.split(" ")[1..2] -join " " }) -join ","))
	$bagNames += ($c[0].split(" ")[0..1] -join " ")
}

do {
	Write-Host "iterate"
	$change = $false
	foreach ($key in $bagNames) {
		$bags.$key.split(",") | %{
			if ("other bags.","shiny gold" -notcontains $_ ) {
				$bags.$key = $bags.$key.replace($_, $bags.$($_)); $change = $true
			}
		}
	}
} while ($change)

$ShinyGold = 0
foreach ($key in $bagNames) { if ($bags.$key -like "*shiny gold*") { $shinyGold++ } }
$shinyGold

