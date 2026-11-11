# Read-only source audit for MR. KIMBO Optimizer v17.
# This script searches C# source text only; it does not read/modify Windows settings.
[CmdletBinding()]
param(
    [string]$SourcePath = (Join-Path $PSScriptRoot '..\Optimizer')
)

$ErrorActionPreference = 'Stop'
$root = (Resolve-Path -LiteralPath $SourcePath).Path
$sourceFiles = @(Get-ChildItem -LiteralPath $root -Filter '*.cs' -File -Recurse)
if ($sourceFiles.Count -eq 0) {
    throw "No C# source files found at $root"
}

$checks = [ordered]@{
    'Defender modification hooks' = 'DisableDefender|disabledefender'
    'Windows Update disable hooks' = 'DisableAutomaticUpdates|StopWindowsUpdate'
    'System Restore disable hooks' = 'DisableSystemRestore'
    'SmartScreen disable hooks' = 'DisableSmartScreen'
    'HPET manipulation hooks' = 'DisableHPET|EnableHPET'
    'Boot configuration commands' = 'bcdedit'
    'Direct registry writes' = 'Registry\.SetValue|SetValue\('
    'Service modification hooks' = 'StopService\(|StartService\(|sc config'
}

$rows = New-Object System.Collections.Generic.List[object]
foreach ($label in $checks.Keys) {
    $matches = @($sourceFiles | Select-String -Pattern $checks[$label])
    $rows.Add([pscustomobject]@{
        Category = $label
        Matches = $matches.Count
        Files = (@($matches | ForEach-Object { $_.Path } | Sort-Object -Unique)).Count
    })
}

Write-Host 'Legacy source audit (read-only, not a security certification)'
$rows | Format-Table -AutoSize | Out-String | Write-Host

if ($env:GITHUB_STEP_SUMMARY) {
    @(
        '## MR. KIMBO Optimizer v17 — legacy code inventory'
        ''
        '> Read-only source scan. A match is a review target, not proof of a vulnerability.'
        ''
        '| Category | Source matches | Files |'
        '| --- | ---: | ---: |'
    ) | Out-File -FilePath $env:GITHUB_STEP_SUMMARY -Append -Encoding utf8

    foreach ($row in $rows) {
        "| $($row.Category) | $($row.Matches) | $($row.Files) |" |
            Out-File -FilePath $env:GITHUB_STEP_SUMMARY -Append -Encoding utf8
    }
}
