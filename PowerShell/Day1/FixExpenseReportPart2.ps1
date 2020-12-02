<#
    .SYNOPSIS
        Given a list of integers where only 3 add up to 2020, find those 3 values and then multiply them together.
    .DESCRIPTION
        The least efficient method of solving the problem by calculating all available combinations in
        order to calculate the sum of each to find the correct combination.
#>
param(
    [Parameter(Mandatory=$true)]
    [string] $DataFile
)

function CalculatePermutations(
    [int[]] $List
)
{
    $permutations = New-Object System.Collections.ArrayList

    for($i=0;$i -le $List.Count-3;$i++) {
        
        for($j = $i + 1;$j -le $List.Count-2;$j+=1) {
            
            for($k=$j+1;$k -le $List.Count-1;$k+=1) {

                $value = New-Object int[] 3
                $value[0] = $List[$i]
                $value[1] = $List[$j]
                $value[2] = $List[$k]
                
                $permutations.Add($value) | Out-Null
            }
        }
    }

    return $permutations
}

$inputData = Get-Content $DataFile | ForEach-Object { [System.Int32]$_ }

$start = [System.DateTime]::UtcNow
$allPermutations = CalculatePermutations -List $inputData
$end = [System.DateTime]::UtcNow

$elapsed = $end - $start
Write-Host "Calculating Permutations took: $($elapsed.Minutes) minutes $($elapsed.Seconds) seconds"

$resultValues = $allPermutations | Where-Object { ($_ | Measure-Object -Sum).Sum -eq 2020 }
$result = $resultValues -join "*" | Invoke-Expression

Write-Host ($resultValues -join ",")
Write-Host "Result: $result"