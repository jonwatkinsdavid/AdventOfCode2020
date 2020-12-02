<#
    .SYNOPSIS
        Given a list of integers where only 2 add up to 2020, find those 2 values and then multiply them together.
    .DESCRIPTION
        I asked myself the question: "Can this be done in a single line of PowerShell?".
        This was my answer.

        The use of Invoke-Expression at the end is a little bit cheeky, but it does the job!
#>
param(
    [Parameter(Mandatory=$true)]
    [string] $DataFile
)

(Compare-Object -ReferenceObject (Get-Content $DataFile | ForEach-Object { 2020 - $_ }) -DifferenceObject (Get-Content $DataFile) -ExcludeDifferent -IncludeEqual -PassThru) -join "*" | Invoke-Expression