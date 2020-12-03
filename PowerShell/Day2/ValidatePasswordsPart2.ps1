<#
    .SYNOPSIS
        Given a list of passwords and a validation rule, how many passwords are valid
    .DESCRIPTION
        An entry takes the form: <x>-<y> <r>: <string>

        Where x is the expected position of the character <r> in <string>
        Where y is the expected position of the character <r> in <string>
        Where <r> is a single character
        Where <string> is a list of characters representing the password

        Note: A password is invalid if <r> is found in positions <x> and <y>
#>
param(
    [Parameter(Mandatory=$true)]
    [string] $DataFile
)

function ParsePasswordEntry {
    param (
        [string] $Entry
    )

    $data = $Entry.Split(' ');

    return New-Object PSCustomObject @{
        FirstPosition = [int]$data[0].Split('-')[0];
        SecondPosition = [int]$data[0].Split('-')[1];
        Character = $data[1][0];
        Password = $data[2];
    }
}

function ValidatePassword {
    param (
        [PSCustomObject] $PasswordEntry
    )
    
    $passwordCharacters = $PasswordEntry.Password.ToCharArray()
    $validPassword = $false
    $validFirstPosition = $false
    $validSecondPosition = $false
    
    if($passwordCharacters[$PasswordEntry.FirstPosition - 1] -eq $PasswordEntry.Character) {
        $validFirstPosition = $true
    }

    if($passwordCharacters[$PasswordEntry.SecondPosition - 1] -eq $PasswordEntry.Character) {
        $validSecondPosition = $true
    }

    if($validFirstPosition -and $validSecondPosition) {
        return $false
    }

    return $validFirstPosition -or $validSecondPosition
}

$passwordList = Get-Content $DataFile

$validPasswordList = $passwordList | ForEach-Object { ParsePasswordEntry -Entry $_ } | Where-Object { (ValidatePassword -PasswordEntry $_ ) }

Write-Host "Found $($validPasswordList.Count) valid passwords"