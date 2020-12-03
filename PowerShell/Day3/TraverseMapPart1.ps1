param(
    [Parameter(Mandatory=$true)]
    [string] $DataFile
)

$map = Get-Content -Path $DataFile
.\GetNumberOfTreeEncounters.ps1 -Map $map -HorizontalMoveSize 3 -VerticalMoveSize 1