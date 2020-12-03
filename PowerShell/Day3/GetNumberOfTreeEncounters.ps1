<#
    .SYNOPSIS
        Given a 2 dimensional matrix (the map) where each element can contain either a '.' or a '#' (a tree).
        A person traversing the map that always moves a fixed number of spaces horizontally to the right and
        vertically down, calculate the number of 'trees' encountered en-route.

        The 'map' pattern repeats horizontally as required to maintain a course.
    .DESCRIPTION
        
#>
param(
    [Object[]] $Map,
    [int] $HorizontalMoveSize,
    [int] $VerticalMoveSize
)

# Get the map dimensions (assuming a rectangle)
$mapVerticalSize = $Map.Length
$mapHorizontalSize = $Map[0].Length

Write-Host "Map dimansions: $mapHorizontalSize X $mapVerticalSize"

# Calculate the number of times that the 'map' needs to repeat horizontally
$totalHorizontalMoves = ($mapVerticalSize / $verticalMoveSize) * $HorizontalMoveSize
$mapRepeats = [Math]::Ceiling($totalHorizontalMoves / $mapHorizontalSize)
Write-Host "Number of horizontal repetitions: $mapRepeats"

# Build a the entire map
$replicatedMap = $Map | ForEach-Object { ($_ * $mapRepeats) }

# Traverse the 'map'
$horizontalPosition = 0
$results = @()

for($i = 0; $i -lt $mapVerticalSize; $i += $verticalMoveSize) {
    $results += $replicatedMap[$i][$horizontalPosition]
    $horizontalPosition += $horizontalMoveSize
}

($results | Where-Object { $_ -eq '#' }).Count