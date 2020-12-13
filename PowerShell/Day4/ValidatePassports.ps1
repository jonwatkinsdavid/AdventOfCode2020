param(
    [Parameter(Mandatory=$true)]
    [string] $DataFile
)

function ExtractFields {
    param (
        [string] $PassportEntry
    )

    $formattedEntry = $PassportEntry.Replace("`r`n", ' ').Replace("`n", '').Trim()

    $result = $formattedEntry -split ' ' | ForEach-Object { ($_ -split ':')[0] } | Where-Object { $_ -ne 'cid' }

    return $result
}

function NumberOfMissingFields {
    param (
        [string[]] $ValidFieldNames,
        [string[]] $PassportEntry
    )
    
    $passportFields = ExtractFields -PassportEntry $PassportEntry | Sort-Object

    $missingFields = Compare-Object -ReferenceObject $ValidFieldNames -DifferenceObject $passportFields -PassThru

    return $missingFields.Count
}

$validPassportFields = @('byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid') | Sort-Object
$passportData = (Get-Content -Path $DataFile -Raw | Out-String) -split "`r`n`r`n"

Write-Host "Total Number of Passports: $($passportData.Count)"

$validPassports = $passportData | Foreach-Object { NumberOfMissingFields -PassportEntry $_ -ValidFieldNames $validPassportFields }
$validPassportCount = ($validPassports | Where-Object { $_ -eq 0 }).Count

Write-Host "Valid Passports: $validPassportCount"