$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$designer = Get-Content -Raw (Join-Path $root 'Optimizer/Forms/MainForm.Designer.cs')
$form = Get-Content -Raw (Join-Path $root 'Optimizer/Forms/MainForm.cs')
$controls = [regex]::Matches($designer, 'this\.(?:universalTab|windows10Tab|panelWin11Tweaks)\.Controls\.Add\(this\.(\w+Sw)\)') | ForEach-Object { $_.Groups[1].Value }
if (($controls | Sort-Object -Unique).Count -ne 65 -or $controls.Count -ne 65) { throw "Unexpected inventory: $($controls.Count)" }
$source = Get-Content -Raw (Join-Path $root 'Optimizer/ToggleCompatibility.cs')
$bridge = 'public static class TestAccess { public static string Reason(int build, string control) { return Optimizer.ToggleCompatibility.GetBlockReason(build, control); } }'
Add-Type -TypeDefinition ($source + [Environment]::NewLine + $bridge)
foreach ($control in $controls) {
    if ([regex]::Matches($form, "BindOptimizationToggle\($control, \w+\);").Count -ne 1 -or ($form + $designer) -match "\b$control\.ToggleClicked\s*\+=") {
        throw "Expected one guarded registration for $control"
    }
    foreach ($build in @(0, 26200, 26300, 28000)) {
        if (-not [TestAccess]::Reason($build, $control)) { throw "Expected $control blocked on $build" }
    }
    if ([TestAccess]::Reason(26100, $control)) { throw "Expected legacy behavior for $control" }
}
Write-Host "Verified $($controls.Count) controls without executing any adjustment."
