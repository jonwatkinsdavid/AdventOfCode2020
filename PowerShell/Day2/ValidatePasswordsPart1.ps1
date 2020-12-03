<#
    .SYNOPSIS
        Given a list of passwords and a validation rule, how many passwords are valid
    .DESCRIPTION
        An entry takes the form: <x>-<y> <r>: <string>

        Where x is the minimum number of occurences of the character <r> in <string>
        Where y is the maximum number of occurences of the character <r> in <string>
        Where <r> is a single character
        Where <string> is a list of characters representing the password
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
        MinValue = [int]$data[0].Split('-')[0];
        MaxValue = [int]$data[0].Split('-')[1];
        Character = $data[1][0];
        Password = $data[2];
    }
}

function ValidatePassword {
    param (
        [PSCustomObject] $PasswordEntry
    )
    
    $truncatedPassword = $PasswordEntry.Password.ToCharArray() | Where-Object { $_ -eq $PasswordEntry.Character }

    return ($truncatedPassword.Length -ge $PasswordEntry.MinValue) -and ($truncatedPassword.Length -le $PasswordEntry.MaxValue)
}

$passwordList = Get-Content $DataFile

$validPasswordList = $passwordList | ForEach-Object { ParsePasswordEntry -Entry $_ } | Where-Object { (ValidatePassword -PasswordEntry $_ ) }

Write-Host "Found $($validPasswordList.Count) valid passwords"