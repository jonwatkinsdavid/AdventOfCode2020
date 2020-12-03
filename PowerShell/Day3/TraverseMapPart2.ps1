param(
    [Parameter(Mandatory=$true)]
    [string] $DataFile
)

$map = Get-Content -Path $DataFile

$routes = @(
    @{ MoveRight = 1; MoveDown = 1 },
    @{ MoveRight = 3; MoveDown = 1 },
    @{ MoveRight = 5; MoveDown = 1 },
    @{ MoveRight = 7; MoveDown = 1 },
    @{ MoveRight = 1; MoveDown = 2 }
)

$results = $routes | ForEach-Object { .\GetNumberOfTreeEncounters -Map $map -HorizontalMoveSize $_.MoveRight -VerticalMoveSize $_.MoveDown }
$results -join "*" | Invoke-Expression
