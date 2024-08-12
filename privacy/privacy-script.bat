@echo off
:: https://privacy.sexy — v0.13.5 — Mon, 12 Aug 2024 00:20:42 GMT
:: Ensure admin privileges
fltmc >nul 2>&1 || (
    echo Administrator privileges are required.
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        echo Right-click on the script and select "Run as administrator".
        pause & exit 1
    )
    exit 0
)
:: Initialize environment
setlocal EnableExtensions DisableDelayedExpansion


:: ----------------------------------------------------------
:: ----------Clear Windows update and SFC scan logs----------
:: ----------------------------------------------------------
echo --- Clear Windows update and SFC scan logs
:: Clear directory contents  : "%SYSTEMROOT%\Temp\CBS"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""$($directoryGlob = '%SYSTEMROOT%\Temp\CBS'; if ($directoryGlob.EndsWith('\*')) { $directoryGlob } elseif ($directoryGlob.EndsWith('\')) { "^""$($directoryGlob)*"^"" } else { "^""$($directoryGlob)\*"^"" } )"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $deletedCount = 0; $failedCount = 0; $foundAbsolutePaths = @(); Write-Host 'Iterating files and directories recursively.'; try {; $foundAbsolutePaths += @(; Get-ChildItem -Path $expandedPath -Force -Recurse -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (-not (Test-Path $path)) { <# Re-check existence as prior deletions might remove subsequent items (e.g., subdirectories). #>; Write-Host "^""Successfully deleted: $($path) (already deleted)."^""; $deletedCount++; continue; }; try {; Remove-Item -Path $path -Force -Recurse -ErrorAction Stop; $deletedCount++; Write-Host "^""Successfully deleted: $($path)"^""; } catch {; $failedCount++; Write-Warning "^""Unable to delete $($path): $_"^""; }; }; Write-Host "^""Successfully deleted $($deletedCount) items."^""; if ($failedCount -gt 0) {; Write-Warning "^""Failed to delete $($failedCount) items."^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ---------Clear Windows Update Medic Service logs----------
:: ----------------------------------------------------------
echo --- Clear Windows Update Medic Service logs
:: Clear directory contents  : "%SYSTEMROOT%\Logs\waasmedic"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""$($directoryGlob = '%SYSTEMROOT%\Logs\waasmedic'; if ($directoryGlob.EndsWith('\*')) { $directoryGlob } elseif ($directoryGlob.EndsWith('\')) { "^""$($directoryGlob)*"^"" } else { "^""$($directoryGlob)\*"^"" } )"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $deletedCount = 0; $failedCount = 0; $foundAbsolutePaths = @(); Write-Host 'Iterating files and directories recursively.'; try {; $foundAbsolutePaths += @(; Get-ChildItem -Path $expandedPath -Force -Recurse -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (-not (Test-Path $path)) { <# Re-check existence as prior deletions might remove subsequent items (e.g., subdirectories). #>; Write-Host "^""Successfully deleted: $($path) (already deleted)."^""; $deletedCount++; continue; }; try {; Remove-Item -Path $path -Force -Recurse -ErrorAction Stop; $deletedCount++; Write-Host "^""Successfully deleted: $($path)"^""; } catch {; $failedCount++; Write-Warning "^""Unable to delete $($path): $_"^""; }; }; Write-Host "^""Successfully deleted $($deletedCount) items."^""; if ($failedCount -gt 0) {; Write-Warning "^""Failed to delete $($failedCount) items."^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----Clear "Cryptographic Services" diagnostic traces-----
:: ----------------------------------------------------------
echo --- Clear "Cryptographic Services" diagnostic traces
:: Delete files matching pattern: "%SYSTEMROOT%\System32\catroot2\dberr.txt"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""%SYSTEMROOT%\System32\catroot2\dberr.txt"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $deletedCount = 0; $failedCount = 0; $skippedCount = 0; $foundAbsolutePaths = @(); try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (Test-Path -Path $path -PathType Container) {; Write-Host "^""Skipping, the path is not a file but a folder: $($path)."^""; $skippedCount++; continue; }; if (-not (Test-Path $path)) { <# Re-check existence as prior deletions might remove subsequent items (e.g., subdirectories). #>; Write-Host "^""Successfully deleted: $($path) (already deleted)."^""; $deletedCount++; continue; }; try {; Remove-Item -Path $path -Force -Recurse -ErrorAction Stop; $deletedCount++; Write-Host "^""Successfully deleted: $($path)"^""; } catch {; $failedCount++; Write-Warning "^""Unable to delete $($path): $_"^""; }; }; if ($skippedCount -gt 0) {; Write-Host "^""Skipped $($skippedCount) items."^""; }; Write-Host "^""Successfully deleted $($deletedCount) items."^""; if ($failedCount -gt 0) {; Write-Warning "^""Failed to delete $($failedCount) items."^""; }"
:: Delete files matching pattern: "%SYSTEMROOT%\System32\catroot2.log"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""%SYSTEMROOT%\System32\catroot2.log"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $deletedCount = 0; $failedCount = 0; $skippedCount = 0; $foundAbsolutePaths = @(); try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (Test-Path -Path $path -PathType Container) {; Write-Host "^""Skipping, the path is not a file but a folder: $($path)."^""; $skippedCount++; continue; }; if (-not (Test-Path $path)) { <# Re-check existence as prior deletions might remove subsequent items (e.g., subdirectories). #>; Write-Host "^""Successfully deleted: $($path) (already deleted)."^""; $deletedCount++; continue; }; try {; Remove-Item -Path $path -Force -Recurse -ErrorAction Stop; $deletedCount++; Write-Host "^""Successfully deleted: $($path)"^""; } catch {; $failedCount++; Write-Warning "^""Unable to delete $($path): $_"^""; }; }; if ($skippedCount -gt 0) {; Write-Host "^""Skipped $($skippedCount) items."^""; }; Write-Host "^""Successfully deleted $($deletedCount) items."^""; if ($failedCount -gt 0) {; Write-Warning "^""Failed to delete $($failedCount) items."^""; }"
:: Delete files matching pattern: "%SYSTEMROOT%\System32\catroot2.jrs"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""%SYSTEMROOT%\System32\catroot2.jrs"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $deletedCount = 0; $failedCount = 0; $skippedCount = 0; $foundAbsolutePaths = @(); try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (Test-Path -Path $path -PathType Container) {; Write-Host "^""Skipping, the path is not a file but a folder: $($path)."^""; $skippedCount++; continue; }; if (-not (Test-Path $path)) { <# Re-check existence as prior deletions might remove subsequent items (e.g., subdirectories). #>; Write-Host "^""Successfully deleted: $($path) (already deleted)."^""; $deletedCount++; continue; }; try {; Remove-Item -Path $path -Force -Recurse -ErrorAction Stop; $deletedCount++; Write-Host "^""Successfully deleted: $($path)"^""; } catch {; $failedCount++; Write-Warning "^""Unable to delete $($path): $_"^""; }; }; if ($skippedCount -gt 0) {; Write-Host "^""Skipped $($skippedCount) items."^""; }; Write-Host "^""Successfully deleted $($deletedCount) items."^""; if ($failedCount -gt 0) {; Write-Warning "^""Failed to delete $($failedCount) items."^""; }"
:: Delete files matching pattern: "%SYSTEMROOT%\System32\catroot2.edb"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""%SYSTEMROOT%\System32\catroot2.edb"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $deletedCount = 0; $failedCount = 0; $skippedCount = 0; $foundAbsolutePaths = @(); try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (Test-Path -Path $path -PathType Container) {; Write-Host "^""Skipping, the path is not a file but a folder: $($path)."^""; $skippedCount++; continue; }; if (-not (Test-Path $path)) { <# Re-check existence as prior deletions might remove subsequent items (e.g., subdirectories). #>; Write-Host "^""Successfully deleted: $($path) (already deleted)."^""; $deletedCount++; continue; }; try {; Remove-Item -Path $path -Force -Recurse -ErrorAction Stop; $deletedCount++; Write-Host "^""Successfully deleted: $($path)"^""; } catch {; $failedCount++; Write-Warning "^""Unable to delete $($path): $_"^""; }; }; if ($skippedCount -gt 0) {; Write-Host "^""Skipped $($skippedCount) items."^""; }; Write-Host "^""Successfully deleted $($deletedCount) items."^""; if ($failedCount -gt 0) {; Write-Warning "^""Failed to delete $($failedCount) items."^""; }"
:: Delete files matching pattern: "%SYSTEMROOT%\System32\catroot2.chk"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""%SYSTEMROOT%\System32\catroot2.chk"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $deletedCount = 0; $failedCount = 0; $skippedCount = 0; $foundAbsolutePaths = @(); try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (Test-Path -Path $path -PathType Container) {; Write-Host "^""Skipping, the path is not a file but a folder: $($path)."^""; $skippedCount++; continue; }; if (-not (Test-Path $path)) { <# Re-check existence as prior deletions might remove subsequent items (e.g., subdirectories). #>; Write-Host "^""Successfully deleted: $($path) (already deleted)."^""; $deletedCount++; continue; }; try {; Remove-Item -Path $path -Force -Recurse -ErrorAction Stop; $deletedCount++; Write-Host "^""Successfully deleted: $($path)"^""; } catch {; $failedCount++; Write-Warning "^""Unable to delete $($path): $_"^""; }; }; if ($skippedCount -gt 0) {; Write-Host "^""Skipped $($skippedCount) items."^""; }; Write-Host "^""Successfully deleted $($deletedCount) items."^""; if ($failedCount -gt 0) {; Write-Warning "^""Failed to delete $($failedCount) items."^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----Clear Server-initiated Healing Events system logs-----
:: ----------------------------------------------------------
echo --- Clear Server-initiated Healing Events system logs
:: Clear directory contents  : "%SYSTEMROOT%\Logs\SIH"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""$($directoryGlob = '%SYSTEMROOT%\Logs\SIH'; if ($directoryGlob.EndsWith('\*')) { $directoryGlob } elseif ($directoryGlob.EndsWith('\')) { "^""$($directoryGlob)*"^"" } else { "^""$($directoryGlob)\*"^"" } )"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $deletedCount = 0; $failedCount = 0; $foundAbsolutePaths = @(); Write-Host 'Iterating files and directories recursively.'; try {; $foundAbsolutePaths += @(; Get-ChildItem -Path $expandedPath -Force -Recurse -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (-not (Test-Path $path)) { <# Re-check existence as prior deletions might remove subsequent items (e.g., subdirectories). #>; Write-Host "^""Successfully deleted: $($path) (already deleted)."^""; $deletedCount++; continue; }; try {; Remove-Item -Path $path -Force -Recurse -ErrorAction Stop; $deletedCount++; Write-Host "^""Successfully deleted: $($path)"^""; } catch {; $failedCount++; Write-Warning "^""Unable to delete $($path): $_"^""; }; }; Write-Host "^""Successfully deleted $($deletedCount) items."^""; if ($failedCount -gt 0) {; Write-Warning "^""Failed to delete $($failedCount) items."^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----------------Clear Windows Update logs-----------------
:: ----------------------------------------------------------
echo --- Clear Windows Update logs
:: Clear directory contents  : "%SYSTEMROOT%\Traces\WindowsUpdate"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""$($directoryGlob = '%SYSTEMROOT%\Traces\WindowsUpdate'; if ($directoryGlob.EndsWith('\*')) { $directoryGlob } elseif ($directoryGlob.EndsWith('\')) { "^""$($directoryGlob)*"^"" } else { "^""$($directoryGlob)\*"^"" } )"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $deletedCount = 0; $failedCount = 0; $foundAbsolutePaths = @(); Write-Host 'Iterating files and directories recursively.'; try {; $foundAbsolutePaths += @(; Get-ChildItem -Path $expandedPath -Force -Recurse -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (-not (Test-Path $path)) { <# Re-check existence as prior deletions might remove subsequent items (e.g., subdirectories). #>; Write-Host "^""Successfully deleted: $($path) (already deleted)."^""; $deletedCount++; continue; }; try {; Remove-Item -Path $path -Force -Recurse -ErrorAction Stop; $deletedCount++; Write-Host "^""Successfully deleted: $($path)"^""; } catch {; $failedCount++; Write-Warning "^""Unable to delete $($path): $_"^""; }; }; Write-Host "^""Successfully deleted $($deletedCount) items."^""; if ($failedCount -gt 0) {; Write-Warning "^""Failed to delete $($failedCount) items."^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: Clear Optional Component Manager and COM+ components logs-
:: ----------------------------------------------------------
echo --- Clear Optional Component Manager and COM+ components logs
:: Delete files matching pattern: "%SYSTEMROOT%\comsetup.log"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""%SYSTEMROOT%\comsetup.log"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $deletedCount = 0; $failedCount = 0; $skippedCount = 0; $foundAbsolutePaths = @(); try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (Test-Path -Path $path -PathType Container) {; Write-Host "^""Skipping, the path is not a file but a folder: $($path)."^""; $skippedCount++; continue; }; if (-not (Test-Path $path)) { <# Re-check existence as prior deletions might remove subsequent items (e.g., subdirectories). #>; Write-Host "^""Successfully deleted: $($path) (already deleted)."^""; $deletedCount++; continue; }; try {; Remove-Item -Path $path -Force -Recurse -ErrorAction Stop; $deletedCount++; Write-Host "^""Successfully deleted: $($path)"^""; } catch {; $failedCount++; Write-Warning "^""Unable to delete $($path): $_"^""; }; }; if ($skippedCount -gt 0) {; Write-Host "^""Skipped $($skippedCount) items."^""; }; Write-Host "^""Successfully deleted $($deletedCount) items."^""; if ($failedCount -gt 0) {; Write-Warning "^""Failed to delete $($failedCount) items."^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --Clear "Distributed Transaction Coordinator (DTC)" logs--
:: ----------------------------------------------------------
echo --- Clear "Distributed Transaction Coordinator (DTC)" logs
:: Delete files matching pattern: "%SYSTEMROOT%\DtcInstall.log"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""%SYSTEMROOT%\DtcInstall.log"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $deletedCount = 0; $failedCount = 0; $skippedCount = 0; $foundAbsolutePaths = @(); try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (Test-Path -Path $path -PathType Container) {; Write-Host "^""Skipping, the path is not a file but a folder: $($path)."^""; $skippedCount++; continue; }; if (-not (Test-Path $path)) { <# Re-check existence as prior deletions might remove subsequent items (e.g., subdirectories). #>; Write-Host "^""Successfully deleted: $($path) (already deleted)."^""; $deletedCount++; continue; }; try {; Remove-Item -Path $path -Force -Recurse -ErrorAction Stop; $deletedCount++; Write-Host "^""Successfully deleted: $($path)"^""; } catch {; $failedCount++; Write-Warning "^""Unable to delete $($path): $_"^""; }; }; if ($skippedCount -gt 0) {; Write-Host "^""Skipped $($skippedCount) items."^""; }; Write-Host "^""Successfully deleted $($deletedCount) items."^""; if ($failedCount -gt 0) {; Write-Warning "^""Failed to delete $($failedCount) items."^""; }"
:: ----------------------------------------------------------


:: Clear logs for pending/unsuccessful file rename operations
echo --- Clear logs for pending/unsuccessful file rename operations
:: Delete files matching pattern: "%SYSTEMROOT%\PFRO.log"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""%SYSTEMROOT%\PFRO.log"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $deletedCount = 0; $failedCount = 0; $skippedCount = 0; $foundAbsolutePaths = @(); try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (Test-Path -Path $path -PathType Container) {; Write-Host "^""Skipping, the path is not a file but a folder: $($path)."^""; $skippedCount++; continue; }; if (-not (Test-Path $path)) { <# Re-check existence as prior deletions might remove subsequent items (e.g., subdirectories). #>; Write-Host "^""Successfully deleted: $($path) (already deleted)."^""; $deletedCount++; continue; }; try {; Remove-Item -Path $path -Force -Recurse -ErrorAction Stop; $deletedCount++; Write-Host "^""Successfully deleted: $($path)"^""; } catch {; $failedCount++; Write-Warning "^""Unable to delete $($path): $_"^""; }; }; if ($skippedCount -gt 0) {; Write-Host "^""Skipped $($skippedCount) items."^""; }; Write-Host "^""Successfully deleted $($deletedCount) items."^""; if ($failedCount -gt 0) {; Write-Warning "^""Failed to delete $($failedCount) items."^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----------Clear Windows update installation logs----------
:: ----------------------------------------------------------
echo --- Clear Windows update installation logs
:: Delete files matching pattern: "%SYSTEMROOT%\setupact.log"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""%SYSTEMROOT%\setupact.log"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $deletedCount = 0; $failedCount = 0; $skippedCount = 0; $foundAbsolutePaths = @(); try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (Test-Path -Path $path -PathType Container) {; Write-Host "^""Skipping, the path is not a file but a folder: $($path)."^""; $skippedCount++; continue; }; if (-not (Test-Path $path)) { <# Re-check existence as prior deletions might remove subsequent items (e.g., subdirectories). #>; Write-Host "^""Successfully deleted: $($path) (already deleted)."^""; $deletedCount++; continue; }; try {; Remove-Item -Path $path -Force -Recurse -ErrorAction Stop; $deletedCount++; Write-Host "^""Successfully deleted: $($path)"^""; } catch {; $failedCount++; Write-Warning "^""Unable to delete $($path): $_"^""; }; }; if ($skippedCount -gt 0) {; Write-Host "^""Skipped $($skippedCount) items."^""; }; Write-Host "^""Successfully deleted $($deletedCount) items."^""; if ($failedCount -gt 0) {; Write-Warning "^""Failed to delete $($failedCount) items."^""; }"
:: Delete files matching pattern: "%SYSTEMROOT%\setuperr.log"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""%SYSTEMROOT%\setuperr.log"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $deletedCount = 0; $failedCount = 0; $skippedCount = 0; $foundAbsolutePaths = @(); try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (Test-Path -Path $path -PathType Container) {; Write-Host "^""Skipping, the path is not a file but a folder: $($path)."^""; $skippedCount++; continue; }; if (-not (Test-Path $path)) { <# Re-check existence as prior deletions might remove subsequent items (e.g., subdirectories). #>; Write-Host "^""Successfully deleted: $($path) (already deleted)."^""; $deletedCount++; continue; }; try {; Remove-Item -Path $path -Force -Recurse -ErrorAction Stop; $deletedCount++; Write-Host "^""Successfully deleted: $($path)"^""; } catch {; $failedCount++; Write-Warning "^""Unable to delete $($path): $_"^""; }; }; if ($skippedCount -gt 0) {; Write-Host "^""Skipped $($skippedCount) items."^""; }; Write-Host "^""Successfully deleted $($deletedCount) items."^""; if ($failedCount -gt 0) {; Write-Warning "^""Failed to delete $($failedCount) items."^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----------------Clear Windows setup logs-----------------
:: ----------------------------------------------------------
echo --- Clear Windows setup logs
:: Delete files matching pattern: "%SYSTEMROOT%\setupapi.log"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""%SYSTEMROOT%\setupapi.log"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $deletedCount = 0; $failedCount = 0; $skippedCount = 0; $foundAbsolutePaths = @(); try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (Test-Path -Path $path -PathType Container) {; Write-Host "^""Skipping, the path is not a file but a folder: $($path)."^""; $skippedCount++; continue; }; if (-not (Test-Path $path)) { <# Re-check existence as prior deletions might remove subsequent items (e.g., subdirectories). #>; Write-Host "^""Successfully deleted: $($path) (already deleted)."^""; $deletedCount++; continue; }; try {; Remove-Item -Path $path -Force -Recurse -ErrorAction Stop; $deletedCount++; Write-Host "^""Successfully deleted: $($path)"^""; } catch {; $failedCount++; Write-Warning "^""Unable to delete $($path): $_"^""; }; }; if ($skippedCount -gt 0) {; Write-Host "^""Skipped $($skippedCount) items."^""; }; Write-Host "^""Successfully deleted $($deletedCount) items."^""; if ($failedCount -gt 0) {; Write-Warning "^""Failed to delete $($failedCount) items."^""; }"
:: Delete files matching pattern: "%SYSTEMROOT%\inf\setupapi.app.log"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""%SYSTEMROOT%\inf\setupapi.app.log"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $deletedCount = 0; $failedCount = 0; $skippedCount = 0; $foundAbsolutePaths = @(); try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (Test-Path -Path $path -PathType Container) {; Write-Host "^""Skipping, the path is not a file but a folder: $($path)."^""; $skippedCount++; continue; }; if (-not (Test-Path $path)) { <# Re-check existence as prior deletions might remove subsequent items (e.g., subdirectories). #>; Write-Host "^""Successfully deleted: $($path) (already deleted)."^""; $deletedCount++; continue; }; try {; Remove-Item -Path $path -Force -Recurse -ErrorAction Stop; $deletedCount++; Write-Host "^""Successfully deleted: $($path)"^""; } catch {; $failedCount++; Write-Warning "^""Unable to delete $($path): $_"^""; }; }; if ($skippedCount -gt 0) {; Write-Host "^""Skipped $($skippedCount) items."^""; }; Write-Host "^""Successfully deleted $($deletedCount) items."^""; if ($failedCount -gt 0) {; Write-Warning "^""Failed to delete $($failedCount) items."^""; }"
:: Delete files matching pattern: "%SYSTEMROOT%\inf\setupapi.dev.log"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""%SYSTEMROOT%\inf\setupapi.dev.log"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $deletedCount = 0; $failedCount = 0; $skippedCount = 0; $foundAbsolutePaths = @(); try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (Test-Path -Path $path -PathType Container) {; Write-Host "^""Skipping, the path is not a file but a folder: $($path)."^""; $skippedCount++; continue; }; if (-not (Test-Path $path)) { <# Re-check existence as prior deletions might remove subsequent items (e.g., subdirectories). #>; Write-Host "^""Successfully deleted: $($path) (already deleted)."^""; $deletedCount++; continue; }; try {; Remove-Item -Path $path -Force -Recurse -ErrorAction Stop; $deletedCount++; Write-Host "^""Successfully deleted: $($path)"^""; } catch {; $failedCount++; Write-Warning "^""Unable to delete $($path): $_"^""; }; }; if ($skippedCount -gt 0) {; Write-Host "^""Skipped $($skippedCount) items."^""; }; Write-Host "^""Successfully deleted $($deletedCount) items."^""; if ($failedCount -gt 0) {; Write-Warning "^""Failed to delete $($failedCount) items."^""; }"
:: Delete files matching pattern: "%SYSTEMROOT%\inf\setupapi.offline.log"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""%SYSTEMROOT%\inf\setupapi.offline.log"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $deletedCount = 0; $failedCount = 0; $skippedCount = 0; $foundAbsolutePaths = @(); try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (Test-Path -Path $path -PathType Container) {; Write-Host "^""Skipping, the path is not a file but a folder: $($path)."^""; $skippedCount++; continue; }; if (-not (Test-Path $path)) { <# Re-check existence as prior deletions might remove subsequent items (e.g., subdirectories). #>; Write-Host "^""Successfully deleted: $($path) (already deleted)."^""; $deletedCount++; continue; }; try {; Remove-Item -Path $path -Force -Recurse -ErrorAction Stop; $deletedCount++; Write-Host "^""Successfully deleted: $($path)"^""; } catch {; $failedCount++; Write-Warning "^""Unable to delete $($path): $_"^""; }; }; if ($skippedCount -gt 0) {; Write-Host "^""Skipped $($skippedCount) items."^""; }; Write-Host "^""Successfully deleted $($deletedCount) items."^""; if ($failedCount -gt 0) {; Write-Warning "^""Failed to delete $($failedCount) items."^""; }"
:: Clear directory contents  : "%SYSTEMROOT%\Panther"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""$($directoryGlob = '%SYSTEMROOT%\Panther'; if ($directoryGlob.EndsWith('\*')) { $directoryGlob } elseif ($directoryGlob.EndsWith('\')) { "^""$($directoryGlob)*"^"" } else { "^""$($directoryGlob)\*"^"" } )"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $deletedCount = 0; $failedCount = 0; $foundAbsolutePaths = @(); Write-Host 'Iterating files and directories recursively.'; try {; $foundAbsolutePaths += @(; Get-ChildItem -Path $expandedPath -Force -Recurse -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (-not (Test-Path $path)) { <# Re-check existence as prior deletions might remove subsequent items (e.g., subdirectories). #>; Write-Host "^""Successfully deleted: $($path) (already deleted)."^""; $deletedCount++; continue; }; try {; Remove-Item -Path $path -Force -Recurse -ErrorAction Stop; $deletedCount++; Write-Host "^""Successfully deleted: $($path)"^""; } catch {; $failedCount++; Write-Warning "^""Unable to delete $($path): $_"^""; }; }; Write-Host "^""Successfully deleted $($deletedCount) items."^""; if ($failedCount -gt 0) {; Write-Warning "^""Failed to delete $($failedCount) items."^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --Clear "Windows System Assessment Tool (`WinSAT`)" logs--
:: ----------------------------------------------------------
echo --- Clear "Windows System Assessment Tool (`WinSAT`)" logs
:: Delete files matching pattern: "%SYSTEMROOT%\Performance\WinSAT\winsat.log"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""%SYSTEMROOT%\Performance\WinSAT\winsat.log"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $deletedCount = 0; $failedCount = 0; $skippedCount = 0; $foundAbsolutePaths = @(); try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (Test-Path -Path $path -PathType Container) {; Write-Host "^""Skipping, the path is not a file but a folder: $($path)."^""; $skippedCount++; continue; }; if (-not (Test-Path $path)) { <# Re-check existence as prior deletions might remove subsequent items (e.g., subdirectories). #>; Write-Host "^""Successfully deleted: $($path) (already deleted)."^""; $deletedCount++; continue; }; try {; Remove-Item -Path $path -Force -Recurse -ErrorAction Stop; $deletedCount++; Write-Host "^""Successfully deleted: $($path)"^""; } catch {; $failedCount++; Write-Warning "^""Unable to delete $($path): $_"^""; }; }; if ($skippedCount -gt 0) {; Write-Host "^""Skipped $($skippedCount) items."^""; }; Write-Host "^""Successfully deleted $($deletedCount) items."^""; if ($failedCount -gt 0) {; Write-Warning "^""Failed to delete $($failedCount) items."^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ---------------Clear password change events---------------
:: ----------------------------------------------------------
echo --- Clear password change events
:: Delete files matching pattern: "%SYSTEMROOT%\debug\PASSWD.LOG"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""%SYSTEMROOT%\debug\PASSWD.LOG"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $deletedCount = 0; $failedCount = 0; $skippedCount = 0; $foundAbsolutePaths = @(); try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (Test-Path -Path $path -PathType Container) {; Write-Host "^""Skipping, the path is not a file but a folder: $($path)."^""; $skippedCount++; continue; }; if (-not (Test-Path $path)) { <# Re-check existence as prior deletions might remove subsequent items (e.g., subdirectories). #>; Write-Host "^""Successfully deleted: $($path) (already deleted)."^""; $deletedCount++; continue; }; try {; Remove-Item -Path $path -Force -Recurse -ErrorAction Stop; $deletedCount++; Write-Host "^""Successfully deleted: $($path)"^""; } catch {; $failedCount++; Write-Warning "^""Unable to delete $($path): $_"^""; }; }; if ($skippedCount -gt 0) {; Write-Host "^""Skipped $($skippedCount) items."^""; }; Write-Host "^""Successfully deleted $($deletedCount) items."^""; if ($failedCount -gt 0) {; Write-Warning "^""Failed to delete $($failedCount) items."^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --------------Clear user web cache database---------------
:: ----------------------------------------------------------
echo --- Clear user web cache database
:: Clear directory contents  : "%LOCALAPPDATA%\Microsoft\Windows\WebCache"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""$($directoryGlob = '%LOCALAPPDATA%\Microsoft\Windows\WebCache'; if ($directoryGlob.EndsWith('\*')) { $directoryGlob } elseif ($directoryGlob.EndsWith('\')) { "^""$($directoryGlob)*"^"" } else { "^""$($directoryGlob)\*"^"" } )"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $deletedCount = 0; $failedCount = 0; $foundAbsolutePaths = @(); Write-Host 'Iterating files and directories recursively.'; try {; $foundAbsolutePaths += @(; Get-ChildItem -Path $expandedPath -Force -Recurse -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (-not (Test-Path $path)) { <# Re-check existence as prior deletions might remove subsequent items (e.g., subdirectories). #>; Write-Host "^""Successfully deleted: $($path) (already deleted)."^""; $deletedCount++; continue; }; try {; Remove-Item -Path $path -Force -Recurse -ErrorAction Stop; $deletedCount++; Write-Host "^""Successfully deleted: $($path)"^""; } catch {; $failedCount++; Write-Warning "^""Unable to delete $($path): $_"^""; }; }; Write-Host "^""Successfully deleted $($deletedCount) items."^""; if ($failedCount -gt 0) {; Write-Warning "^""Failed to delete $($failedCount) items."^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -------Clear system temp folder when not logged in--------
:: ----------------------------------------------------------
echo --- Clear system temp folder when not logged in
:: Clear directory contents  : "%SYSTEMROOT%\ServiceProfiles\LocalService\AppData\Local\Temp"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""$($directoryGlob = '%SYSTEMROOT%\ServiceProfiles\LocalService\AppData\Local\Temp'; if ($directoryGlob.EndsWith('\*')) { $directoryGlob } elseif ($directoryGlob.EndsWith('\')) { "^""$($directoryGlob)*"^"" } else { "^""$($directoryGlob)\*"^"" } )"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $deletedCount = 0; $failedCount = 0; $foundAbsolutePaths = @(); Write-Host 'Iterating files and directories recursively.'; try {; $foundAbsolutePaths += @(; Get-ChildItem -Path $expandedPath -Force -Recurse -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (-not (Test-Path $path)) { <# Re-check existence as prior deletions might remove subsequent items (e.g., subdirectories). #>; Write-Host "^""Successfully deleted: $($path) (already deleted)."^""; $deletedCount++; continue; }; try {; Remove-Item -Path $path -Force -Recurse -ErrorAction Stop; $deletedCount++; Write-Host "^""Successfully deleted: $($path)"^""; } catch {; $failedCount++; Write-Warning "^""Unable to delete $($path): $_"^""; }; }; Write-Host "^""Successfully deleted $($deletedCount) items."^""; if ($failedCount -gt 0) {; Write-Warning "^""Failed to delete $($failedCount) items."^""; }"
:: ----------------------------------------------------------


:: Clear DISM (Deployment Image Servicing and Management) system logs
echo --- Clear DISM (Deployment Image Servicing and Management) system logs
:: Delete files matching pattern: "%SYSTEMROOT%\Logs\CBS\CBS.log"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""%SYSTEMROOT%\Logs\CBS\CBS.log"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $deletedCount = 0; $failedCount = 0; $skippedCount = 0; $foundAbsolutePaths = @(); try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (Test-Path -Path $path -PathType Container) {; Write-Host "^""Skipping, the path is not a file but a folder: $($path)."^""; $skippedCount++; continue; }; if (-not (Test-Path $path)) { <# Re-check existence as prior deletions might remove subsequent items (e.g., subdirectories). #>; Write-Host "^""Successfully deleted: $($path) (already deleted)."^""; $deletedCount++; continue; }; try {; Remove-Item -Path $path -Force -Recurse -ErrorAction Stop; $deletedCount++; Write-Host "^""Successfully deleted: $($path)"^""; } catch {; $failedCount++; Write-Warning "^""Unable to delete $($path): $_"^""; }; }; if ($skippedCount -gt 0) {; Write-Host "^""Skipped $($skippedCount) items."^""; }; Write-Host "^""Successfully deleted $($deletedCount) items."^""; if ($failedCount -gt 0) {; Write-Warning "^""Failed to delete $($failedCount) items."^""; }"
:: Delete files matching pattern: "%SYSTEMROOT%\Logs\DISM\DISM.log"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""%SYSTEMROOT%\Logs\DISM\DISM.log"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $deletedCount = 0; $failedCount = 0; $skippedCount = 0; $foundAbsolutePaths = @(); try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (Test-Path -Path $path -PathType Container) {; Write-Host "^""Skipping, the path is not a file but a folder: $($path)."^""; $skippedCount++; continue; }; if (-not (Test-Path $path)) { <# Re-check existence as prior deletions might remove subsequent items (e.g., subdirectories). #>; Write-Host "^""Successfully deleted: $($path) (already deleted)."^""; $deletedCount++; continue; }; try {; Remove-Item -Path $path -Force -Recurse -ErrorAction Stop; $deletedCount++; Write-Host "^""Successfully deleted: $($path)"^""; } catch {; $failedCount++; Write-Warning "^""Unable to delete $($path): $_"^""; }; }; if ($skippedCount -gt 0) {; Write-Host "^""Skipped $($skippedCount) items."^""; }; Write-Host "^""Successfully deleted $($deletedCount) items."^""; if ($failedCount -gt 0) {; Write-Warning "^""Failed to delete $($failedCount) items."^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----------------Clear Windows update files----------------
:: ----------------------------------------------------------
echo --- Clear Windows update files
:: Stop service: wuauserv (with state flag) (wait until stopped)
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'wuauserv'; Write-Host "^""Stopping service: `"^""$serviceName`"^""."^""; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if (!$service) {; Write-Host "^""Skipping, service `"^""$serviceName`"^"" could not be not found, no need to stop it."^""; exit 0; }; if ($service.Status -ne [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""Skipping, `"^""$serviceName`"^"" is not running, no need to stop."^""; exit 0; }; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; $service | Stop-Service -Force -ErrorAction Stop; $service.WaitForStatus([System.ServiceProcess.ServiceControllerStatus]::Stopped); } catch {; throw "^""Failed to stop the service `"^""$serviceName`"^"": $_"^""; }; Write-Host "^""Successfully stopped the service: `"^""$serviceName`"^""."^""; $stateFilePath = '%APPDATA%\privacy.sexy-wuauserv'; $expandedStateFilePath = [System.Environment]::ExpandEnvironmentVariables($stateFilePath); if (Test-Path -Path $expandedStateFilePath) {; Write-Host "^""Skipping creating a service state file, it already exists: `"^""$expandedStateFilePath`"^""."^""; } else {; <# Ensure the directory exists #>; $parentDirectory = [System.IO.Path]::GetDirectoryName($expandedStateFilePath); if (-not (Test-Path $parentDirectory -PathType Container)) {; try {; New-Item -ItemType Directory -Path $parentDirectory -Force -ErrorAction Stop | Out-Null; }  catch {; Write-Warning "^""Failed to create parent directory of service state file `"^""$parentDirectory`"^"": $_"^""; }; }; <# Create the state file #>; try {; New-Item -ItemType File -Path $expandedStateFilePath -Force -ErrorAction Stop | Out-Null; Write-Host 'The service will be started again.'; } catch {; Write-Warning "^""Failed to create service state file `"^""$expandedStateFilePath`"^"": $_"^""; }; }"
:: Clear directory contents  : "%SYSTEMROOT%\SoftwareDistribution"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""$($directoryGlob = '%SYSTEMROOT%\SoftwareDistribution'; if ($directoryGlob.EndsWith('\*')) { $directoryGlob } elseif ($directoryGlob.EndsWith('\')) { "^""$($directoryGlob)*"^"" } else { "^""$($directoryGlob)\*"^"" } )"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $deletedCount = 0; $failedCount = 0; $foundAbsolutePaths = @(); Write-Host 'Iterating files and directories recursively.'; try {; $foundAbsolutePaths += @(; Get-ChildItem -Path $expandedPath -Force -Recurse -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (-not (Test-Path $path)) { <# Re-check existence as prior deletions might remove subsequent items (e.g., subdirectories). #>; Write-Host "^""Successfully deleted: $($path) (already deleted)."^""; $deletedCount++; continue; }; try {; Remove-Item -Path $path -Force -Recurse -ErrorAction Stop; $deletedCount++; Write-Host "^""Successfully deleted: $($path)"^""; } catch {; $failedCount++; Write-Warning "^""Unable to delete $($path): $_"^""; }; }; Write-Host "^""Successfully deleted $($deletedCount) items."^""; if ($failedCount -gt 0) {; Write-Warning "^""Failed to delete $($failedCount) items."^""; }"
:: Start service: wuauserv (with state flag)
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'wuauserv'; $stateFilePath = '%APPDATA%\privacy.sexy-wuauserv'; $expandedStateFilePath = [System.Environment]::ExpandEnvironmentVariables($stateFilePath); if (-not (Test-Path -Path $expandedStateFilePath)) {; Write-Host "^""Skipping starting the service: It was not running before."^""; } else {; try {; Remove-Item -Path $expandedStateFilePath -Force -ErrorAction Stop; Write-Host 'The service is expected to be started.'; } catch {; Write-Warning "^""Failed to delete the service state file `"^""$expandedStateFilePath`"^"": $_"^""; }; }; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if (!$service) {; throw "^""Failed to start service `"^""$serviceName`"^"": Service not found."^""; }; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""Skipping, `"^""$serviceName`"^"" is already running, no need to start."^""; exit 0; }; Write-Host "^""`"^""$serviceName`"^"" is not running, starting it."^""; try {; $service | Start-Service -ErrorAction Stop; Write-Host "^""Successfully started the service: `"^""$serviceName`"^""."^""; } catch {; Write-Warning "^""Failed to start the service: `"^""$serviceName`"^""."^""; exit 1; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --------Clear Common Language Runtime system logs---------
:: ----------------------------------------------------------
echo --- Clear Common Language Runtime system logs
:: Clear directory contents  : "%LOCALAPPDATA%\Microsoft\CLR_v4.0\UsageTraces"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""$($directoryGlob = '%LOCALAPPDATA%\Microsoft\CLR_v4.0\UsageTraces'; if ($directoryGlob.EndsWith('\*')) { $directoryGlob } elseif ($directoryGlob.EndsWith('\')) { "^""$($directoryGlob)*"^"" } else { "^""$($directoryGlob)\*"^"" } )"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $deletedCount = 0; $failedCount = 0; $foundAbsolutePaths = @(); Write-Host 'Iterating files and directories recursively.'; try {; $foundAbsolutePaths += @(; Get-ChildItem -Path $expandedPath -Force -Recurse -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (-not (Test-Path $path)) { <# Re-check existence as prior deletions might remove subsequent items (e.g., subdirectories). #>; Write-Host "^""Successfully deleted: $($path) (already deleted)."^""; $deletedCount++; continue; }; try {; Remove-Item -Path $path -Force -Recurse -ErrorAction Stop; $deletedCount++; Write-Host "^""Successfully deleted: $($path)"^""; } catch {; $failedCount++; Write-Warning "^""Unable to delete $($path): $_"^""; }; }; Write-Host "^""Successfully deleted $($deletedCount) items."^""; if ($failedCount -gt 0) {; Write-Warning "^""Failed to delete $($failedCount) items."^""; }"
:: Clear directory contents  : "%LOCALAPPDATA%\Microsoft\CLR_v4.0_32\UsageTraces"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""$($directoryGlob = '%LOCALAPPDATA%\Microsoft\CLR_v4.0_32\UsageTraces'; if ($directoryGlob.EndsWith('\*')) { $directoryGlob } elseif ($directoryGlob.EndsWith('\')) { "^""$($directoryGlob)*"^"" } else { "^""$($directoryGlob)\*"^"" } )"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $deletedCount = 0; $failedCount = 0; $foundAbsolutePaths = @(); Write-Host 'Iterating files and directories recursively.'; try {; $foundAbsolutePaths += @(; Get-ChildItem -Path $expandedPath -Force -Recurse -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (-not (Test-Path $path)) { <# Re-check existence as prior deletions might remove subsequent items (e.g., subdirectories). #>; Write-Host "^""Successfully deleted: $($path) (already deleted)."^""; $deletedCount++; continue; }; try {; Remove-Item -Path $path -Force -Recurse -ErrorAction Stop; $deletedCount++; Write-Host "^""Successfully deleted: $($path)"^""; } catch {; $failedCount++; Write-Warning "^""Unable to delete $($path): $_"^""; }; }; Write-Host "^""Successfully deleted $($deletedCount) items."^""; if ($failedCount -gt 0) {; Write-Warning "^""Failed to delete $($failedCount) items."^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ------Clear Network Setup Service Events system logs------
:: ----------------------------------------------------------
echo --- Clear Network Setup Service Events system logs
:: Clear directory contents  : "%SYSTEMROOT%\Logs\NetSetup"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""$($directoryGlob = '%SYSTEMROOT%\Logs\NetSetup'; if ($directoryGlob.EndsWith('\*')) { $directoryGlob } elseif ($directoryGlob.EndsWith('\')) { "^""$($directoryGlob)*"^"" } else { "^""$($directoryGlob)\*"^"" } )"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $deletedCount = 0; $failedCount = 0; $foundAbsolutePaths = @(); Write-Host 'Iterating files and directories recursively.'; try {; $foundAbsolutePaths += @(; Get-ChildItem -Path $expandedPath -Force -Recurse -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (-not (Test-Path $path)) { <# Re-check existence as prior deletions might remove subsequent items (e.g., subdirectories). #>; Write-Host "^""Successfully deleted: $($path) (already deleted)."^""; $deletedCount++; continue; }; try {; Remove-Item -Path $path -Force -Recurse -ErrorAction Stop; $deletedCount++; Write-Host "^""Successfully deleted: $($path)"^""; } catch {; $failedCount++; Write-Warning "^""Unable to delete $($path): $_"^""; }; }; Write-Host "^""Successfully deleted $($deletedCount) items."^""; if ($failedCount -gt 0) {; Write-Warning "^""Failed to delete $($failedCount) items."^""; }"
:: ----------------------------------------------------------


:: Clear logs generated by Disk Cleanup Tool (`cleanmgr.exe`)
echo --- Clear logs generated by Disk Cleanup Tool (`cleanmgr.exe`)
:: Clear directory contents  : "%SYSTEMROOT%\System32\LogFiles\setupcln"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""$($directoryGlob = '%SYSTEMROOT%\System32\LogFiles\setupcln'; if ($directoryGlob.EndsWith('\*')) { $directoryGlob } elseif ($directoryGlob.EndsWith('\')) { "^""$($directoryGlob)*"^"" } else { "^""$($directoryGlob)\*"^"" } )"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $deletedCount = 0; $failedCount = 0; $foundAbsolutePaths = @(); Write-Host 'Iterating files and directories recursively.'; try {; $foundAbsolutePaths += @(; Get-ChildItem -Path $expandedPath -Force -Recurse -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (-not (Test-Path $path)) { <# Re-check existence as prior deletions might remove subsequent items (e.g., subdirectories). #>; Write-Host "^""Successfully deleted: $($path) (already deleted)."^""; $deletedCount++; continue; }; try {; Remove-Item -Path $path -Force -Recurse -ErrorAction Stop; $deletedCount++; Write-Host "^""Successfully deleted: $($path)"^""; } catch {; $failedCount++; Write-Warning "^""Unable to delete $($path): $_"^""; }; }; Write-Host "^""Successfully deleted $($deletedCount) items."^""; if ($failedCount -gt 0) {; Write-Warning "^""Failed to delete $($failedCount) items."^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ------------------Clear thumbnail cache-------------------
:: ----------------------------------------------------------
echo --- Clear thumbnail cache
:: Delete files matching pattern: "%LOCALAPPDATA%\Microsoft\Windows\Explorer\*.db"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""%LOCALAPPDATA%\Microsoft\Windows\Explorer\*.db"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $deletedCount = 0; $failedCount = 0; $skippedCount = 0; $foundAbsolutePaths = @(); try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (Test-Path -Path $path -PathType Container) {; Write-Host "^""Skipping, the path is not a file but a folder: $($path)."^""; $skippedCount++; continue; }; if (-not (Test-Path $path)) { <# Re-check existence as prior deletions might remove subsequent items (e.g., subdirectories). #>; Write-Host "^""Successfully deleted: $($path) (already deleted)."^""; $deletedCount++; continue; }; try {; Remove-Item -Path $path -Force -Recurse -ErrorAction Stop; $deletedCount++; Write-Host "^""Successfully deleted: $($path)"^""; } catch {; $failedCount++; Write-Warning "^""Unable to delete $($path): $_"^""; }; }; if ($skippedCount -gt 0) {; Write-Host "^""Skipped $($skippedCount) items."^""; }; Write-Host "^""Successfully deleted $($deletedCount) items."^""; if ($failedCount -gt 0) {; Write-Warning "^""Failed to delete $($failedCount) items."^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -------------Clear diagnostics tracking logs--------------
:: ----------------------------------------------------------
echo --- Clear diagnostics tracking logs
:: Stop service: DiagTrack (with state flag) (wait until stopped)
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'DiagTrack'; Write-Host "^""Stopping service: `"^""$serviceName`"^""."^""; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if (!$service) {; Write-Host "^""Skipping, service `"^""$serviceName`"^"" could not be not found, no need to stop it."^""; exit 0; }; if ($service.Status -ne [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""Skipping, `"^""$serviceName`"^"" is not running, no need to stop."^""; exit 0; }; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; $service | Stop-Service -Force -ErrorAction Stop; $service.WaitForStatus([System.ServiceProcess.ServiceControllerStatus]::Stopped); } catch {; throw "^""Failed to stop the service `"^""$serviceName`"^"": $_"^""; }; Write-Host "^""Successfully stopped the service: `"^""$serviceName`"^""."^""; $stateFilePath = '%APPDATA%\privacy.sexy-DiagTrack'; $expandedStateFilePath = [System.Environment]::ExpandEnvironmentVariables($stateFilePath); if (Test-Path -Path $expandedStateFilePath) {; Write-Host "^""Skipping creating a service state file, it already exists: `"^""$expandedStateFilePath`"^""."^""; } else {; <# Ensure the directory exists #>; $parentDirectory = [System.IO.Path]::GetDirectoryName($expandedStateFilePath); if (-not (Test-Path $parentDirectory -PathType Container)) {; try {; New-Item -ItemType Directory -Path $parentDirectory -Force -ErrorAction Stop | Out-Null; }  catch {; Write-Warning "^""Failed to create parent directory of service state file `"^""$parentDirectory`"^"": $_"^""; }; }; <# Create the state file #>; try {; New-Item -ItemType File -Path $expandedStateFilePath -Force -ErrorAction Stop | Out-Null; Write-Host 'The service will be started again.'; } catch {; Write-Warning "^""Failed to create service state file `"^""$expandedStateFilePath`"^"": $_"^""; }; }"
:: Delete files matching pattern: "%PROGRAMDATA%\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""%PROGRAMDATA%\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; <# Not using `Get-Acl`/`Set-Acl` to avoid adjusting token privileges #>; $parentDirectory = [System.IO.Path]::GetDirectoryName($expandedPath); $fileName = [System.IO.Path]::GetFileName($expandedPath); if ($parentDirectory -like '*[*?]*') {; throw "^""Unable to grant permissions to glob path parent directory: `"^""$parentDirectory`"^"", wildcards in parent directory are not supported by ``takeown`` and ``icacls``."^""; }; if (($fileName -ne '*') -and ($fileName -like '*[*?]*')) {; throw "^""Unable to grant permissions to glob path file name: `"^""$fileName`"^"", wildcards in file name is not supported by ``takeown`` and ``icacls``."^""; }; Write-Host "^""Taking ownership of `"^""$expandedPath`"^""."^""; $cmdPath = $expandedPath; if ($cmdPath.EndsWith('\')) {; $cmdPath += '\' <# Escape trailing backslash for correct handling in batch commands #>; }; $takeOwnershipCommand = "^""takeown /f `"^""$cmdPath`"^"" /a"^"" <# `icacls /setowner` does not succeed, so use `takeown` instead. #>; if (-not (Test-Path -Path "^""$expandedPath"^"" -PathType Leaf)) {; $localizedYes = 'Y' <# Default 'Yes' flag (fallback) #>; try {; $choiceOutput = cmd /c "^""choice <nul 2>nul"^""; if ($choiceOutput -and $choiceOutput.Length -ge 2) {; $localizedYes = $choiceOutput[1]; } else {; Write-Warning "^""Failed to determine localized 'Yes' character. Output: `"^""$choiceOutput`"^"""^""; }; } catch {; Write-Warning "^""Failed to determine localized 'Yes' character. Error: $_"^""; }; $takeOwnershipCommand += "^"" /r /d $localizedYes"^""; }; $takeOwnershipOutput = cmd /c "^""$takeOwnershipCommand 2>&1"^"" <# `stderr` message is misleading, e.g. "^""ERROR: The system cannot find the file specified."^"" is not an error. #>; if ($LASTEXITCODE -eq 0) {; Write-Host "^""Successfully took ownership of `"^""$expandedPath`"^"" (using ``$takeOwnershipCommand``)."^""; } else {; Write-Host "^""Did not take ownership of `"^""$expandedPath`"^"" using ``$takeOwnershipCommand``, status code: $LASTEXITCODE, message: $takeOwnershipOutput."^""; <# Do not write as error or warning, because this can be due to missing path, it's handled in next command. #>; <# `takeown` exits with status code `1`, making it hard to handle missing path here. #>; }; Write-Host "^""Granting permissions for `"^""$expandedPath`"^""."^""; $adminSid = New-Object System.Security.Principal.SecurityIdentifier 'S-1-5-32-544'; $adminAccount = $adminSid.Translate([System.Security.Principal.NTAccount]); $adminAccountName = $adminAccount.Value; $grantPermissionsCommand = "^""icacls `"^""$cmdPath`"^"" /grant `"^""$($adminAccountName):F`"^"" /t"^""; $icaclsOutput = cmd /c "^""$grantPermissionsCommand"^""; if ($LASTEXITCODE -eq 3) {; Write-Host "^""Skipping, no items available for deletion according to: ``$grantPermissionsCommand``."^""; exit 0; } elseif ($LASTEXITCODE -ne 0) {; Write-Host "^""Take ownership message:`n$takeOwnershipOutput"^""; Write-Host "^""Grant permissions:`n$icaclsOutput"^""; Write-Warning "^""Failed to assign permissions for `"^""$expandedPath`"^"" using ``$grantPermissionsCommand``, status code: $LASTEXITCODE."^""; } else {; $fileStats = $icaclsOutput | ForEach-Object { $_ -match '\d+' | Out-Null; $matches[0] } | Where-Object { $_ -ne $null } | ForEach-Object { [int]$_ }; if ($fileStats.Count -gt 0 -and ($fileStats | ForEach-Object { $_ -eq 0 } | Where-Object { $_ -eq $false }).Count -eq 0) {; Write-Host "^""Skipping, no items available for deletion according to: ``$grantPermissionsCommand``."^""; exit 0; } else {; Write-Host "^""Successfully granted permissions for `"^""$expandedPath`"^"" (using ``$grantPermissionsCommand``)."^""; }; }; $deletedCount = 0; $failedCount = 0; $skippedCount = 0; $foundAbsolutePaths = @(); try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (Test-Path -Path $path -PathType Container) {; Write-Host "^""Skipping, the path is not a file but a folder: $($path)."^""; $skippedCount++; continue; }; if (-not (Test-Path $path)) { <# Re-check existence as prior deletions might remove subsequent items (e.g., subdirectories). #>; Write-Host "^""Successfully deleted: $($path) (already deleted)."^""; $deletedCount++; continue; }; try {; Remove-Item -Path $path -Force -Recurse -ErrorAction Stop; $deletedCount++; Write-Host "^""Successfully deleted: $($path)"^""; } catch {; $failedCount++; Write-Warning "^""Unable to delete $($path): $_"^""; }; }; if ($skippedCount -gt 0) {; Write-Host "^""Skipped $($skippedCount) items."^""; }; Write-Host "^""Successfully deleted $($deletedCount) items."^""; if ($failedCount -gt 0) {; Write-Warning "^""Failed to delete $($failedCount) items."^""; }"
:: Delete files matching pattern: "%PROGRAMDATA%\Microsoft\Diagnosis\ETLLogs\ShutdownLogger\AutoLogger-Diagtrack-Listener.etl"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""%PROGRAMDATA%\Microsoft\Diagnosis\ETLLogs\ShutdownLogger\AutoLogger-Diagtrack-Listener.etl"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; <# Not using `Get-Acl`/`Set-Acl` to avoid adjusting token privileges #>; $parentDirectory = [System.IO.Path]::GetDirectoryName($expandedPath); $fileName = [System.IO.Path]::GetFileName($expandedPath); if ($parentDirectory -like '*[*?]*') {; throw "^""Unable to grant permissions to glob path parent directory: `"^""$parentDirectory`"^"", wildcards in parent directory are not supported by ``takeown`` and ``icacls``."^""; }; if (($fileName -ne '*') -and ($fileName -like '*[*?]*')) {; throw "^""Unable to grant permissions to glob path file name: `"^""$fileName`"^"", wildcards in file name is not supported by ``takeown`` and ``icacls``."^""; }; Write-Host "^""Taking ownership of `"^""$expandedPath`"^""."^""; $cmdPath = $expandedPath; if ($cmdPath.EndsWith('\')) {; $cmdPath += '\' <# Escape trailing backslash for correct handling in batch commands #>; }; $takeOwnershipCommand = "^""takeown /f `"^""$cmdPath`"^"" /a"^"" <# `icacls /setowner` does not succeed, so use `takeown` instead. #>; if (-not (Test-Path -Path "^""$expandedPath"^"" -PathType Leaf)) {; $localizedYes = 'Y' <# Default 'Yes' flag (fallback) #>; try {; $choiceOutput = cmd /c "^""choice <nul 2>nul"^""; if ($choiceOutput -and $choiceOutput.Length -ge 2) {; $localizedYes = $choiceOutput[1]; } else {; Write-Warning "^""Failed to determine localized 'Yes' character. Output: `"^""$choiceOutput`"^"""^""; }; } catch {; Write-Warning "^""Failed to determine localized 'Yes' character. Error: $_"^""; }; $takeOwnershipCommand += "^"" /r /d $localizedYes"^""; }; $takeOwnershipOutput = cmd /c "^""$takeOwnershipCommand 2>&1"^"" <# `stderr` message is misleading, e.g. "^""ERROR: The system cannot find the file specified."^"" is not an error. #>; if ($LASTEXITCODE -eq 0) {; Write-Host "^""Successfully took ownership of `"^""$expandedPath`"^"" (using ``$takeOwnershipCommand``)."^""; } else {; Write-Host "^""Did not take ownership of `"^""$expandedPath`"^"" using ``$takeOwnershipCommand``, status code: $LASTEXITCODE, message: $takeOwnershipOutput."^""; <# Do not write as error or warning, because this can be due to missing path, it's handled in next command. #>; <# `takeown` exits with status code `1`, making it hard to handle missing path here. #>; }; Write-Host "^""Granting permissions for `"^""$expandedPath`"^""."^""; $adminSid = New-Object System.Security.Principal.SecurityIdentifier 'S-1-5-32-544'; $adminAccount = $adminSid.Translate([System.Security.Principal.NTAccount]); $adminAccountName = $adminAccount.Value; $grantPermissionsCommand = "^""icacls `"^""$cmdPath`"^"" /grant `"^""$($adminAccountName):F`"^"" /t"^""; $icaclsOutput = cmd /c "^""$grantPermissionsCommand"^""; if ($LASTEXITCODE -eq 3) {; Write-Host "^""Skipping, no items available for deletion according to: ``$grantPermissionsCommand``."^""; exit 0; } elseif ($LASTEXITCODE -ne 0) {; Write-Host "^""Take ownership message:`n$takeOwnershipOutput"^""; Write-Host "^""Grant permissions:`n$icaclsOutput"^""; Write-Warning "^""Failed to assign permissions for `"^""$expandedPath`"^"" using ``$grantPermissionsCommand``, status code: $LASTEXITCODE."^""; } else {; $fileStats = $icaclsOutput | ForEach-Object { $_ -match '\d+' | Out-Null; $matches[0] } | Where-Object { $_ -ne $null } | ForEach-Object { [int]$_ }; if ($fileStats.Count -gt 0 -and ($fileStats | ForEach-Object { $_ -eq 0 } | Where-Object { $_ -eq $false }).Count -eq 0) {; Write-Host "^""Skipping, no items available for deletion according to: ``$grantPermissionsCommand``."^""; exit 0; } else {; Write-Host "^""Successfully granted permissions for `"^""$expandedPath`"^"" (using ``$grantPermissionsCommand``)."^""; }; }; $deletedCount = 0; $failedCount = 0; $skippedCount = 0; $foundAbsolutePaths = @(); try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (Test-Path -Path $path -PathType Container) {; Write-Host "^""Skipping, the path is not a file but a folder: $($path)."^""; $skippedCount++; continue; }; if (-not (Test-Path $path)) { <# Re-check existence as prior deletions might remove subsequent items (e.g., subdirectories). #>; Write-Host "^""Successfully deleted: $($path) (already deleted)."^""; $deletedCount++; continue; }; try {; Remove-Item -Path $path -Force -Recurse -ErrorAction Stop; $deletedCount++; Write-Host "^""Successfully deleted: $($path)"^""; } catch {; $failedCount++; Write-Warning "^""Unable to delete $($path): $_"^""; }; }; if ($skippedCount -gt 0) {; Write-Host "^""Skipped $($skippedCount) items."^""; }; Write-Host "^""Successfully deleted $($deletedCount) items."^""; if ($failedCount -gt 0) {; Write-Warning "^""Failed to delete $($failedCount) items."^""; }"
:: Start service: DiagTrack (with state flag)
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'DiagTrack'; $stateFilePath = '%APPDATA%\privacy.sexy-DiagTrack'; $expandedStateFilePath = [System.Environment]::ExpandEnvironmentVariables($stateFilePath); if (-not (Test-Path -Path $expandedStateFilePath)) {; Write-Host "^""Skipping starting the service: It was not running before."^""; } else {; try {; Remove-Item -Path $expandedStateFilePath -Force -ErrorAction Stop; Write-Host 'The service is expected to be started.'; } catch {; Write-Warning "^""Failed to delete the service state file `"^""$expandedStateFilePath`"^"": $_"^""; }; }; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if (!$service) {; throw "^""Failed to start service `"^""$serviceName`"^"": Service not found."^""; }; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""Skipping, `"^""$serviceName`"^"" is already running, no need to start."^""; exit 0; }; Write-Host "^""`"^""$serviceName`"^"" is not running, starting it."^""; try {; $service | Start-Service -ErrorAction Stop; Write-Host "^""Successfully started the service: `"^""$serviceName`"^""."^""; } catch {; Write-Warning "^""Failed to start the service: `"^""$serviceName`"^""."^""; exit 1; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -------Clear event logs in Event Viewer application-------
:: ----------------------------------------------------------
echo --- Clear event logs in Event Viewer application
REM https://social.technet.microsoft.com/Forums/en-US/f6788f7d-7d04-41f1-a64e-3af9f700e4bd/failed-to-clear-log-microsoftwindowsliveidoperational-access-is-denied?forum=win10itprogeneral
wevtutil sl Microsoft-Windows-LiveId/Operational /ca:O:BAG:SYD:(A;;0x1;;;SY)(A;;0x5;;;BA)(A;;0x1;;;LA)
for /f "tokens=*" %%i in ('wevtutil.exe el') DO (
    echo Deleting event log: "%%i"
    wevtutil.exe cl %1 "%%i"
)
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ---------Clear Defender scan (protection) history---------
:: ----------------------------------------------------------
echo --- Clear Defender scan (protection) history
:: Clear directory contents (with additional permissions) : "%ProgramData%\Microsoft\Windows Defender\Scans\History"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""$($directoryGlob = '%ProgramData%\Microsoft\Windows Defender\Scans\History'; if ($directoryGlob.EndsWith('\*')) { $directoryGlob } elseif ($directoryGlob.EndsWith('\')) { "^""$($directoryGlob)*"^"" } else { "^""$($directoryGlob)\*"^"" } )"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; <# Not using `Get-Acl`/`Set-Acl` to avoid adjusting token privileges #>; $parentDirectory = [System.IO.Path]::GetDirectoryName($expandedPath); $fileName = [System.IO.Path]::GetFileName($expandedPath); if ($parentDirectory -like '*[*?]*') {; throw "^""Unable to grant permissions to glob path parent directory: `"^""$parentDirectory`"^"", wildcards in parent directory are not supported by ``takeown`` and ``icacls``."^""; }; if (($fileName -ne '*') -and ($fileName -like '*[*?]*')) {; throw "^""Unable to grant permissions to glob path file name: `"^""$fileName`"^"", wildcards in file name is not supported by ``takeown`` and ``icacls``."^""; }; Write-Host "^""Taking ownership of `"^""$expandedPath`"^""."^""; $cmdPath = $expandedPath; if ($cmdPath.EndsWith('\')) {; $cmdPath += '\' <# Escape trailing backslash for correct handling in batch commands #>; }; $takeOwnershipCommand = "^""takeown /f `"^""$cmdPath`"^"" /a"^"" <# `icacls /setowner` does not succeed, so use `takeown` instead. #>; if (-not (Test-Path -Path "^""$expandedPath"^"" -PathType Leaf)) {; $localizedYes = 'Y' <# Default 'Yes' flag (fallback) #>; try {; $choiceOutput = cmd /c "^""choice <nul 2>nul"^""; if ($choiceOutput -and $choiceOutput.Length -ge 2) {; $localizedYes = $choiceOutput[1]; } else {; Write-Warning "^""Failed to determine localized 'Yes' character. Output: `"^""$choiceOutput`"^"""^""; }; } catch {; Write-Warning "^""Failed to determine localized 'Yes' character. Error: $_"^""; }; $takeOwnershipCommand += "^"" /r /d $localizedYes"^""; }; $takeOwnershipOutput = cmd /c "^""$takeOwnershipCommand 2>&1"^"" <# `stderr` message is misleading, e.g. "^""ERROR: The system cannot find the file specified."^"" is not an error. #>; if ($LASTEXITCODE -eq 0) {; Write-Host "^""Successfully took ownership of `"^""$expandedPath`"^"" (using ``$takeOwnershipCommand``)."^""; } else {; Write-Host "^""Did not take ownership of `"^""$expandedPath`"^"" using ``$takeOwnershipCommand``, status code: $LASTEXITCODE, message: $takeOwnershipOutput."^""; <# Do not write as error or warning, because this can be due to missing path, it's handled in next command. #>; <# `takeown` exits with status code `1`, making it hard to handle missing path here. #>; }; Write-Host "^""Granting permissions for `"^""$expandedPath`"^""."^""; $adminSid = New-Object System.Security.Principal.SecurityIdentifier 'S-1-5-32-544'; $adminAccount = $adminSid.Translate([System.Security.Principal.NTAccount]); $adminAccountName = $adminAccount.Value; $grantPermissionsCommand = "^""icacls `"^""$cmdPath`"^"" /grant `"^""$($adminAccountName):F`"^"" /t"^""; $icaclsOutput = cmd /c "^""$grantPermissionsCommand"^""; if ($LASTEXITCODE -eq 3) {; Write-Host "^""Skipping, no items available for deletion according to: ``$grantPermissionsCommand``."^""; exit 0; } elseif ($LASTEXITCODE -ne 0) {; Write-Host "^""Take ownership message:`n$takeOwnershipOutput"^""; Write-Host "^""Grant permissions:`n$icaclsOutput"^""; Write-Warning "^""Failed to assign permissions for `"^""$expandedPath`"^"" using ``$grantPermissionsCommand``, status code: $LASTEXITCODE."^""; } else {; $fileStats = $icaclsOutput | ForEach-Object { $_ -match '\d+' | Out-Null; $matches[0] } | Where-Object { $_ -ne $null } | ForEach-Object { [int]$_ }; if ($fileStats.Count -gt 0 -and ($fileStats | ForEach-Object { $_ -eq 0 } | Where-Object { $_ -eq $false }).Count -eq 0) {; Write-Host "^""Skipping, no items available for deletion according to: ``$grantPermissionsCommand``."^""; exit 0; } else {; Write-Host "^""Successfully granted permissions for `"^""$expandedPath`"^"" (using ``$grantPermissionsCommand``)."^""; }; }; $deletedCount = 0; $failedCount = 0; $foundAbsolutePaths = @(); Write-Host 'Iterating files and directories recursively.'; try {; $foundAbsolutePaths += @(; Get-ChildItem -Path $expandedPath -Force -Recurse -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (-not (Test-Path $path)) { <# Re-check existence as prior deletions might remove subsequent items (e.g., subdirectories). #>; Write-Host "^""Successfully deleted: $($path) (already deleted)."^""; $deletedCount++; continue; }; try {; Remove-Item -Path $path -Force -Recurse -ErrorAction Stop; $deletedCount++; Write-Host "^""Successfully deleted: $($path)"^""; } catch {; $failedCount++; Write-Warning "^""Unable to delete $($path): $_"^""; }; }; Write-Host "^""Successfully deleted $($deletedCount) items."^""; if ($failedCount -gt 0) {; Write-Warning "^""Failed to delete $($failedCount) items."^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----------Clear previous Windows installations-----------
:: ----------------------------------------------------------
echo --- Clear previous Windows installations
:: Delete directory (with additional permissions) : "%SYSTEMDRIVE%\Windows.old"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""$($directoryGlob = '%SYSTEMDRIVE%\Windows.old'; if (-Not $directoryGlob.EndsWith('\')) { $directoryGlob += '\' }; $directoryGlob )"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; <# Not using `Get-Acl`/`Set-Acl` to avoid adjusting token privileges #>; $parentDirectory = [System.IO.Path]::GetDirectoryName($expandedPath); $fileName = [System.IO.Path]::GetFileName($expandedPath); if ($parentDirectory -like '*[*?]*') {; throw "^""Unable to grant permissions to glob path parent directory: `"^""$parentDirectory`"^"", wildcards in parent directory are not supported by ``takeown`` and ``icacls``."^""; }; if (($fileName -ne '*') -and ($fileName -like '*[*?]*')) {; throw "^""Unable to grant permissions to glob path file name: `"^""$fileName`"^"", wildcards in file name is not supported by ``takeown`` and ``icacls``."^""; }; Write-Host "^""Taking ownership of `"^""$expandedPath`"^""."^""; $cmdPath = $expandedPath; if ($cmdPath.EndsWith('\')) {; $cmdPath += '\' <# Escape trailing backslash for correct handling in batch commands #>; }; $takeOwnershipCommand = "^""takeown /f `"^""$cmdPath`"^"" /a"^"" <# `icacls /setowner` does not succeed, so use `takeown` instead. #>; if (-not (Test-Path -Path "^""$expandedPath"^"" -PathType Leaf)) {; $localizedYes = 'Y' <# Default 'Yes' flag (fallback) #>; try {; $choiceOutput = cmd /c "^""choice <nul 2>nul"^""; if ($choiceOutput -and $choiceOutput.Length -ge 2) {; $localizedYes = $choiceOutput[1]; } else {; Write-Warning "^""Failed to determine localized 'Yes' character. Output: `"^""$choiceOutput`"^"""^""; }; } catch {; Write-Warning "^""Failed to determine localized 'Yes' character. Error: $_"^""; }; $takeOwnershipCommand += "^"" /r /d $localizedYes"^""; }; $takeOwnershipOutput = cmd /c "^""$takeOwnershipCommand 2>&1"^"" <# `stderr` message is misleading, e.g. "^""ERROR: The system cannot find the file specified."^"" is not an error. #>; if ($LASTEXITCODE -eq 0) {; Write-Host "^""Successfully took ownership of `"^""$expandedPath`"^"" (using ``$takeOwnershipCommand``)."^""; } else {; Write-Host "^""Did not take ownership of `"^""$expandedPath`"^"" using ``$takeOwnershipCommand``, status code: $LASTEXITCODE, message: $takeOwnershipOutput."^""; <# Do not write as error or warning, because this can be due to missing path, it's handled in next command. #>; <# `takeown` exits with status code `1`, making it hard to handle missing path here. #>; }; Write-Host "^""Granting permissions for `"^""$expandedPath`"^""."^""; $adminSid = New-Object System.Security.Principal.SecurityIdentifier 'S-1-5-32-544'; $adminAccount = $adminSid.Translate([System.Security.Principal.NTAccount]); $adminAccountName = $adminAccount.Value; $grantPermissionsCommand = "^""icacls `"^""$cmdPath`"^"" /grant `"^""$($adminAccountName):F`"^"" /t"^""; $icaclsOutput = cmd /c "^""$grantPermissionsCommand"^""; if ($LASTEXITCODE -eq 3) {; Write-Host "^""Skipping, no items available for deletion according to: ``$grantPermissionsCommand``."^""; exit 0; } elseif ($LASTEXITCODE -ne 0) {; Write-Host "^""Take ownership message:`n$takeOwnershipOutput"^""; Write-Host "^""Grant permissions:`n$icaclsOutput"^""; Write-Warning "^""Failed to assign permissions for `"^""$expandedPath`"^"" using ``$grantPermissionsCommand``, status code: $LASTEXITCODE."^""; } else {; $fileStats = $icaclsOutput | ForEach-Object { $_ -match '\d+' | Out-Null; $matches[0] } | Where-Object { $_ -ne $null } | ForEach-Object { [int]$_ }; if ($fileStats.Count -gt 0 -and ($fileStats | ForEach-Object { $_ -eq 0 } | Where-Object { $_ -eq $false }).Count -eq 0) {; Write-Host "^""Skipping, no items available for deletion according to: ``$grantPermissionsCommand``."^""; exit 0; } else {; Write-Host "^""Successfully granted permissions for `"^""$expandedPath`"^"" (using ``$grantPermissionsCommand``)."^""; }; }; $deletedCount = 0; $failedCount = 0; $foundAbsolutePaths = @(); Write-Host 'Iterating files and directories recursively.'; try {; $foundAbsolutePaths += @(; Get-ChildItem -Path $expandedPath -Force -Recurse -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (-not (Test-Path $path)) { <# Re-check existence as prior deletions might remove subsequent items (e.g., subdirectories). #>; Write-Host "^""Successfully deleted: $($path) (already deleted)."^""; $deletedCount++; continue; }; try {; Remove-Item -Path $path -Force -Recurse -ErrorAction Stop; $deletedCount++; Write-Host "^""Successfully deleted: $($path)"^""; } catch {; $failedCount++; Write-Warning "^""Unable to delete $($path): $_"^""; }; }; Write-Host "^""Successfully deleted $($deletedCount) items."^""; if ($failedCount -gt 0) {; Write-Warning "^""Failed to delete $($failedCount) items."^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----Clear System Resource Usage Monitor (SRUM) data------
:: ----------------------------------------------------------
echo --- Clear System Resource Usage Monitor (SRUM) data
:: Stop service: DPS (with state flag) (wait until stopped)
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'DPS'; Write-Host "^""Stopping service: `"^""$serviceName`"^""."^""; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if (!$service) {; Write-Host "^""Skipping, service `"^""$serviceName`"^"" could not be not found, no need to stop it."^""; exit 0; }; if ($service.Status -ne [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""Skipping, `"^""$serviceName`"^"" is not running, no need to stop."^""; exit 0; }; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; $service | Stop-Service -Force -ErrorAction Stop; $service.WaitForStatus([System.ServiceProcess.ServiceControllerStatus]::Stopped); } catch {; throw "^""Failed to stop the service `"^""$serviceName`"^"": $_"^""; }; Write-Host "^""Successfully stopped the service: `"^""$serviceName`"^""."^""; $stateFilePath = '%APPDATA%\privacy.sexy-DPS'; $expandedStateFilePath = [System.Environment]::ExpandEnvironmentVariables($stateFilePath); if (Test-Path -Path $expandedStateFilePath) {; Write-Host "^""Skipping creating a service state file, it already exists: `"^""$expandedStateFilePath`"^""."^""; } else {; <# Ensure the directory exists #>; $parentDirectory = [System.IO.Path]::GetDirectoryName($expandedStateFilePath); if (-not (Test-Path $parentDirectory -PathType Container)) {; try {; New-Item -ItemType Directory -Path $parentDirectory -Force -ErrorAction Stop | Out-Null; }  catch {; Write-Warning "^""Failed to create parent directory of service state file `"^""$parentDirectory`"^"": $_"^""; }; }; <# Create the state file #>; try {; New-Item -ItemType File -Path $expandedStateFilePath -Force -ErrorAction Stop | Out-Null; Write-Host 'The service will be started again.'; } catch {; Write-Warning "^""Failed to create service state file `"^""$expandedStateFilePath`"^"": $_"^""; }; }"
:: Delete files matching pattern: "%WINDIR%\System32\sru\SRUDB.dat"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""%WINDIR%\System32\sru\SRUDB.dat"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; <# Not using `Get-Acl`/`Set-Acl` to avoid adjusting token privileges #>; $parentDirectory = [System.IO.Path]::GetDirectoryName($expandedPath); $fileName = [System.IO.Path]::GetFileName($expandedPath); if ($parentDirectory -like '*[*?]*') {; throw "^""Unable to grant permissions to glob path parent directory: `"^""$parentDirectory`"^"", wildcards in parent directory are not supported by ``takeown`` and ``icacls``."^""; }; if (($fileName -ne '*') -and ($fileName -like '*[*?]*')) {; throw "^""Unable to grant permissions to glob path file name: `"^""$fileName`"^"", wildcards in file name is not supported by ``takeown`` and ``icacls``."^""; }; Write-Host "^""Taking ownership of `"^""$expandedPath`"^""."^""; $cmdPath = $expandedPath; if ($cmdPath.EndsWith('\')) {; $cmdPath += '\' <# Escape trailing backslash for correct handling in batch commands #>; }; $takeOwnershipCommand = "^""takeown /f `"^""$cmdPath`"^"" /a"^"" <# `icacls /setowner` does not succeed, so use `takeown` instead. #>; if (-not (Test-Path -Path "^""$expandedPath"^"" -PathType Leaf)) {; $localizedYes = 'Y' <# Default 'Yes' flag (fallback) #>; try {; $choiceOutput = cmd /c "^""choice <nul 2>nul"^""; if ($choiceOutput -and $choiceOutput.Length -ge 2) {; $localizedYes = $choiceOutput[1]; } else {; Write-Warning "^""Failed to determine localized 'Yes' character. Output: `"^""$choiceOutput`"^"""^""; }; } catch {; Write-Warning "^""Failed to determine localized 'Yes' character. Error: $_"^""; }; $takeOwnershipCommand += "^"" /r /d $localizedYes"^""; }; $takeOwnershipOutput = cmd /c "^""$takeOwnershipCommand 2>&1"^"" <# `stderr` message is misleading, e.g. "^""ERROR: The system cannot find the file specified."^"" is not an error. #>; if ($LASTEXITCODE -eq 0) {; Write-Host "^""Successfully took ownership of `"^""$expandedPath`"^"" (using ``$takeOwnershipCommand``)."^""; } else {; Write-Host "^""Did not take ownership of `"^""$expandedPath`"^"" using ``$takeOwnershipCommand``, status code: $LASTEXITCODE, message: $takeOwnershipOutput."^""; <# Do not write as error or warning, because this can be due to missing path, it's handled in next command. #>; <# `takeown` exits with status code `1`, making it hard to handle missing path here. #>; }; Write-Host "^""Granting permissions for `"^""$expandedPath`"^""."^""; $adminSid = New-Object System.Security.Principal.SecurityIdentifier 'S-1-5-32-544'; $adminAccount = $adminSid.Translate([System.Security.Principal.NTAccount]); $adminAccountName = $adminAccount.Value; $grantPermissionsCommand = "^""icacls `"^""$cmdPath`"^"" /grant `"^""$($adminAccountName):F`"^"" /t"^""; $icaclsOutput = cmd /c "^""$grantPermissionsCommand"^""; if ($LASTEXITCODE -eq 3) {; Write-Host "^""Skipping, no items available for deletion according to: ``$grantPermissionsCommand``."^""; exit 0; } elseif ($LASTEXITCODE -ne 0) {; Write-Host "^""Take ownership message:`n$takeOwnershipOutput"^""; Write-Host "^""Grant permissions:`n$icaclsOutput"^""; Write-Warning "^""Failed to assign permissions for `"^""$expandedPath`"^"" using ``$grantPermissionsCommand``, status code: $LASTEXITCODE."^""; } else {; $fileStats = $icaclsOutput | ForEach-Object { $_ -match '\d+' | Out-Null; $matches[0] } | Where-Object { $_ -ne $null } | ForEach-Object { [int]$_ }; if ($fileStats.Count -gt 0 -and ($fileStats | ForEach-Object { $_ -eq 0 } | Where-Object { $_ -eq $false }).Count -eq 0) {; Write-Host "^""Skipping, no items available for deletion according to: ``$grantPermissionsCommand``."^""; exit 0; } else {; Write-Host "^""Successfully granted permissions for `"^""$expandedPath`"^"" (using ``$grantPermissionsCommand``)."^""; }; }; $deletedCount = 0; $failedCount = 0; $skippedCount = 0; $foundAbsolutePaths = @(); try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (Test-Path -Path $path -PathType Container) {; Write-Host "^""Skipping, the path is not a file but a folder: $($path)."^""; $skippedCount++; continue; }; if (-not (Test-Path $path)) { <# Re-check existence as prior deletions might remove subsequent items (e.g., subdirectories). #>; Write-Host "^""Successfully deleted: $($path) (already deleted)."^""; $deletedCount++; continue; }; try {; Remove-Item -Path $path -Force -Recurse -ErrorAction Stop; $deletedCount++; Write-Host "^""Successfully deleted: $($path)"^""; } catch {; $failedCount++; Write-Warning "^""Unable to delete $($path): $_"^""; }; }; if ($skippedCount -gt 0) {; Write-Host "^""Skipped $($skippedCount) items."^""; }; Write-Host "^""Successfully deleted $($deletedCount) items."^""; if ($failedCount -gt 0) {; Write-Warning "^""Failed to delete $($failedCount) items."^""; }"
:: Start service: DPS (with state flag)
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'DPS'; $stateFilePath = '%APPDATA%\privacy.sexy-DPS'; $expandedStateFilePath = [System.Environment]::ExpandEnvironmentVariables($stateFilePath); if (-not (Test-Path -Path $expandedStateFilePath)) {; Write-Host "^""Skipping starting the service: It was not running before."^""; } else {; try {; Remove-Item -Path $expandedStateFilePath -Force -ErrorAction Stop; Write-Host 'The service is expected to be started.'; } catch {; Write-Warning "^""Failed to delete the service state file `"^""$expandedStateFilePath`"^"": $_"^""; }; }; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if (!$service) {; throw "^""Failed to start service `"^""$serviceName`"^"": Service not found."^""; }; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""Skipping, `"^""$serviceName`"^"" is already running, no need to start."^""; exit 0; }; Write-Host "^""`"^""$serviceName`"^"" is not running, starting it."^""; try {; $service | Start-Service -ErrorAction Stop; Write-Host "^""Successfully started the service: `"^""$serviceName`"^""."^""; } catch {; Write-Warning "^""Failed to start the service: `"^""$serviceName`"^""."^""; exit 1; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --------------Clear temporary system folder---------------
:: ----------------------------------------------------------
echo --- Clear temporary system folder
:: Clear directory contents  : "%WINDIR%\Temp"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""$($directoryGlob = '%WINDIR%\Temp'; if ($directoryGlob.EndsWith('\*')) { $directoryGlob } elseif ($directoryGlob.EndsWith('\')) { "^""$($directoryGlob)*"^"" } else { "^""$($directoryGlob)\*"^"" } )"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $deletedCount = 0; $failedCount = 0; $foundAbsolutePaths = @(); Write-Host 'Iterating files and directories recursively.'; try {; $foundAbsolutePaths += @(; Get-ChildItem -Path $expandedPath -Force -Recurse -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (-not (Test-Path $path)) { <# Re-check existence as prior deletions might remove subsequent items (e.g., subdirectories). #>; Write-Host "^""Successfully deleted: $($path) (already deleted)."^""; $deletedCount++; continue; }; try {; Remove-Item -Path $path -Force -Recurse -ErrorAction Stop; $deletedCount++; Write-Host "^""Successfully deleted: $($path)"^""; } catch {; $failedCount++; Write-Warning "^""Unable to delete $($path): $_"^""; }; }; Write-Host "^""Successfully deleted $($deletedCount) items."^""; if ($failedCount -gt 0) {; Write-Warning "^""Failed to delete $($failedCount) items."^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ---------------Clear temporary user folder----------------
:: ----------------------------------------------------------
echo --- Clear temporary user folder
:: Clear directory contents  : "%TEMP%"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""$($directoryGlob = '%TEMP%'; if ($directoryGlob.EndsWith('\*')) { $directoryGlob } elseif ($directoryGlob.EndsWith('\')) { "^""$($directoryGlob)*"^"" } else { "^""$($directoryGlob)\*"^"" } )"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $deletedCount = 0; $failedCount = 0; $foundAbsolutePaths = @(); Write-Host 'Iterating files and directories recursively.'; try {; $foundAbsolutePaths += @(; Get-ChildItem -Path $expandedPath -Force -Recurse -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (-not (Test-Path $path)) { <# Re-check existence as prior deletions might remove subsequent items (e.g., subdirectories). #>; Write-Host "^""Successfully deleted: $($path) (already deleted)."^""; $deletedCount++; continue; }; try {; Remove-Item -Path $path -Force -Recurse -ErrorAction Stop; $deletedCount++; Write-Host "^""Successfully deleted: $($path)"^""; } catch {; $failedCount++; Write-Warning "^""Unable to delete $($path): $_"^""; }; }; Write-Host "^""Successfully deleted $($deletedCount) items."^""; if ($failedCount -gt 0) {; Write-Warning "^""Failed to delete $($failedCount) items."^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ------------------Clear prefetch folder-------------------
:: ----------------------------------------------------------
echo --- Clear prefetch folder
:: Clear directory contents  : "%WINDIR%\Prefetch"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""$($directoryGlob = '%WINDIR%\Prefetch'; if ($directoryGlob.EndsWith('\*')) { $directoryGlob } elseif ($directoryGlob.EndsWith('\')) { "^""$($directoryGlob)*"^"" } else { "^""$($directoryGlob)\*"^"" } )"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $deletedCount = 0; $failedCount = 0; $foundAbsolutePaths = @(); Write-Host 'Iterating files and directories recursively.'; try {; $foundAbsolutePaths += @(; Get-ChildItem -Path $expandedPath -Force -Recurse -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (-not (Test-Path $path)) { <# Re-check existence as prior deletions might remove subsequent items (e.g., subdirectories). #>; Write-Host "^""Successfully deleted: $($path) (already deleted)."^""; $deletedCount++; continue; }; try {; Remove-Item -Path $path -Force -Recurse -ErrorAction Stop; $deletedCount++; Write-Host "^""Successfully deleted: $($path)"^""; } catch {; $failedCount++; Write-Warning "^""Unable to delete $($path): $_"^""; }; }; Write-Host "^""Successfully deleted $($deletedCount) items."^""; if ($failedCount -gt 0) {; Write-Warning "^""Failed to delete $($failedCount) items."^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ------------Clear recently accessed files list------------
:: ----------------------------------------------------------
echo --- Clear recently accessed files list
:: Clear directory contents  : "%APPDATA%\Microsoft\Windows\Recent\AutomaticDestinations"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""$($directoryGlob = '%APPDATA%\Microsoft\Windows\Recent\AutomaticDestinations'; if ($directoryGlob.EndsWith('\*')) { $directoryGlob } elseif ($directoryGlob.EndsWith('\')) { "^""$($directoryGlob)*"^"" } else { "^""$($directoryGlob)\*"^"" } )"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $deletedCount = 0; $failedCount = 0; $foundAbsolutePaths = @(); Write-Host 'Iterating files and directories recursively.'; try {; $foundAbsolutePaths += @(; Get-ChildItem -Path $expandedPath -Force -Recurse -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (-not (Test-Path $path)) { <# Re-check existence as prior deletions might remove subsequent items (e.g., subdirectories). #>; Write-Host "^""Successfully deleted: $($path) (already deleted)."^""; $deletedCount++; continue; }; try {; Remove-Item -Path $path -Force -Recurse -ErrorAction Stop; $deletedCount++; Write-Host "^""Successfully deleted: $($path)"^""; } catch {; $failedCount++; Write-Warning "^""Unable to delete $($path): $_"^""; }; }; Write-Host "^""Successfully deleted $($deletedCount) items."^""; if ($failedCount -gt 0) {; Write-Warning "^""Failed to delete $($failedCount) items."^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -------------Clear pinned items for the user--------------
:: ----------------------------------------------------------
echo --- Clear pinned items for the user
:: Clear directory contents  : "%APPDATA%\Microsoft\Windows\Recent\CustomDestinations"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""$($directoryGlob = '%APPDATA%\Microsoft\Windows\Recent\CustomDestinations'; if ($directoryGlob.EndsWith('\*')) { $directoryGlob } elseif ($directoryGlob.EndsWith('\')) { "^""$($directoryGlob)*"^"" } else { "^""$($directoryGlob)\*"^"" } )"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $deletedCount = 0; $failedCount = 0; $foundAbsolutePaths = @(); Write-Host 'Iterating files and directories recursively.'; try {; $foundAbsolutePaths += @(; Get-ChildItem -Path $expandedPath -Force -Recurse -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (-not (Test-Path $path)) { <# Re-check existence as prior deletions might remove subsequent items (e.g., subdirectories). #>; Write-Host "^""Successfully deleted: $($path) (already deleted)."^""; $deletedCount++; continue; }; try {; Remove-Item -Path $path -Force -Recurse -ErrorAction Stop; $deletedCount++; Write-Host "^""Successfully deleted: $($path)"^""; } catch {; $failedCount++; Write-Warning "^""Unable to delete $($path): $_"^""; }; }; Write-Host "^""Successfully deleted $($deletedCount) items."^""; if ($failedCount -gt 0) {; Write-Warning "^""Failed to delete $($failedCount) items."^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----------------Clear last `regedit` key-----------------
:: ----------------------------------------------------------
echo --- Clear last `regedit` key
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit" /va /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Applets\Regedit" /va /f
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -------------Clear favorite keys in `regedit`-------------
:: ----------------------------------------------------------
echo --- Clear favorite keys in `regedit`
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit\Favorites" /va /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Applets\Regedit\Favorites" /va /f
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ---------Clear recently opened applications list----------
:: ----------------------------------------------------------
echo --- Clear recently opened applications list
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\LastVisitedPidlMRU" /va /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\LastVisitedPidlMRULegacy" /va /f
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: Clear "Adobe Media Browser" most recently used (MRU) list-
:: ----------------------------------------------------------
echo --- Clear "Adobe Media Browser" most recently used (MRU) list
reg delete "HKCU\Software\Adobe\MediaBrowser\MRU" /va /f
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ------Clear "MSPaint" most recently used (MRU) list-------
:: ----------------------------------------------------------
echo --- Clear "MSPaint" most recently used (MRU) list
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\Paint\Recent File List" /va /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Applets\Paint\Recent File List" /va /f
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ------Clear "Wordpad" most recently used (MRU) list-------
:: ----------------------------------------------------------
echo --- Clear "Wordpad" most recently used (MRU) list
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Applets\Wordpad\Recent File List" /va /f
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -Clear "Map Network Drive" most recently used (MRU) list--
:: ----------------------------------------------------------
echo --- Clear "Map Network Drive" most recently used (MRU) list
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Map Network Drive MRU" /va /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Map Network Drive MRU" /va /f
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ---------Clear "Windows Search Assistant" history---------
:: ----------------------------------------------------------
echo --- Clear "Windows Search Assistant" history
reg delete "HKCU\Software\Microsoft\Search Assistant\ACMru" /va /f
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ---Clear recently opened files list for each file type----
:: ----------------------------------------------------------
echo --- Clear recently opened files list for each file type
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs" /va /f
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs" /va /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\OpenSaveMRU" /va /f
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----Clear Windows Media Player recent files and URLs-----
:: ----------------------------------------------------------
echo --- Clear Windows Media Player recent files and URLs
reg delete "HKCU\Software\Microsoft\MediaPlayer\Player\RecentFileList" /va /f
reg delete "HKCU\Software\Microsoft\MediaPlayer\Player\RecentURLList" /va /f
reg delete "HKLM\SOFTWARE\Microsoft\MediaPlayer\Player\RecentFileList" /va /f
reg delete "HKLM\SOFTWARE\Microsoft\MediaPlayer\Player\RecentURLList" /va /f
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -------Clear most recent DirectX application usage--------
:: ----------------------------------------------------------
echo --- Clear most recent DirectX application usage
reg delete "HKCU\Software\Microsoft\Direct3D\MostRecentApplication" /va /f
reg delete "HKLM\SOFTWARE\Microsoft\Direct3D\MostRecentApplication" /va /f
:: ----------------------------------------------------------


:: Clear "Windows Run" most recently used (MRU) list and typed paths
echo --- Clear "Windows Run" most recently used (MRU) list and typed paths
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU" /va /f
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\TypedPaths" /va /f
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ---------Disable app access to "Documents" folder---------
:: ----------------------------------------------------------
echo --- Disable app access to "Documents" folder
:: Disable app capability (documentsLibrary) using user privacy settings
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary" /v "Value" /d "Deny" /t REG_SZ /f
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ---------Disable app access to "Pictures" folder----------
:: ----------------------------------------------------------
echo --- Disable app access to "Pictures" folder
:: Disable app capability (picturesLibrary) using user privacy settings
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\picturesLibrary" /v "Value" /d "Deny" /t REG_SZ /f
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----------Disable app access to "Videos" folder-----------
:: ----------------------------------------------------------
echo --- Disable app access to "Videos" folder
:: Disable app capability (videosLibrary) using user privacy settings
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary" /v "Value" /d "Deny" /t REG_SZ /f
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----------Disable app access to "Music" folder-----------
:: ----------------------------------------------------------
echo --- Disable app access to "Music" folder
:: Disable app capability (musicLibrary) using user privacy settings
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\musicLibrary" /v "Value" /d "Deny" /t REG_SZ /f
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----------Disable app access to personal files-----------
:: ----------------------------------------------------------
echo --- Disable app access to personal files
:: Disable app capability (broadFileSystemAccess) using user privacy settings
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess" /v "Value" /d "Deny" /t REG_SZ /f
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ------------Disable app access to call history------------
:: ----------------------------------------------------------
echo --- Disable app access to call history
:: Disable app access (LetAppsAccessCallHistory) using GPO (re-activation through GUI is not possible)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessCallHistory' /t 'REG_DWORD' /d '2' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessCallHistory_UserInControlOfTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessCallHistory_ForceAllowTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessCallHistory_ForceDenyTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
:: Disable app capability (phoneCallHistory) using user privacy settings
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCallHistory" /v "Value" /d "Deny" /t REG_SZ /f
:: Disable app access ({8BC668CF-7728-45BD-93F8-CF2B3B41D7AB}) in older Windows versions (before 1903)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{8BC668CF-7728-45BD-93F8-CF2B3B41D7AB}' /v 'Value' /t 'REG_SZ' /d 'Deny' /f"
:: ----------------------------------------------------------


:: Disable app access to phone calls (breaks phone calls through Phone Link)
echo --- Disable app access to phone calls (breaks phone calls through Phone Link)
:: Disable app access (LetAppsAccessPhone) using GPO (re-activation through GUI is not possible)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessPhone' /t 'REG_DWORD' /d '2' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessPhone_UserInControlOfTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessPhone_ForceAllowTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessPhone_ForceDenyTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
:: Disable app capability (phoneCall) using user privacy settings
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCall" /v "Value" /d "Deny" /t REG_SZ /f
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -------Disable app access to messaging (SMS / MMS)--------
:: ----------------------------------------------------------
echo --- Disable app access to messaging (SMS / MMS)
:: Disable app access (LetAppsAccessMessaging) using GPO (re-activation through GUI is not possible)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessMessaging' /t 'REG_DWORD' /d '2' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessMessaging_UserInControlOfTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessMessaging_ForceAllowTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessMessaging_ForceDenyTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
:: Disable app capability (chat) using user privacy settings
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chat" /v "Value" /d "Deny" /t REG_SZ /f
:: Disable app access ({992AFA70-6F47-4148-B3E9-3003349C1548}) in older Windows versions (before 1903)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{992AFA70-6F47-4148-B3E9-3003349C1548}' /v 'Value' /t 'REG_SZ' /d 'Deny' /f"
:: Disable app access ({21157C1F-2651-4CC1-90CA-1F28B02263F6}) in older Windows versions (before 1903)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{21157C1F-2651-4CC1-90CA-1F28B02263F6}' /v 'Value' /t 'REG_SZ' /d 'Deny' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ------Disable app access to paired Bluetooth devices------
:: ----------------------------------------------------------
echo --- Disable app access to paired Bluetooth devices
:: Disable app capability (bluetooth) using user privacy settings
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetooth" /v "Value" /d "Deny" /t REG_SZ /f
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----Disable app access to unpaired Bluetooth devices-----
:: ----------------------------------------------------------
echo --- Disable app access to unpaired Bluetooth devices
:: Disable app capability (bluetoothSync) using user privacy settings
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync" /v "Value" /d "Deny" /t REG_SZ /f
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----------Disable app access to voice activation----------
:: ----------------------------------------------------------
echo --- Disable app access to voice activation
:: Disable app access (LetAppsActivateWithVoice) using GPO (re-activation through GUI is not possible)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsActivateWithVoice' /t 'REG_DWORD' /d '2' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsActivateWithVoice_UserInControlOfTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsActivateWithVoice_ForceAllowTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsActivateWithVoice_ForceDenyTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\Software\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps' /v 'AgentActivationEnabled' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -Disable app access to voice activation on locked system--
:: ----------------------------------------------------------
echo --- Disable app access to voice activation on locked system
:: Disable app access (LetAppsActivateWithVoiceAboveLock) using GPO (re-activation through GUI is not possible)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsActivateWithVoiceAboveLock' /t 'REG_DWORD' /d '2' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsActivateWithVoiceAboveLock_UserInControlOfTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsActivateWithVoiceAboveLock_ForceAllowTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsActivateWithVoiceAboveLock_ForceDenyTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\Software\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps' /v 'AgentActivationOnLockScreenEnabled' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --------------Disable app access to location--------------
:: ----------------------------------------------------------
echo --- Disable app access to location
:: Disable app access (LetAppsAccessLocation) using GPO (re-activation through GUI is not possible)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessLocation' /t 'REG_DWORD' /d '2' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessLocation_UserInControlOfTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessLocation_ForceAllowTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessLocation_ForceDenyTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
:: Disable app capability (location) using user privacy settings
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v "Value" /d "Deny" /t REG_SZ /f
:: Disable "Location Services"
reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" /v "Status" /d "0" /t REG_DWORD /f
:: Disable app access ({BFA794E4-F964-4FDB-90F6-51056BFE4B44}) in older Windows versions (before 1903)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}' /v 'Value' /t 'REG_SZ' /d 'Deny' /f"
:: Disable app access ({E6AD100E-5F4E-44CD-BE0F-2265D88D14F5}) in older Windows versions (before 1903)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E6AD100E-5F4E-44CD-BE0F-2265D88D14F5}' /v 'Value' /t 'REG_SZ' /d 'Deny' /f"
:: ----------------------------------------------------------


:: Disable app access to account information, name, and picture
echo --- Disable app access to account information, name, and picture
:: Disable app access (LetAppsAccessAccountInfo) using GPO (re-activation through GUI is not possible)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessAccountInfo' /t 'REG_DWORD' /d '2' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessAccountInfo_UserInControlOfTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessAccountInfo_ForceAllowTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessAccountInfo_ForceDenyTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
:: Disable app capability (userAccountInformation) using user privacy settings
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" /v "Value" /d "Deny" /t REG_SZ /f
:: Disable app access ({C1D23ACC-752B-43E5-8448-8D0E519CD6D6}) in older Windows versions (before 1903)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{C1D23ACC-752B-43E5-8448-8D0E519CD6D6}' /v 'Value' /t 'REG_SZ' /d 'Deny' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----------Disable app access to motion activity-----------
:: ----------------------------------------------------------
echo --- Disable app access to motion activity
:: Disable app access (LetAppsAccessMotion) using GPO (re-activation through GUI is not possible)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessMotion' /t 'REG_DWORD' /d '2' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessMotion_UserInControlOfTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessMotion_ForceAllowTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessMotion_ForceDenyTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
:: Disable app capability (activity) using user privacy settings
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\activity" /v "Value" /d "Deny" /t REG_SZ /f
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----------Disable app access to trusted devices-----------
:: ----------------------------------------------------------
echo --- Disable app access to trusted devices
:: Disable app access (LetAppsAccessTrustedDevices) using GPO (re-activation through GUI is not possible)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessTrustedDevices' /t 'REG_DWORD' /d '2' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessTrustedDevices_UserInControlOfTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessTrustedDevices_ForceAllowTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessTrustedDevices_ForceDenyTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----Disable app access to unpaired wireless devices------
:: ----------------------------------------------------------
echo --- Disable app access to unpaired wireless devices
:: Disable app access (LetAppsSyncWithDevices) using GPO (re-activation through GUI is not possible)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsSyncWithDevices' /t 'REG_DWORD' /d '2' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsSyncWithDevices_UserInControlOfTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsSyncWithDevices_ForceAllowTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsSyncWithDevices_ForceDenyTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
:: Disable app access (LooselyCoupled) in older Windows versions (before 1903)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\LooselyCoupled' /v 'Value' /t 'REG_SZ' /d 'Deny' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ---------------Disable app access to camera---------------
:: ----------------------------------------------------------
echo --- Disable app access to camera
:: Disable app access (LetAppsAccessCamera) using GPO (re-activation through GUI is not possible)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessCamera' /t 'REG_DWORD' /d '2' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessCamera_UserInControlOfTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessCamera_ForceAllowTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessCamera_ForceDenyTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
:: Disable app capability (webcam) using user privacy settings
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam" /v "Value" /d "Deny" /t REG_SZ /f
:: Disable app access ({E5323777-F976-4f5b-9B55-B94699C46E44}) in older Windows versions (before 1903)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E5323777-F976-4f5b-9B55-B94699C46E44}' /v 'Value' /t 'REG_SZ' /d 'Deny' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -Disable app access to microphone (breaks Sound Recorder)-
:: ----------------------------------------------------------
echo --- Disable app access to microphone (breaks Sound Recorder)
:: Disable app access (LetAppsAccessMicrophone) using GPO (re-activation through GUI is not possible)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessMicrophone' /t 'REG_DWORD' /d '2' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessMicrophone_UserInControlOfTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessMicrophone_ForceAllowTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessMicrophone_ForceDenyTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
:: Disable app capability (microphone) using user privacy settings
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" /v "Value" /d "Deny" /t REG_SZ /f
:: Disable app access ({2EEF81BE-33FA-4800-9670-1CD474972C3F}) in older Windows versions (before 1903)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{2EEF81BE-33FA-4800-9670-1CD474972C3F}' /v 'Value' /t 'REG_SZ' /d 'Deny' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----Disable app access to information about other apps----
:: ----------------------------------------------------------
echo --- Disable app access to information about other apps
:: Disable app access (LetAppsGetDiagnosticInfo) using GPO (re-activation through GUI is not possible)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsGetDiagnosticInfo' /t 'REG_DWORD' /d '2' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsGetDiagnosticInfo_UserInControlOfTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsGetDiagnosticInfo_ForceAllowTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsGetDiagnosticInfo_ForceDenyTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
:: Disable app capability (appDiagnostics) using user privacy settings
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" /v "Value" /d "Deny" /t REG_SZ /f
:: Disable app access ({2297E4E2-5DBE-466D-A12B-0F8286F0D9CA}) in older Windows versions (before 1903)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{2297E4E2-5DBE-466D-A12B-0F8286F0D9CA}' /v 'Value' /t 'REG_SZ' /d 'Deny' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----------Disable app access to your contacts------------
:: ----------------------------------------------------------
echo --- Disable app access to your contacts
:: Disable app access (LetAppsAccessContacts) using GPO (re-activation through GUI is not possible)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessContacts' /t 'REG_DWORD' /d '2' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessContacts_UserInControlOfTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessContacts_ForceAllowTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessContacts_ForceDenyTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
:: Disable app capability (contacts) using user privacy settings
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts" /v "Value" /d "Deny" /t REG_SZ /f
:: Disable app access ({7D7E8402-7C54-4821-A34E-AEEFD62DED93}) in older Windows versions (before 1903)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{7D7E8402-7C54-4821-A34E-AEEFD62DED93}' /v 'Value' /t 'REG_SZ' /d 'Deny' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----------Disable app access to notifications------------
:: ----------------------------------------------------------
echo --- Disable app access to notifications
:: Disable app access (LetAppsAccessNotifications) using GPO (re-activation through GUI is not possible)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessNotifications' /t 'REG_DWORD' /d '2' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessNotifications_UserInControlOfTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessNotifications_ForceAllowTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessNotifications_ForceDenyTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
:: Disable app capability (userNotificationListener) using user privacy settings
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userNotificationListener" /v "Value" /d "Deny" /t REG_SZ /f
:: Disable app access ({52079E78-A92B-413F-B213-E8FE35712E72}) in older Windows versions (before 1903)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{52079E78-A92B-413F-B213-E8FE35712E72}' /v 'Value' /t 'REG_SZ' /d 'Deny' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --------------Disable app access to calendar--------------
:: ----------------------------------------------------------
echo --- Disable app access to calendar
:: Disable app access (LetAppsAccessCalendar) using GPO (re-activation through GUI is not possible)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessCalendar' /t 'REG_DWORD' /d '2' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessCalendar_UserInControlOfTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessCalendar_ForceAllowTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessCalendar_ForceDenyTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
:: Disable app capability (appointments) using user privacy settings
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments" /v "Value" /d "Deny" /t REG_SZ /f
:: Disable app access ({D89823BA-7180-4B81-B50C-7E471E6121A3}) in older Windows versions (before 1903)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{D89823BA-7180-4B81-B50C-7E471E6121A3}' /v 'Value' /t 'REG_SZ' /d 'Deny' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ---------------Disable app access to email----------------
:: ----------------------------------------------------------
echo --- Disable app access to email
:: Disable app access (LetAppsAccessEmail) using GPO (re-activation through GUI is not possible)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessEmail' /t 'REG_DWORD' /d '2' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessEmail_UserInControlOfTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessEmail_ForceAllowTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessEmail_ForceDenyTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
:: Disable app capability (email) using user privacy settings
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email" /v "Value" /d "Deny" /t REG_SZ /f
:: Disable app access ({9231CB4C-BF57-4AF3-8C55-FDA7BFCC04C5}) in older Windows versions (before 1903)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{9231CB4C-BF57-4AF3-8C55-FDA7BFCC04C5}' /v 'Value' /t 'REG_SZ' /d 'Deny' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ---------------Disable app access to tasks----------------
:: ----------------------------------------------------------
echo --- Disable app access to tasks
:: Disable app access (LetAppsAccessTasks) using GPO (re-activation through GUI is not possible)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessTasks' /t 'REG_DWORD' /d '2' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessTasks_UserInControlOfTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessTasks_ForceAllowTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessTasks_ForceDenyTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
:: Disable app capability (userDataTasks) using user privacy settings
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks" /v "Value" /d "Deny" /t REG_SZ /f
:: Disable app access ({E390DF20-07DF-446D-B962-F5C953062741}) in older Windows versions (before 1903)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E390DF20-07DF-446D-B962-F5C953062741}' /v 'Value' /t 'REG_SZ' /d 'Deny' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ---------------Disable app access to radios---------------
:: ----------------------------------------------------------
echo --- Disable app access to radios
:: Disable app access (LetAppsAccessRadios) using GPO (re-activation through GUI is not possible)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessRadios' /t 'REG_DWORD' /d '2' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessRadios_UserInControlOfTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessRadios_ForceAllowTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessRadios_ForceDenyTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
:: Disable app capability (radios) using user privacy settings
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios" /v "Value" /d "Deny" /t REG_SZ /f
:: Disable app access ({A8804298-2D5F-42E3-9531-9C8C39EB29CE}) in older Windows versions (before 1903)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{A8804298-2D5F-42E3-9531-9C8C39EB29CE}' /v 'Value' /t 'REG_SZ' /d 'Deny' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ---------Disable app access to physical movement----------
:: ----------------------------------------------------------
echo --- Disable app access to physical movement
:: Disable app access (LetAppsAccessBackgroundSpatialPerception) using GPO (re-activation through GUI is not possible)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessBackgroundSpatialPerception' /t 'REG_DWORD' /d '2' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessBackgroundSpatialPerception_UserInControlOfTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessBackgroundSpatialPerception_ForceAllowTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessBackgroundSpatialPerception_ForceDenyTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
:: Disable app capability (spatialPerception) using user privacy settings
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\spatialPerception" /v "Value" /d "Deny" /t REG_SZ /f
:: Disable app capability (backgroundSpatialPerception) using user privacy settings
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\backgroundSpatialPerception" /v "Value" /d "Deny" /t REG_SZ /f
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ------------Disable app access to eye tracking------------
:: ----------------------------------------------------------
echo --- Disable app access to eye tracking
:: Disable app access (LetAppsAccessGazeInput) using GPO (re-activation through GUI is not possible)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessGazeInput' /t 'REG_DWORD' /d '2' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessGazeInput_UserInControlOfTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessGazeInput_ForceAllowTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessGazeInput_ForceDenyTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
:: Disable app capability (gazeInput) using user privacy settings
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\gazeInput" /v "Value" /d "Deny" /t REG_SZ /f
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----------Disable app access to human presence-----------
:: ----------------------------------------------------------
echo --- Disable app access to human presence
:: Disable app access (LetAppsAccessHumanPresence) using GPO (re-activation through GUI is not possible)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessHumanPresence' /t 'REG_DWORD' /d '2' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessHumanPresence_UserInControlOfTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessHumanPresence_ForceAllowTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessHumanPresence_ForceDenyTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
:: Disable app capability (humanPresence) using user privacy settings
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\humanPresence" /v "Value" /d "Deny" /t REG_SZ /f
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----------Disable app access to screen capture-----------
:: ----------------------------------------------------------
echo --- Disable app access to screen capture
:: Disable app access (LetAppsAccessGraphicsCaptureProgrammatic) using GPO (re-activation through GUI is not possible)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessGraphicsCaptureProgrammatic' /t 'REG_DWORD' /d '2' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessGraphicsCaptureProgrammatic_UserInControlOfTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessGraphicsCaptureProgrammatic_ForceAllowTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessGraphicsCaptureProgrammatic_ForceDenyTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
:: Disable app capability (graphicsCaptureProgrammatic) using user privacy settings
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\graphicsCaptureProgrammatic" /v "Value" /d "Deny" /t REG_SZ /f
:: Disable app access (LetAppsAccessGraphicsCaptureWithoutBorder) using GPO (re-activation through GUI is not possible)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessGraphicsCaptureWithoutBorder' /t 'REG_DWORD' /d '2' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessGraphicsCaptureWithoutBorder_UserInControlOfTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessGraphicsCaptureWithoutBorder_ForceAllowTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsAccessGraphicsCaptureWithoutBorder_ForceDenyTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
:: Disable app capability (graphicsCaptureWithoutBorder) using user privacy settings
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\graphicsCaptureWithoutBorder" /v "Value" /d "Deny" /t REG_SZ /f
:: ----------------------------------------------------------


:: Disable app access to background activity (breaks Cortana, Search, live tiles, notifications)
echo --- Disable app access to background activity (breaks Cortana, Search, live tiles, notifications)
:: Disable app access (LetAppsRunInBackground) using GPO (re-activation through GUI is not possible)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsRunInBackground' /t 'REG_DWORD' /d '2' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsRunInBackground_UserInControlOfTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsRunInBackground_ForceAllowTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' /v 'LetAppsRunInBackground_ForceDenyTheseApps' /t 'REG_MULTI_SZ' /d '\0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications' /v 'GlobalUserDisabled' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----------Disable app access to input devices------------
:: ----------------------------------------------------------
echo --- Disable app access to input devices
:: Disable app capability (humanInterfaceDevice) using user privacy settings
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\humanInterfaceDevice" /v "Value" /d "Deny" /t REG_SZ /f
:: ----------------------------------------------------------


:: Disable daily compatibility data collection ("Microsoft Compatibility Appraiser" task)
echo --- Disable daily compatibility data collection ("Microsoft Compatibility Appraiser" task)
:: Disable scheduled task(s): `\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\Microsoft\Windows\Application Experience\'; $taskNamePattern='Microsoft Compatibility Appraiser'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) {; Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) {; $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) {; Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try {; $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch {; Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) {; Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: ----------------------------------------------------------


:: Disable telemetry collector and sender process (`CompatTelRunner.exe`)
echo --- Disable telemetry collector and sender process (`CompatTelRunner.exe`)
:: Check and terminate the running process "CompatTelRunner.exe"
tasklist /fi "ImageName eq CompatTelRunner.exe" /fo csv 2>NUL | find /i "CompatTelRunner.exe">NUL && (
    echo CompatTelRunner.exe is running and will be killed.
    taskkill /f /im CompatTelRunner.exe
) || (
    echo Skipping, CompatTelRunner.exe is not running.
)
:: Configure termination of "CompatTelRunner.exe" immediately upon its startup
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\CompatTelRunner.exe' /v 'Debugger' /t 'REG_SZ' /d '%WINDIR%\System32\taskkill.exe' /f"
:: Add a rule to prevent the executable "CompatTelRunner.exe"" from running via File Explorer
PowerShell -ExecutionPolicy Unrestricted -Command "$executableFilename='CompatTelRunner.exe'; try {; $registryPathForDisallowRun='HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun'; $existingBlockEntries = Get-ItemProperty -Path "^""$registryPathForDisallowRun"^"" -ErrorAction Ignore; $nextFreeRuleIndex = 1; if ($existingBlockEntries) {; $existingBlockingRuleForExecutable = $existingBlockEntries.PSObject.Properties | Where-Object { $_.Value -eq $executableFilename }; if ($existingBlockingRuleForExecutable) {; $existingBlockingRuleIndexForExecutable = $existingBlockingRuleForExecutable.Name; Write-Output "^""Skipping, no action needed: `$executableFilename` is already blocked under rule index `"^""$existingBlockingRuleIndexForExecutable`"^""."^""; exit 0; }; $occupiedRuleIndexes = $existingBlockEntries.PSObject.Properties | Where-Object { $_.Name -Match '^\d+$' } | Select -ExpandProperty Name; if ($occupiedRuleIndexes) {; while ($occupiedRuleIndexes -Contains $nextFreeRuleIndex) {; $nextFreeRuleIndex += 1; }; }; }; Write-Output "^""Adding block rule for `"^""$executableFilename`"^"" under rule index `"^""$nextFreeRuleIndex`"^""."^""; if (!(Test-Path $registryPathForDisallowRun)) {; New-Item -Path "^""$registryPathForDisallowRun"^"" -Force -ErrorAction Stop | Out-Null; }; New-ItemProperty -Path "^""$registryPathForDisallowRun"^"" -Name "^""$nextFreeRuleIndex"^"" -PropertyType String -Value "^""$executableFilename"^"" ` -ErrorAction Stop | Out-Null; Write-Output "^""Successfully blocked `"^""$executableFilename`"^"" with rule index `"^""$nextFreeRuleIndex`"^""."^""; } catch {; Write-Error "^""Failed to block `"^""$executableFilename`"^"": $_"^""; Exit 1; }"
:: Activate the DisallowRun policy to block specified programs from running via File Explorer
PowerShell -ExecutionPolicy Unrestricted -Command "try {; $fileExplorerDisallowRunRegistryPath = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer'; $currentDisallowRunPolicyValue = Get-ItemProperty -Path "^""$fileExplorerDisallowRunRegistryPath"^"" -Name 'DisallowRun' -ErrorAction Ignore | Select -ExpandProperty DisallowRun; if ([string]::IsNullOrEmpty($currentDisallowRunPolicyValue)) {; Write-Output "^""Creating DisallowRun policy at `"^""$fileExplorerDisallowRunRegistryPath`"^""."^""; if (!(Test-Path $fileExplorerDisallowRunRegistryPath)) {; New-Item -Path "^""$fileExplorerDisallowRunRegistryPath"^"" -Force -ErrorAction Stop | Out-Null; }; New-ItemProperty -Path "^""$fileExplorerDisallowRunRegistryPath"^"" -Name 'DisallowRun' -Value 1 -PropertyType DWORD -Force -ErrorAction Stop | Out-Null; Write-Output 'Successfully activated DisallowRun policy.'; Exit 0; }; if ($currentDisallowRunPolicyValue -eq 1) {; Write-Output 'Skipping, no action needed: DisallowRun policy is already in place.'; Exit 0; }; Write-Output 'Updating DisallowRun policy from unexpected value `"^""$currentDisallowRunPolicyValue`"^"" to `"^""1`"^"".'; Set-ItemProperty -Path "^""$fileExplorerDisallowRunRegistryPath"^"" -Name 'DisallowRun' -Value 1 -Type DWORD -Force -ErrorAction Stop | Out-Null; Write-Output 'Successfully activated DisallowRun policy.'; } catch {; Write-Error "^""Failed to activate DisallowRun policy: $_"^""; Exit 1; }"
:: Soft delete files matching pattern (with additional permissions) : "%WINDIR%\System32\CompatTelRunner.exe"
PowerShell -ExecutionPolicy Unrestricted -Command "$pathGlobPattern = "^""%WINDIR%\System32\CompatTelRunner.exe"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $renamedCount   = 0; $skippedCount   = 0; $failedCount    = 0; Add-Type -TypeDefinition "^""using System;`r`nusing System.Runtime.InteropServices;`r`npublic class Privileges {`r`n    [DllImport(`"^""advapi32.dll`"^"", ExactSpelling = true, SetLastError = true)]`r`n    internal static extern bool AdjustTokenPrivileges(IntPtr htok, bool disall,`r`n        ref TokPriv1Luid newst, int len, IntPtr prev, IntPtr relen);`r`n    [DllImport(`"^""advapi32.dll`"^"", ExactSpelling = true, SetLastError = true)]`r`n    internal static extern bool OpenProcessToken(IntPtr h, int acc, ref IntPtr phtok);`r`n    [DllImport(`"^""advapi32.dll`"^"", SetLastError = true)]`r`n    internal static extern bool LookupPrivilegeValue(string host, string name, ref long pluid);`r`n    [StructLayout(LayoutKind.Sequential, Pack = 1)]`r`n    internal struct TokPriv1Luid {`r`n        public int Count;`r`n        public long Luid;`r`n        public int Attr;`r`n    }`r`n    internal const int SE_PRIVILEGE_ENABLED = 0x00000002;`r`n    internal const int TOKEN_QUERY = 0x00000008;`r`n    internal const int TOKEN_ADJUST_PRIVILEGES = 0x00000020;`r`n    public static bool AddPrivilege(string privilege) {`r`n        try {`r`n            bool retVal;`r`n            TokPriv1Luid tp;`r`n            IntPtr hproc = GetCurrentProcess();`r`n            IntPtr htok = IntPtr.Zero;`r`n            retVal = OpenProcessToken(hproc, TOKEN_ADJUST_PRIVILEGES | TOKEN_QUERY, ref htok);`r`n            tp.Count = 1;`r`n            tp.Luid = 0;`r`n            tp.Attr = SE_PRIVILEGE_ENABLED;`r`n            retVal = LookupPrivilegeValue(null, privilege, ref tp.Luid);`r`n            retVal = AdjustTokenPrivileges(htok, false, ref tp, 0, IntPtr.Zero, IntPtr.Zero);`r`n            return retVal;`r`n        } catch (Exception ex) {`r`n            throw new Exception(`"^""Failed to adjust token privileges`"^"", ex);`r`n        }`r`n    }`r`n    public static bool RemovePrivilege(string privilege) {`r`n        try {`r`n            bool retVal;`r`n            TokPriv1Luid tp;`r`n            IntPtr hproc = GetCurrentProcess();`r`n            IntPtr htok = IntPtr.Zero;`r`n            retVal = OpenProcessToken(hproc, TOKEN_ADJUST_PRIVILEGES | TOKEN_QUERY, ref htok);`r`n            tp.Count = 1;`r`n            tp.Luid = 0;`r`n            tp.Attr = 0;  // This line is changed to revoke the privilege`r`n            retVal = LookupPrivilegeValue(null, privilege, ref tp.Luid);`r`n            retVal = AdjustTokenPrivileges(htok, false, ref tp, 0, IntPtr.Zero, IntPtr.Zero);`r`n            return retVal;`r`n        } catch (Exception ex) {`r`n            throw new Exception(`"^""Failed to adjust token privileges`"^"", ex);`r`n        }`r`n    }`r`n    [DllImport(`"^""kernel32.dll`"^"", CharSet = CharSet.Auto)]`r`n    public static extern IntPtr GetCurrentProcess();`r`n}"^""; [Privileges]::AddPrivilege('SeRestorePrivilege') | Out-Null; [Privileges]::AddPrivilege('SeTakeOwnershipPrivilege') | Out-Null; $adminSid = New-Object System.Security.Principal.SecurityIdentifier 'S-1-5-32-544'; $adminAccount = $adminSid.Translate([System.Security.Principal.NTAccount]); $adminFullControlAccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule( $adminAccount, [System.Security.AccessControl.FileSystemRights]::FullControl, [System.Security.AccessControl.AccessControlType]::Allow ); $foundAbsolutePaths = @(); try {; $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] {; <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) {; Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) {; if (Test-Path -Path $path -PathType Container) {; Write-Host "^""Skipping folder (not its contents): `"^""$path`"^""."^""; $skippedCount++; continue; }; if($revert -eq $true) {; if (-not $path.EndsWith('.OLD')) {; Write-Host "^""Skipping non-backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; } else {; if ($path.EndsWith('.OLD')) {; Write-Host "^""Skipping backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; }; $originalFilePath = $path; Write-Host "^""Processing file: `"^""$originalFilePath`"^""."^""; if (-Not (Test-Path $originalFilePath)) {; Write-Host "^""Skipping, file `"^""$originalFilePath`"^"" not found."^""; $skippedCount++; exit 0; }; $originalAcl = Get-Acl -Path "^""$originalFilePath"^""; $accessGranted = $false; try {; $acl = Get-Acl -Path "^""$originalFilePath"^""; $acl.SetOwner($adminAccount) <# Take Ownership (because file is owned by TrustedInstaller) #>; $acl.AddAccessRule($adminFullControlAccessRule) <# Grant rights to be able to move the file #>; Set-Acl -Path $originalFilePath -AclObject $acl -ErrorAction Stop; $accessGranted = $true; } catch {; Write-Warning "^""Failed to grant access to `"^""$originalFilePath`"^"": $($_.Exception.Message)"^""; }; if ($revert -eq $true) {; $newFilePath = $originalFilePath.Substring(0, $originalFilePath.Length - 4); } else {; $newFilePath = "^""$($originalFilePath).OLD"^""; }; try {; Move-Item -LiteralPath "^""$($originalFilePath)"^"" -Destination "^""$newFilePath"^"" -Force -ErrorAction Stop; Write-Host "^""Successfully processed `"^""$originalFilePath`"^""."^""; $renamedCount++; if ($accessGranted) {; try {; Set-Acl -Path $newFilePath -AclObject $originalAcl -ErrorAction Stop; } catch {; Write-Warning "^""Failed to restore access on `"^""$newFilePath`"^"": $($_.Exception.Message)"^""; }; }; } catch {; Write-Error "^""Failed to rename `"^""$originalFilePath`"^"" to `"^""$newFilePath`"^"": $($_.Exception.Message)"^""; $failedCount++; if ($accessGranted) {; try {; Set-Acl -Path $originalFilePath -AclObject $originalAcl -ErrorAction Stop; } catch {; Write-Warning "^""Failed to restore access on `"^""$originalFilePath`"^"": $($_.Exception.Message)"^""; }; }; }; }; if (($renamedCount -gt 0) -or ($skippedCount -gt 0)) {; Write-Host "^""Successfully processed $renamedCount items and skipped $skippedCount items."^""; }; if ($failedCount -gt 0) {; Write-Warning "^""Failed to processed $($failedCount) items."^""; }; [Privileges]::RemovePrivilege('SeRestorePrivilege') | Out-Null; [Privileges]::RemovePrivilege('SeTakeOwnershipPrivilege') | Out-Null"
:: ----------------------------------------------------------


:: Disable program data collection and reporting (`ProgramDataUpdater`)
echo --- Disable program data collection and reporting (`ProgramDataUpdater`)
:: Disable scheduled task(s): `\Microsoft\Windows\Application Experience\ProgramDataUpdater`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\Microsoft\Windows\Application Experience\'; $taskNamePattern='ProgramDataUpdater'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) {; Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) {; $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) {; Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try {; $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch {; Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) {; Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----Disable application usage tracking (`AitAgent`)------
:: ----------------------------------------------------------
echo --- Disable application usage tracking (`AitAgent`)
:: Disable scheduled task(s): `\Microsoft\Windows\Application Experience\AitAgent`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\Microsoft\Windows\Application Experience\'; $taskNamePattern='AitAgent'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) {; Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) {; $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) {; Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try {; $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch {; Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) {; Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: ----------------------------------------------------------


:: Disable startup application data tracking (`StartupAppTask`)
echo --- Disable startup application data tracking (`StartupAppTask`)
:: Disable scheduled task(s): `\Microsoft\Windows\Application Experience\StartupAppTask`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\Microsoft\Windows\Application Experience\'; $taskNamePattern='StartupAppTask'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) {; Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) {; $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) {; Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try {; $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch {; Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) {; Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: Disable software compatibility updates (`PcaPatchDbTask`)-
:: ----------------------------------------------------------
echo --- Disable software compatibility updates (`PcaPatchDbTask`)
:: Disable scheduled task(s): `\Microsoft\Windows\Application Experience\PcaPatchDbTask`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\Microsoft\Windows\Application Experience\'; $taskNamePattern='PcaPatchDbTask'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) {; Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) {; $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) {; Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try {; $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch {; Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) {; Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: ----------------------------------------------------------


:: Disable compatibility adjustment data sharing (`SdbinstMergeDbTask`)
echo --- Disable compatibility adjustment data sharing (`SdbinstMergeDbTask`)
:: Disable scheduled task(s): `\Microsoft\Windows\Application Experience\SdbinstMergeDbTask`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\Microsoft\Windows\Application Experience\'; $taskNamePattern='SdbinstMergeDbTask'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) {; Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) {; $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) {; Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; $taskFullPath = "^""$($task.TaskPath)$($task.TaskName)"^""; $adminSid = New-Object System.Security.Principal.SecurityIdentifier 'S-1-5-32-544'; $adminAccount = $adminSid.Translate([System.Security.Principal.NTAccount]); $taskFilePath="^""$($env:WINDIR)\System32\Tasks$($task.TaskPath)$($task.TaskName)"^""; $accessGranted = $false; try {; $originalAcl= Get-Acl -Path $taskFilePath -ErrorAction Stop; $modifiedAcl= Get-Acl -Path $taskFilePath -ErrorAction Stop; $modifiedAcl.SetOwner($adminAccount); $taskFileAccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule( $adminAccount, [System.Security.AccessControl.FileSystemRights]::FullControl, [System.Security.AccessControl.AccessControlType]::Allow ); $modifiedAcl.SetAccessRule($taskFileAccessRule); Set-Acl -Path $taskFilePath -AclObject $modifiedAcl -ErrorAction Stop; Write-Host "^""Successfully granted permissions for `"^""$taskFullPath`"^"" ."^""; $accessGranted = $true; } catch {; Write-Warning "^""Failed to grant access to `"^""$taskFullPath`"^"": $($_.Exception.Message)"^""; }; try {; $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch {; Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; if ($accessGranted) {; try {; Set-Acl -Path $taskFilePath -AclObject $originalAcl -ErrorAction Stop; Write-Host "^""Successfully restored permissions for `"^""$taskFullPath`"^"" ."^""; } catch {; Write-Warning "^""Failed to restore access on `"^""$taskFilePath`"^"": $($_.Exception.Message)"^""; }; }; }; if ($operationFailed) {; Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -Disable application backup data gathering (`MareBackup`)-
:: ----------------------------------------------------------
echo --- Disable application backup data gathering (`MareBackup`)
:: Disable scheduled task(s): `\Microsoft\Windows\Application Experience\MareBackup`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\Microsoft\Windows\Application Experience\'; $taskNamePattern='MareBackup'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) {; Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) {; $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) {; Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try {; $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch {; Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) {; Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -Disable "Program Compatibility Assistant (PCA)" feature--
:: ----------------------------------------------------------
echo --- Disable "Program Compatibility Assistant (PCA)" feature
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat' /v 'DisablePCA' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: Disable "Program Compatibility Assistant Service" (`PcaSvc`)
echo --- Disable "Program Compatibility Assistant Service" (`PcaSvc`)
:: Disable service(s): `PcaSvc`
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'PcaSvc'; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service `"^""$serviceName`"^"" could not be not found, no need to disable it."^""; Exit 0; }; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if already disabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if(!$startupType) {; $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if(!$startupType) {; $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if($startupType -eq 'Disabled') {; Write-Host "^""$serviceName is already disabled, no further action is needed"^""; }; <# -- 4. Disable service #>; try {; Set-Service -Name "^""$serviceName"^"" -StartupType Disabled -Confirm:$false -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --------Disable Application Impact Telemetry (AIT)--------
:: ----------------------------------------------------------
echo --- Disable Application Impact Telemetry (AIT)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\Software\Policies\Microsoft\Windows\AppCompat' /v 'AITEnable' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ---------Disable Application Compatibility Engine---------
:: ----------------------------------------------------------
echo --- Disable Application Compatibility Engine
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\Software\Policies\Microsoft\Windows\AppCompat' /v 'DisableEngine' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: Remove "Program Compatibility" tab from file properties (context menu)
echo --- Remove "Program Compatibility" tab from file properties (context menu)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\Software\Policies\Microsoft\Windows\AppCompat' /v 'DisablePropPage' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: Disable Steps Recorder (collects screenshots, mouse/keyboard input and UI data)
echo --- Disable Steps Recorder (collects screenshots, mouse/keyboard input and UI data)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\Software\Policies\Microsoft\Windows\AppCompat' /v 'DisableUAR' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ------------Disable "Inventory Collector" task------------
:: ----------------------------------------------------------
echo --- Disable "Inventory Collector" task
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat' /v 'DisableInventory' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: Disable "Connected User Experiences and Telemetry" (`DiagTrack`) service
echo --- Disable "Connected User Experiences and Telemetry" (`DiagTrack`) service
:: Disable service(s): `DiagTrack`
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'DiagTrack'; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service `"^""$serviceName`"^"" could not be not found, no need to disable it."^""; Exit 0; }; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if already disabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if(!$startupType) {; $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if(!$startupType) {; $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if($startupType -eq 'Disabled') {; Write-Host "^""$serviceName is already disabled, no further action is needed"^""; }; <# -- 4. Disable service #>; try {; Set-Service -Name "^""$serviceName"^"" -StartupType Disabled -Confirm:$false -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ------Disable WAP push notification routing service-------
:: ----------------------------------------------------------
echo --- Disable WAP push notification routing service
:: Disable service(s): `dmwappushservice`
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'dmwappushservice'; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service `"^""$serviceName`"^"" could not be not found, no need to disable it."^""; Exit 0; }; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if already disabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if(!$startupType) {; $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if(!$startupType) {; $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if($startupType -eq 'Disabled') {; Write-Host "^""$serviceName is already disabled, no further action is needed"^""; }; <# -- 4. Disable service #>; try {; Set-Service -Name "^""$serviceName"^"" -StartupType Disabled -Confirm:$false -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ---Disable "Diagnostics Hub Standard Collector" service---
:: ----------------------------------------------------------
echo --- Disable "Diagnostics Hub Standard Collector" service
:: Disable service(s): `diagnosticshub.standardcollector.service`
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'diagnosticshub.standardcollector.service'; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service `"^""$serviceName`"^"" could not be not found, no need to disable it."^""; Exit 0; }; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if already disabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if(!$startupType) {; $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if(!$startupType) {; $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if($startupType -eq 'Disabled') {; Write-Host "^""$serviceName is already disabled, no further action is needed"^""; }; <# -- 4. Disable service #>; try {; Set-Service -Name "^""$serviceName"^"" -StartupType Disabled -Confirm:$false -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----Disable "Diagnostic Execution Service" (`diagsvc`)----
:: ----------------------------------------------------------
echo --- Disable "Diagnostic Execution Service" (`diagsvc`)
:: Disable service(s): `diagsvc`
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'diagsvc'; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service `"^""$serviceName`"^"" could not be not found, no need to disable it."^""; Exit 0; }; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if already disabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if(!$startupType) {; $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if(!$startupType) {; $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if($startupType -eq 'Disabled') {; Write-Host "^""$serviceName is already disabled, no further action is needed"^""; }; <# -- 4. Disable service #>; try {; Set-Service -Name "^""$serviceName"^"" -StartupType Disabled -Confirm:$false -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ------------------Disable "Device" task-------------------
:: ----------------------------------------------------------
echo --- Disable "Device" task
:: Disable scheduled task(s): `\Microsoft\Windows\Device Information\Device`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\Microsoft\Windows\Device Information\'; $taskNamePattern='Device'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) {; Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) {; $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) {; Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try {; $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch {; Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) {; Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----------------Disable "Device User" task----------------
:: ----------------------------------------------------------
echo --- Disable "Device User" task
:: Disable scheduled task(s): `\Microsoft\Windows\Device Information\Device User`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\Microsoft\Windows\Device Information\'; $taskNamePattern='Device User'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) {; Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) {; $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) {; Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try {; $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch {; Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) {; Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --Disable device and configuration data collection tool---
:: ----------------------------------------------------------
echo --- Disable device and configuration data collection tool
:: Check and terminate the running process "DeviceCensus.exe"
tasklist /fi "ImageName eq DeviceCensus.exe" /fo csv 2>NUL | find /i "DeviceCensus.exe">NUL && (
    echo DeviceCensus.exe is running and will be killed.
    taskkill /f /im DeviceCensus.exe
) || (
    echo Skipping, DeviceCensus.exe is not running.
)
:: Configure termination of "DeviceCensus.exe" immediately upon its startup
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\DeviceCensus.exe' /v 'Debugger' /t 'REG_SZ' /d '%WINDIR%\System32\taskkill.exe' /f"
:: Add a rule to prevent the executable "DeviceCensus.exe"" from running via File Explorer
PowerShell -ExecutionPolicy Unrestricted -Command "$executableFilename='DeviceCensus.exe'; try {; $registryPathForDisallowRun='HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun'; $existingBlockEntries = Get-ItemProperty -Path "^""$registryPathForDisallowRun"^"" -ErrorAction Ignore; $nextFreeRuleIndex = 1; if ($existingBlockEntries) {; $existingBlockingRuleForExecutable = $existingBlockEntries.PSObject.Properties | Where-Object { $_.Value -eq $executableFilename }; if ($existingBlockingRuleForExecutable) {; $existingBlockingRuleIndexForExecutable = $existingBlockingRuleForExecutable.Name; Write-Output "^""Skipping, no action needed: `$executableFilename` is already blocked under rule index `"^""$existingBlockingRuleIndexForExecutable`"^""."^""; exit 0; }; $occupiedRuleIndexes = $existingBlockEntries.PSObject.Properties | Where-Object { $_.Name -Match '^\d+$' } | Select -ExpandProperty Name; if ($occupiedRuleIndexes) {; while ($occupiedRuleIndexes -Contains $nextFreeRuleIndex) {; $nextFreeRuleIndex += 1; }; }; }; Write-Output "^""Adding block rule for `"^""$executableFilename`"^"" under rule index `"^""$nextFreeRuleIndex`"^""."^""; if (!(Test-Path $registryPathForDisallowRun)) {; New-Item -Path "^""$registryPathForDisallowRun"^"" -Force -ErrorAction Stop | Out-Null; }; New-ItemProperty -Path "^""$registryPathForDisallowRun"^"" -Name "^""$nextFreeRuleIndex"^"" -PropertyType String -Value "^""$executableFilename"^"" ` -ErrorAction Stop | Out-Null; Write-Output "^""Successfully blocked `"^""$executableFilename`"^"" with rule index `"^""$nextFreeRuleIndex`"^""."^""; } catch {; Write-Error "^""Failed to block `"^""$executableFilename`"^"": $_"^""; Exit 1; }"
:: Activate the DisallowRun policy to block specified programs from running via File Explorer
PowerShell -ExecutionPolicy Unrestricted -Command "try {; $fileExplorerDisallowRunRegistryPath = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer'; $currentDisallowRunPolicyValue = Get-ItemProperty -Path "^""$fileExplorerDisallowRunRegistryPath"^"" -Name 'DisallowRun' -ErrorAction Ignore | Select -ExpandProperty DisallowRun; if ([string]::IsNullOrEmpty($currentDisallowRunPolicyValue)) {; Write-Output "^""Creating DisallowRun policy at `"^""$fileExplorerDisallowRunRegistryPath`"^""."^""; if (!(Test-Path $fileExplorerDisallowRunRegistryPath)) {; New-Item -Path "^""$fileExplorerDisallowRunRegistryPath"^"" -Force -ErrorAction Stop | Out-Null; }; New-ItemProperty -Path "^""$fileExplorerDisallowRunRegistryPath"^"" -Name 'DisallowRun' -Value 1 -PropertyType DWORD -Force -ErrorAction Stop | Out-Null; Write-Output 'Successfully activated DisallowRun policy.'; Exit 0; }; if ($currentDisallowRunPolicyValue -eq 1) {; Write-Output 'Skipping, no action needed: DisallowRun policy is already in place.'; Exit 0; }; Write-Output 'Updating DisallowRun policy from unexpected value `"^""$currentDisallowRunPolicyValue`"^"" to `"^""1`"^"".'; Set-ItemProperty -Path "^""$fileExplorerDisallowRunRegistryPath"^"" -Name 'DisallowRun' -Value 1 -Type DWORD -Force -ErrorAction Stop | Out-Null; Write-Output 'Successfully activated DisallowRun policy.'; } catch {; Write-Error "^""Failed to activate DisallowRun policy: $_"^""; Exit 1; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ---------Disable processing of Desktop Analytics----------
:: ----------------------------------------------------------
echo --- Disable processing of Desktop Analytics
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection' /v 'AllowDesktopAnalyticsProcessing' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --Disable sending device name in Windows diagnostic data--
:: ----------------------------------------------------------
echo --- Disable sending device name in Windows diagnostic data
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection' /v 'AllowDeviceNameInTelemetry' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: Disable collection of Edge browsing data for Desktop Analytics
echo --- Disable collection of Edge browsing data for Desktop Analytics
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection' /v 'MicrosoftEdgeDataOptIn' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --Disable diagnostics data processing for Business cloud--
:: ----------------------------------------------------------
echo --- Disable diagnostics data processing for Business cloud
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection' /v 'AllowWUfBCloudProcessing' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -Disable Update Compliance processing of diagnostics data-
:: ----------------------------------------------------------
echo --- Disable Update Compliance processing of diagnostics data
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection' /v 'AllowUpdateComplianceProcessing' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --------Disable commercial usage of collected data--------
:: ----------------------------------------------------------
echo --- Disable commercial usage of collected data
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection' /v 'AllowCommercialDataPipeline' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --Disable Customer Experience Improvement Program (CEIP)--
:: ----------------------------------------------------------
echo --- Disable Customer Experience Improvement Program (CEIP)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\Software\Policies\Microsoft\SQMClient\Windows' /v 'CEIPEnable' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: Disable "Customer Experience Improvement Program" scheduled tasks
echo --- Disable "Customer Experience Improvement Program" scheduled tasks
:: Disable scheduled task(s): `\Microsoft\Windows\Customer Experience Improvement Program\Consolidator`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\Microsoft\Windows\Customer Experience Improvement Program\'; $taskNamePattern='Consolidator'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) {; Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) {; $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) {; Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try {; $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch {; Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) {; Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: Disable scheduled task(s): `\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\Microsoft\Windows\Customer Experience Improvement Program\'; $taskNamePattern='KernelCeipTask'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) {; Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) {; $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) {; Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try {; $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch {; Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) {; Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: Disable scheduled task(s): `\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\Microsoft\Windows\Customer Experience Improvement Program\'; $taskNamePattern='UsbCeip'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) {; Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) {; $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) {; Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try {; $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch {; Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) {; Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----------Disable diagnostic and usage telemetry----------
:: ----------------------------------------------------------
echo --- Disable diagnostic and usage telemetry
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t "REG_DWORD" /d "0" /f
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection' /v 'AllowTelemetry' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----Disable automatic cloud configuration downloads------
:: ----------------------------------------------------------
echo --- Disable automatic cloud configuration downloads
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\Software\Policies\Microsoft\Windows\DataCollection' /v 'DisableOneSettingsDownloads' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----------------Disable license telemetry-----------------
:: ----------------------------------------------------------
echo --- Disable license telemetry
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\Software\Policies\Microsoft\Windows NT\CurrentVersion\Software Protection Platform' /v 'NoGenTicket' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----------------Disable error reporting------------------
:: ----------------------------------------------------------
echo --- Disable error reporting
:: Disable Windows Error Reporting (WER)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\Software\Policies\Microsoft\Windows\Windows Error Reporting' /v 'Disabled' /t 'REG_DWORD' /d '1' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting' /v 'Disabled' /t 'REG_DWORD' /d '1' /f"
:: Disable Windows Error Reporting (WER) consent
reg add "HKLM\Software\Microsoft\Windows\Windows Error Reporting\Consent" /v "DefaultConsent" /t "REG_DWORD" /d "1" /f
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\Software\Microsoft\Windows\Windows Error Reporting\Consent' /v 'DefaultOverrideBehavior' /t 'REG_DWORD' /d '1' /f"
:: Disable WER sending second-level data
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\Software\Microsoft\Windows\Windows Error Reporting' /v 'DontSendAdditionalData' /t 'REG_DWORD' /d '1' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\Software\Microsoft\Windows\Windows Error Reporting' /v 'LoggingDisabled' /t 'REG_DWORD' /d '1' /f"
:: Disable scheduled task(s): `\Microsoft\Windows\ErrorDetails\EnableErrorDetailsUpdate`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\Microsoft\Windows\ErrorDetails\'; $taskNamePattern='EnableErrorDetailsUpdate'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) {; Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) {; $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) {; Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try {; $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch {; Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) {; Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: Disable scheduled task(s): `\Microsoft\Windows\Windows Error Reporting\QueueReporting`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\Microsoft\Windows\Windows Error Reporting\'; $taskNamePattern='QueueReporting'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) {; Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) {; $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) {; Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try {; $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch {; Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) {; Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: Disable service(s): `wersvc`
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'wersvc'; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service `"^""$serviceName`"^"" could not be not found, no need to disable it."^""; Exit 0; }; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if already disabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if(!$startupType) {; $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if(!$startupType) {; $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if($startupType -eq 'Disabled') {; Write-Host "^""$serviceName is already disabled, no further action is needed"^""; }; <# -- 4. Disable service #>; try {; Set-Service -Name "^""$serviceName"^"" -StartupType Disabled -Confirm:$false -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }"
:: Disable service(s): `wercplsupport`
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'wercplsupport'; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service `"^""$serviceName`"^"" could not be not found, no need to disable it."^""; Exit 0; }; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if already disabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if(!$startupType) {; $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if(!$startupType) {; $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if($startupType -eq 'Disabled') {; Write-Host "^""$serviceName is already disabled, no further action is needed"^""; }; <# -- 4. Disable service #>; try {; Set-Service -Name "^""$serviceName"^"" -StartupType Disabled -Confirm:$false -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -Disable device metadata retrieval (breaks auto updates)--
:: ----------------------------------------------------------
echo --- Disable device metadata retrieval (breaks auto updates)
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d 1 /f
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Device Metadata' /v 'PreventDeviceMetadataFromNetwork' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----Disable inclusion of drivers with Windows updates-----
:: ----------------------------------------------------------
echo --- Disable inclusion of drivers with Windows updates
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' /v 'ExcludeWUDriversInQualityUpdate' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -------Disable Windows Update device driver search--------
:: ----------------------------------------------------------
echo --- Disable Windows Update device driver search
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t "REG_DWORD" /d "1" /f
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ---Disable peering download method for Windows Updates----
:: ----------------------------------------------------------
echo --- Disable peering download method for Windows Updates
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization' /v 'DODownloadMode' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: Disable "Delivery Optimization" service (breaks Microsoft Store downloads)
echo --- Disable "Delivery Optimization" service (breaks Microsoft Store downloads)
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceQuery = 'DoSvc'; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceQuery -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service query `"^""$serviceQuery`"^"" did not yield any results, no need to disable it."^""; Exit 0; }; $serviceName = $service.Name; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, trying to stop it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if service info is not found in registry #>; $registryKey = "^""HKLM:\SYSTEM\CurrentControlSet\Services\$serviceName"^""; if(!(Test-Path $registryKey)) {; Write-Host "^""`"^""$registryKey`"^"" is not found in registry, cannot enable it."^""; Exit 0; }; <# -- 4. Skip if already disabled #>; if( $(Get-ItemProperty -Path "^""$registryKey"^"").Start -eq 4) {; Write-Host "^""`"^""$serviceName`"^"" is already disabled from start, no further action is needed."^""; Exit 0; }; <# -- 5. Disable service #>; try {; Set-ItemProperty $registryKey -Name Start -Value 4 -Force -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ------------Disable Windows Location Provider-------------
:: ----------------------------------------------------------
echo --- Disable Windows Location Provider
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors' /v 'DisableWindowsLocationProvider' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----------------Disable location scripting----------------
:: ----------------------------------------------------------
echo --- Disable location scripting
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors' /v 'DisableLocationScripting' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ---------------------Disable location---------------------
:: ----------------------------------------------------------
echo --- Disable location
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors' /v 'DisableLocation' /t 'REG_DWORD' /d '1' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}' /v 'Value' /t 'REG_SZ' /d 'Deny' /f"
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "SensorPermissionState" /d "0" /t REG_DWORD /f
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ------------Disable Cortana's history display-------------
:: ----------------------------------------------------------
echo --- Disable Cortana's history display
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' /v 'HistoryViewEnabled' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----------Disable Cortana's device history usage----------
:: ----------------------------------------------------------
echo --- Disable Cortana's device history usage
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' /v 'DeviceHistoryEnabled' /t 'REG_DWORD' /d '0' /f"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $ignoreWindows10 =  $false; $ignoreWindows11 =  $false; $warn =  $false; $osVersion = [System.Environment]::OSVersion.Version; function Test-IsWindows10 { ($osVersion.Major -eq 10) -and ($osVersion.Build -lt 22000) }; function Test-IsWindows11 { ($osVersion.Major -gt 10) -or (($osVersion.Major -eq 10) -and ($osVersion.Build -ge 22000)) }; if (($ignoreWindows10 -and (Test-IsWindows10)) -or ($ignoreWindows11 -and (Test-IsWindows11))) {; echo "^""Skipping"^""; exit 0 <# Skip #>; }; if ($warn) {; Write-Warning "^""$message"^""; } else {; Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----------Disable "Hey Cortana" voice activation----------
:: ----------------------------------------------------------
echo --- Disable "Hey Cortana" voice activation
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\Software\Microsoft\Speech_OneCore\Preferences' /v 'VoiceActivationOn' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\Software\Microsoft\Speech_OneCore\Preferences' /v 'VoiceActivationDefaultOn' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: Disable Cortana keyboard shortcut (**Windows logo key** + **C**)
echo --- Disable Cortana keyboard shortcut (**Windows logo key** + **C**)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' /v 'VoiceShortcut' /t 'REG_DWORD' /d '0' /f"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $ignoreWindows10 =  $false; $ignoreWindows11 =  $false; $warn =  $false; $osVersion = [System.Environment]::OSVersion.Version; function Test-IsWindows10 { ($osVersion.Major -eq 10) -and ($osVersion.Build -lt 22000) }; function Test-IsWindows11 { ($osVersion.Major -gt 10) -or (($osVersion.Major -eq 10) -and ($osVersion.Build -ge 22000)) }; if (($ignoreWindows10 -and (Test-IsWindows10)) -or ($ignoreWindows11 -and (Test-IsWindows11))) {; echo "^""Skipping"^""; exit 0 <# Skip #>; }; if ($warn) {; Write-Warning "^""$message"^""; } else {; Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -------------Disable Cortana on locked device-------------
:: ----------------------------------------------------------
echo --- Disable Cortana on locked device
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\Software\Microsoft\Speech_OneCore\Preferences' /v 'VoiceActivationEnableAboveLockscreen' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ---------Disable automatic update of speech data----------
:: ----------------------------------------------------------
echo --- Disable automatic update of speech data
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\Software\Microsoft\Speech_OneCore\Preferences' /v 'ModelDownloadAllowed' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----Disable Cortana voice support during Windows setup----
:: ----------------------------------------------------------
echo --- Disable Cortana voice support during Windows setup
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE' /v 'DisableVoice' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --------------Disable Cortana during search---------------
:: ----------------------------------------------------------
echo --- Disable Cortana during search
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search' /v 'AllowCortana' /t 'REG_DWORD' /d '0' /f"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $ignoreWindows10 =  $false; $ignoreWindows11 =  $false; $warn =  $false; $osVersion = [System.Environment]::OSVersion.Version; function Test-IsWindows10 { ($osVersion.Major -eq 10) -and ($osVersion.Build -lt 22000) }; function Test-IsWindows11 { ($osVersion.Major -gt 10) -or (($osVersion.Major -eq 10) -and ($osVersion.Build -ge 22000)) }; if (($ignoreWindows10 -and (Test-IsWindows10)) -or ($ignoreWindows11 -and (Test-IsWindows11))) {; echo "^""Skipping"^""; exit 0 <# Skip #>; }; if ($warn) {; Write-Warning "^""$message"^""; } else {; Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----------------Disable Cortana experience----------------
:: ----------------------------------------------------------
echo --- Disable Cortana experience
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Experience\AllowCortana" /v "value" /t REG_DWORD /d 0 /f
:: ----------------------------------------------------------


:: Disable Cortana's access to cloud services such as OneDrive and SharePoint
echo --- Disable Cortana's access to cloud services such as OneDrive and SharePoint
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search' /v 'AllowCloudSearch' /t 'REG_DWORD' /d '0' /f"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $ignoreWindows10 =  $false; $ignoreWindows11 =  $false; $warn =  $false; $osVersion = [System.Environment]::OSVersion.Version; function Test-IsWindows10 { ($osVersion.Major -eq 10) -and ($osVersion.Build -lt 22000) }; function Test-IsWindows11 { ($osVersion.Major -gt 10) -or (($osVersion.Major -eq 10) -and ($osVersion.Build -ge 22000)) }; if (($ignoreWindows10 -and (Test-IsWindows10)) -or ($ignoreWindows11 -and (Test-IsWindows11))) {; echo "^""Skipping"^""; exit 0 <# Skip #>; }; if ($warn) {; Write-Warning "^""$message"^""; } else {; Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------


:: Disable Cortana speech interaction while the system is locked
echo --- Disable Cortana speech interaction while the system is locked
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search' /v 'AllowCortanaAboveLock' /t 'REG_DWORD' /d '0' /f"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $ignoreWindows10 =  $false; $ignoreWindows11 =  $false; $warn =  $false; $osVersion = [System.Environment]::OSVersion.Version; function Test-IsWindows10 { ($osVersion.Major -eq 10) -and ($osVersion.Build -lt 22000) }; function Test-IsWindows11 { ($osVersion.Major -gt 10) -or (($osVersion.Major -eq 10) -and ($osVersion.Build -ge 22000)) }; if (($ignoreWindows10 -and (Test-IsWindows10)) -or ($ignoreWindows11 -and (Test-IsWindows11))) {; echo "^""Skipping"^""; exit 0 <# Skip #>; }; if ($warn) {; Write-Warning "^""$message"^""; } else {; Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----Disable participation in Cortana data collection-----
:: ----------------------------------------------------------
echo --- Disable participation in Cortana data collection
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\Software\Microsoft\Windows\CurrentVersion\Search' /v 'CortanaConsent' /t 'REG_DWORD' /d '0' /f"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $ignoreWindows10 =  $false; $ignoreWindows11 =  $false; $warn =  $false; $osVersion = [System.Environment]::OSVersion.Version; function Test-IsWindows10 { ($osVersion.Major -eq 10) -and ($osVersion.Build -lt 22000) }; function Test-IsWindows11 { ($osVersion.Major -gt 10) -or (($osVersion.Major -eq 10) -and ($osVersion.Build -ge 22000)) }; if (($ignoreWindows10 -and (Test-IsWindows10)) -or ($ignoreWindows11 -and (Test-IsWindows11))) {; echo "^""Skipping"^""; exit 0 <# Skip #>; }; if ($warn) {; Write-Warning "^""$message"^""; } else {; Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ---------------Disable enabling of Cortana----------------
:: ----------------------------------------------------------
echo --- Disable enabling of Cortana
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\Software\Microsoft\Windows\CurrentVersion\Search' /v 'CanCortanaBeEnabled' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --------------Disable Cortana in start menu---------------
:: ----------------------------------------------------------
echo --- Disable Cortana in start menu
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' /v 'CortanaEnabled' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' /v 'CortanaEnabled' /t 'REG_DWORD' /d '0' /f"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $ignoreWindows10 =  $false; $ignoreWindows11 =  $false; $warn =  $false; $osVersion = [System.Environment]::OSVersion.Version; function Test-IsWindows10 { ($osVersion.Major -eq 10) -and ($osVersion.Build -lt 22000) }; function Test-IsWindows11 { ($osVersion.Major -gt 10) -or (($osVersion.Major -eq 10) -and ($osVersion.Build -ge 22000)) }; if (($ignoreWindows10 -and (Test-IsWindows10)) -or ($ignoreWindows11 -and (Test-IsWindows11))) {; echo "^""Skipping"^""; exit 0 <# Skip #>; }; if ($warn) {; Write-Warning "^""$message"^""; } else {; Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ------------Remove "Cortana" icon from taskbar------------
:: ----------------------------------------------------------
echo --- Remove "Cortana" icon from taskbar
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' /v 'ShowCortanaButton' /t 'REG_DWORD' /d '0' /f"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $ignoreWindows10 =  $false; $ignoreWindows11 =  $false; $warn =  $false; $osVersion = [System.Environment]::OSVersion.Version; function Test-IsWindows10 { ($osVersion.Major -eq 10) -and ($osVersion.Build -lt 22000) }; function Test-IsWindows11 { ($osVersion.Major -gt 10) -or (($osVersion.Major -eq 10) -and ($osVersion.Build -ge 22000)) }; if (($ignoreWindows10 -and (Test-IsWindows10)) -or ($ignoreWindows11 -and (Test-IsWindows11))) {; echo "^""Skipping"^""; exit 0 <# Skip #>; }; if ($warn) {; Write-Warning "^""$message"^""; } else {; Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -------------Disable Cortana in ambient mode--------------
:: ----------------------------------------------------------
echo --- Disable Cortana in ambient mode
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' /v 'CortanaInAmbientMode' /t 'REG_DWORD' /d '0' /f"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $ignoreWindows10 =  $false; $ignoreWindows11 =  $false; $warn =  $false; $osVersion = [System.Environment]::OSVersion.Version; function Test-IsWindows10 { ($osVersion.Major -eq 10) -and ($osVersion.Build -lt 22000) }; function Test-IsWindows11 { ($osVersion.Major -gt 10) -or (($osVersion.Major -eq 10) -and ($osVersion.Build -ge 22000)) }; if (($ignoreWindows10 -and (Test-IsWindows10)) -or ($ignoreWindows11 -and (Test-IsWindows11))) {; echo "^""Skipping"^""; exit 0 <# Skip #>; }; if ($warn) {; Write-Warning "^""$message"^""; } else {; Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----------Disable indexing of encrypted items------------
:: ----------------------------------------------------------
echo --- Disable indexing of encrypted items
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search' /v 'AllowIndexingEncryptedStoresOrItems' /t 'REG_DWORD' /d '0' /f"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $ignoreWindows10 =  $false; $ignoreWindows11 =  $false; $warn =  $false; $osVersion = [System.Environment]::OSVersion.Version; function Test-IsWindows10 { ($osVersion.Major -eq 10) -and ($osVersion.Build -lt 22000) }; function Test-IsWindows11 { ($osVersion.Major -gt 10) -or (($osVersion.Major -eq 10) -and ($osVersion.Build -ge 22000)) }; if (($ignoreWindows10 -and (Test-IsWindows10)) -or ($ignoreWindows11 -and (Test-IsWindows11))) {; echo "^""Skipping"^""; exit 0 <# Skip #>; }; if ($warn) {; Write-Warning "^""$message"^""; } else {; Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----Disable automatic language detection when indexing----
:: ----------------------------------------------------------
echo --- Disable automatic language detection when indexing
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search' /v 'AlwaysUseAutoLangDetection' /t 'REG_DWORD' /d '0' /f"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $ignoreWindows10 =  $false; $ignoreWindows11 =  $false; $warn =  $false; $osVersion = [System.Environment]::OSVersion.Version; function Test-IsWindows10 { ($osVersion.Major -eq 10) -and ($osVersion.Build -lt 22000) }; function Test-IsWindows11 { ($osVersion.Major -gt 10) -or (($osVersion.Major -eq 10) -and ($osVersion.Build -ge 22000)) }; if (($ignoreWindows10 -and (Test-IsWindows10)) -or ($ignoreWindows11 -and (Test-IsWindows11))) {; echo "^""Skipping"^""; exit 0 <# Skip #>; }; if ($warn) {; Write-Warning "^""$message"^""; } else {; Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----------Disable remote access to search index-----------
:: ----------------------------------------------------------
echo --- Disable remote access to search index
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search' /v 'PreventRemoteQueries' /t 'REG_DWORD' /d '1' /f"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $ignoreWindows10 =  $false; $ignoreWindows11 =  $false; $warn =  $false; $osVersion = [System.Environment]::OSVersion.Version; function Test-IsWindows10 { ($osVersion.Major -eq 10) -and ($osVersion.Build -lt 22000) }; function Test-IsWindows11 { ($osVersion.Major -gt 10) -or (($osVersion.Major -eq 10) -and ($osVersion.Build -ge 22000)) }; if (($ignoreWindows10 -and (Test-IsWindows10)) -or ($ignoreWindows11 -and (Test-IsWindows11))) {; echo "^""Skipping"^""; exit 0 <# Skip #>; }; if ($warn) {; Write-Warning "^""$message"^""; } else {; Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----------Disable iFilters and protocol handlers----------
:: ----------------------------------------------------------
echo --- Disable iFilters and protocol handlers
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search' /v 'PreventUnwantedAddIns' /t 'REG_SZ' /d ' ' /f"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $ignoreWindows10 =  $false; $ignoreWindows11 =  $false; $warn =  $false; $osVersion = [System.Environment]::OSVersion.Version; function Test-IsWindows10 { ($osVersion.Major -eq 10) -and ($osVersion.Build -lt 22000) }; function Test-IsWindows11 { ($osVersion.Major -gt 10) -or (($osVersion.Major -eq 10) -and ($osVersion.Build -ge 22000)) }; if (($ignoreWindows10 -and (Test-IsWindows10)) -or ($ignoreWindows11 -and (Test-IsWindows11))) {; echo "^""Skipping"^""; exit 0 <# Skip #>; }; if ($warn) {; Write-Warning "^""$message"^""; } else {; Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------


:: Disable Bing search and recent search suggestions (breaks search history)
echo --- Disable Bing search and recent search suggestions (breaks search history)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer' /v 'DisableSearchBoxSuggestions' /t 'REG_DWORD' /d '1' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' /v 'DisableSearchBoxSuggestions' /t 'REG_DWORD' /d '1' /f"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $ignoreWindows10 =  $false; $ignoreWindows11 =  $false; $warn =  $false; $osVersion = [System.Environment]::OSVersion.Version; function Test-IsWindows10 { ($osVersion.Major -eq 10) -and ($osVersion.Build -lt 22000) }; function Test-IsWindows11 { ($osVersion.Major -gt 10) -or (($osVersion.Major -eq 10) -and ($osVersion.Build -ge 22000)) }; if (($ignoreWindows10 -and (Test-IsWindows10)) -or ($ignoreWindows11 -and (Test-IsWindows11))) {; echo "^""Skipping"^""; exit 0 <# Skip #>; }; if ($warn) {; Write-Warning "^""$message"^""; } else {; Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ------------Disable Bing search in start menu-------------
:: ----------------------------------------------------------
echo --- Disable Bing search in start menu
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' /v 'BingSearchEnabled' /t 'REG_DWORD' /d '0' /f"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $ignoreWindows10 =  $false; $ignoreWindows11 =  $false; $warn =  $false; $osVersion = [System.Environment]::OSVersion.Version; function Test-IsWindows10 { ($osVersion.Major -eq 10) -and ($osVersion.Build -lt 22000) }; function Test-IsWindows11 { ($osVersion.Major -gt 10) -or (($osVersion.Major -eq 10) -and ($osVersion.Build -ge 22000)) }; if (($ignoreWindows10 -and (Test-IsWindows10)) -or ($ignoreWindows11 -and (Test-IsWindows11))) {; echo "^""Skipping"^""; exit 0 <# Skip #>; }; if ($warn) {; Write-Warning "^""$message"^""; } else {; Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -------------Disable web search in search bar-------------
:: ----------------------------------------------------------
echo --- Disable web search in search bar
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search' /v 'DisableWebSearch' /t 'REG_DWORD' /d '1' /f"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $ignoreWindows10 =  $false; $ignoreWindows11 =  $false; $warn =  $false; $osVersion = [System.Environment]::OSVersion.Version; function Test-IsWindows10 { ($osVersion.Major -eq 10) -and ($osVersion.Build -lt 22000) }; function Test-IsWindows11 { ($osVersion.Major -gt 10) -or (($osVersion.Major -eq 10) -and ($osVersion.Build -ge 22000)) }; if (($ignoreWindows10 -and (Test-IsWindows10)) -or ($ignoreWindows11 -and (Test-IsWindows11))) {; echo "^""Skipping"^""; exit 0 <# Skip #>; }; if ($warn) {; Write-Warning "^""$message"^""; } else {; Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----------Disable web results in Windows Search-----------
:: ----------------------------------------------------------
echo --- Disable web results in Windows Search
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search' /v 'ConnectedSearchUseWeb' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search' /v 'ConnectedSearchUseWebOverMeteredConnections' /t 'REG_DWORD' /d '0' /f"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $ignoreWindows10 =  $false; $ignoreWindows11 =  $false; $warn =  $false; $osVersion = [System.Environment]::OSVersion.Version; function Test-IsWindows10 { ($osVersion.Major -eq 10) -and ($osVersion.Build -lt 22000) }; function Test-IsWindows11 { ($osVersion.Major -gt 10) -or (($osVersion.Major -eq 10) -and ($osVersion.Build -ge 22000)) }; if (($ignoreWindows10 -and (Test-IsWindows10)) -or ($ignoreWindows11 -and (Test-IsWindows11))) {; echo "^""Skipping"^""; exit 0 <# Skip #>; }; if ($warn) {; Write-Warning "^""$message"^""; } else {; Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ------------Disable Windows search highlights-------------
:: ----------------------------------------------------------
echo --- Disable Windows search highlights
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search' /v 'EnableDynamicContentInWSB' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\Software\Microsoft\Windows\CurrentVersion\SearchSettings' /v 'IsDynamicSearchBoxEnabled' /t 'REG_DWORD' /d '1' /f"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $ignoreWindows10 =  $false; $ignoreWindows11 =  $false; $warn =  $false; $osVersion = [System.Environment]::OSVersion.Version; function Test-IsWindows10 { ($osVersion.Major -eq 10) -and ($osVersion.Build -lt 22000) }; function Test-IsWindows11 { ($osVersion.Major -gt 10) -or (($osVersion.Major -eq 10) -and ($osVersion.Build -ge 22000)) }; if (($ignoreWindows10 -and (Test-IsWindows10)) -or ($ignoreWindows11 -and (Test-IsWindows11))) {; echo "^""Skipping"^""; exit 0 <# Skip #>; }; if ($warn) {; Write-Warning "^""$message"^""; } else {; Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----------Disable search's access to location------------
:: ----------------------------------------------------------
echo --- Disable search's access to location
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search' /v 'AllowSearchToUseLocation' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' /v 'AllowSearchToUseLocation' /t 'REG_DWORD' /d '1' /f"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $ignoreWindows10 =  $false; $ignoreWindows11 =  $false; $warn =  $false; $osVersion = [System.Environment]::OSVersion.Version; function Test-IsWindows10 { ($osVersion.Major -eq 10) -and ($osVersion.Build -lt 22000) }; function Test-IsWindows11 { ($osVersion.Major -gt 10) -or (($osVersion.Major -eq 10) -and ($osVersion.Build -ge 22000)) }; if (($ignoreWindows10 -and (Test-IsWindows10)) -or ($ignoreWindows11 -and (Test-IsWindows11))) {; echo "^""Skipping"^""; exit 0 <# Skip #>; }; if ($warn) {; Write-Warning "^""$message"^""; } else {; Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -Disable local search history (breaks recent suggestions)-
:: ----------------------------------------------------------
echo --- Disable local search history (breaks recent suggestions)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\Software\Policies\Microsoft\Windows\Explorer' /v 'DisableSearchHistory' /t 'REG_DWORD' /d '1' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\Software\Microsoft\Windows\CurrentVersion\SearchSettings' /v 'IsDeviceSearchHistoryEnabled' /t 'REG_DWORD' /d '1' /f"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $ignoreWindows10 =  $false; $ignoreWindows11 =  $false; $warn =  $false; $osVersion = [System.Environment]::OSVersion.Version; function Test-IsWindows10 { ($osVersion.Major -eq 10) -and ($osVersion.Build -lt 22000) }; function Test-IsWindows11 { ($osVersion.Major -gt 10) -or (($osVersion.Major -eq 10) -and ($osVersion.Build -ge 22000)) }; if (($ignoreWindows10 -and (Test-IsWindows10)) -or ($ignoreWindows11 -and (Test-IsWindows11))) {; echo "^""Skipping"^""; exit 0 <# Skip #>; }; if ($warn) {; Write-Warning "^""$message"^""; } else {; Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ---Disable sharing personal search data with Microsoft----
:: ----------------------------------------------------------
echo --- Disable sharing personal search data with Microsoft
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search' /v 'ConnectedSearchPrivacy' /t 'REG_DWORD' /d '3' /f"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $ignoreWindows10 =  $false; $ignoreWindows11 =  $false; $warn =  $false; $osVersion = [System.Environment]::OSVersion.Version; function Test-IsWindows10 { ($osVersion.Major -eq 10) -and ($osVersion.Build -lt 22000) }; function Test-IsWindows11 { ($osVersion.Major -gt 10) -or (($osVersion.Major -eq 10) -and ($osVersion.Build -ge 22000)) }; if (($ignoreWindows10 -and (Test-IsWindows10)) -or ($ignoreWindows11 -and (Test-IsWindows11))) {; echo "^""Skipping"^""; exit 0 <# Skip #>; }; if ($warn) {; Write-Warning "^""$message"^""; } else {; Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----Disable personal cloud content search in taskbar-----
:: ----------------------------------------------------------
echo --- Disable personal cloud content search in taskbar
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings' /v 'IsMSACloudSearchEnabled' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings' /v 'IsAADCloudSearchEnabled' /t 'REG_DWORD' /d '0' /f"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $ignoreWindows10 =  $false; $ignoreWindows11 =  $false; $warn =  $false; $osVersion = [System.Environment]::OSVersion.Version; function Test-IsWindows10 { ($osVersion.Major -eq 10) -and ($osVersion.Build -lt 22000) }; function Test-IsWindows11 { ($osVersion.Major -gt 10) -or (($osVersion.Major -eq 10) -and ($osVersion.Build -ge 22000)) }; if (($ignoreWindows10 -and (Test-IsWindows10)) -or ($ignoreWindows11 -and (Test-IsWindows11))) {; echo "^""Skipping"^""; exit 0 <# Skip #>; }; if ($warn) {; Write-Warning "^""$message"^""; } else {; Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -------------------Disable Windows Tips-------------------
:: ----------------------------------------------------------
echo --- Disable Windows Tips
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableSoftLanding" /t REG_DWORD /d "1" /f
:: ----------------------------------------------------------


:: Disable Windows Spotlight (shows random wallpapers on lock screen)
echo --- Disable Windows Spotlight (shows random wallpapers on lock screen)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\Software\Policies\Microsoft\Windows\CloudContent' /v 'DisableWindowsSpotlightFeatures' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----------Disable Microsoft Consumer Experiences----------
:: ----------------------------------------------------------
echo --- Disable Microsoft Consumer Experiences
reg add "HKLM\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t "REG_DWORD" /d "1" /f
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -------Disable ad customization with Advertising ID-------
:: ----------------------------------------------------------
echo --- Disable ad customization with Advertising ID
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "0" /f
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo' /v 'DisabledByGroupPolicy' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --------Disable suggested content in Settings app---------
:: ----------------------------------------------------------
echo --- Disable suggested content in Settings app
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /d "0" /t REG_DWORD /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353694Enabled" /d "0" /t REG_DWORD /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353696Enabled" /d "0" /t REG_DWORD /f
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----------------Disable use of biometrics-----------------
:: ----------------------------------------------------------
echo --- Disable use of biometrics
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Biometrics' /v 'Enabled' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----------------Disable biometric logon------------------
:: ----------------------------------------------------------
echo --- Disable biometric logon
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Biometrics\Credential Provider' /v 'Enabled' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----------Disable "Windows Biometric Service"------------
:: ----------------------------------------------------------
echo --- Disable "Windows Biometric Service"
:: Disable service(s): `WbioSrvc`
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'WbioSrvc'; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service `"^""$serviceName`"^"" could not be not found, no need to disable it."^""; Exit 0; }; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if already disabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if(!$startupType) {; $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if(!$startupType) {; $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if($startupType -eq 'Disabled') {; Write-Host "^""$serviceName is already disabled, no further action is needed"^""; }; <# -- 4. Disable service #>; try {; Set-Service -Name "^""$serviceName"^"" -StartupType Disabled -Confirm:$false -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ------------Disable "Windows Insider Service"-------------
:: ----------------------------------------------------------
echo --- Disable "Windows Insider Service"
:: Disable service(s): `wisvc`
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'wisvc'; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service `"^""$serviceName`"^"" could not be not found, no need to disable it."^""; Exit 0; }; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if already disabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if(!$startupType) {; $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if(!$startupType) {; $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if($startupType -eq 'Disabled') {; Write-Host "^""$serviceName is already disabled, no further action is needed"^""; }; <# -- 4. Disable service #>; try {; Set-Service -Name "^""$serviceName"^"" -StartupType Disabled -Confirm:$false -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -------------Disable Microsoft feature trials-------------
:: ----------------------------------------------------------
echo --- Disable Microsoft feature trials
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds' /v 'EnableExperimentation' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds' /v 'EnableConfigFlighting' /t 'REG_DWORD' /d '0' /f"
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\System\AllowExperimentation" /v "value" /t "REG_DWORD" /d 0 /
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --------Disable receipt of Windows preview builds---------
:: ----------------------------------------------------------
echo --- Disable receipt of Windows preview builds
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds' /v 'AllowBuildPreview' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ------Remove "Windows Insider Program" from Settings------
:: ----------------------------------------------------------
echo --- Remove "Windows Insider Program" from Settings
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Microsoft\WindowsSelfHost\UI\Visibility' /v 'HideInsiderPage' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----------Disable all settings synchronization-----------
:: ----------------------------------------------------------
echo --- Disable all settings synchronization
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync' /v 'DisableSettingSync' /t 'REG_DWORD' /d '2' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync' /v 'DisableSettingSyncUserOverride' /t 'REG_DWORD' /d '1' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync' /v 'DisableSyncOnPaidNetwork' /t 'REG_DWORD' /d '1' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync' /v 'SyncPolicy' /t 'REG_DWORD' /d '5' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ------Disable "Application" setting synchronization-------
:: ----------------------------------------------------------
echo --- Disable "Application" setting synchronization
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync' /v 'DisableApplicationSettingSync' /t 'REG_DWORD' /d '2' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync' /v 'DisableApplicationSettingSyncUserOverride' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --------Disable "App Sync" setting synchronization--------
:: ----------------------------------------------------------
echo --- Disable "App Sync" setting synchronization
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync' /v 'DisableAppSyncSettingSync' /t 'REG_DWORD' /d '2' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync' /v 'DisableAppSyncSettingSyncUserOverride' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ------Disable "Credentials" setting synchronization-------
:: ----------------------------------------------------------
echo --- Disable "Credentials" setting synchronization
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync' /v 'DisableCredentialsSettingSync' /t 'REG_DWORD' /d '2' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync' /v 'DisableCredentialsSettingSyncUserOverride' /t 'REG_DWORD' /d '1' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Credentials' /v 'Enabled' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----Disable "Desktop Theme" setting synchronization------
:: ----------------------------------------------------------
echo --- Disable "Desktop Theme" setting synchronization
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync' /v 'DisableDesktopThemeSettingSync' /t 'REG_DWORD' /d '2' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync' /v 'DisableDesktopThemeSettingSyncUserOverride' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----Disable "Personalization" setting synchronization-----
:: ----------------------------------------------------------
echo --- Disable "Personalization" setting synchronization
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync' /v 'DisablePersonalizationSettingSync' /t 'REG_DWORD' /d '2' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync' /v 'DisablePersonalizationSettingSyncUserOverride' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ------Disable "Start Layout" setting synchronization------
:: ----------------------------------------------------------
echo --- Disable "Start Layout" setting synchronization
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync' /v 'DisableStartLayoutSettingSync' /t 'REG_DWORD' /d '2' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync' /v 'DisableStartLayoutSettingSyncUserOverride' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ------Disable "Web Browser" setting synchronization-------
:: ----------------------------------------------------------
echo --- Disable "Web Browser" setting synchronization
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync' /v 'DisableWebBrowserSettingSync' /t 'REG_DWORD' /d '2' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync' /v 'DisableWebBrowserSettingSyncUserOverride' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --------Disable "Windows" setting synchronization---------
:: ----------------------------------------------------------
echo --- Disable "Windows" setting synchronization
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync' /v 'DisableWindowsSettingSync' /t 'REG_DWORD' /d '2' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync' /v 'DisableWindowsSettingSyncUserOverride' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --------Disable "Language" setting synchronization--------
:: ----------------------------------------------------------
echo --- Disable "Language" setting synchronization
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Language' /v 'Enabled' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----------Disable cloud-based speech recognition----------
:: ----------------------------------------------------------
echo --- Disable cloud-based speech recognition
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\Software\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy' /v 'HasAccepted' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----------------------Disable Recall----------------------
:: ----------------------------------------------------------
echo --- Disable Recall
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot' /v 'DisableAIDataAnalysis' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----Disable active probing to Microsoft NCSI server------
:: ----------------------------------------------------------
echo --- Disable active probing to Microsoft NCSI server
reg add "HKLM\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet" /v "EnableActiveProbing" /t "REG_DWORD" /d "0" /f
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ------------Opt out of Windows privacy consent------------
:: ----------------------------------------------------------
echo --- Opt out of Windows privacy consent
reg add "HKCU\SOFTWARE\Microsoft\Personalization\Settings" /v "AcceptedPrivacyPolicy" /t "REG_DWORD" /d "0" /f
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----------Disable Windows feedback collection------------
:: ----------------------------------------------------------
echo --- Disable Windows feedback collection
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\SOFTWARE\Microsoft\Siuf\Rules' /v 'NumberOfSIUFInPeriod' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete "^""HKCU\SOFTWARE\Microsoft\Siuf\Rules"^"" /v "^""PeriodInNanoSeconds"^"" /f 2>nul"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection' /v 'DoNotShowFeedbackNotifications' /t 'REG_DWORD' /d '1' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection' /v 'DoNotShowFeedbackNotifications' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -------Disable text and handwriting data collection-------
:: ----------------------------------------------------------
echo --- Disable text and handwriting data collection
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization' /v 'RestrictImplicitInkCollection' /t 'REG_DWORD' /d '1' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization' /v 'RestrictImplicitTextCollection' /t 'REG_DWORD' /d '1' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\HandwritingErrorReports' /v 'PreventHandwritingErrorReports' /t 'REG_DWORD' /d '1' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\TabletPC' /v 'PreventHandwritingDataSharing' /t 'REG_DWORD' /d '1' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization' /v 'AllowInputPersonalization' /t 'REG_DWORD' /d '0' /f"
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" /v "HarvestContacts" /t REG_DWORD /d 0 /f
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ------------------Disable device sensors------------------
:: ----------------------------------------------------------
echo --- Disable device sensors
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors' /v 'DisableSensors' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -------------------Disable Wi-Fi Sense--------------------
:: ----------------------------------------------------------
echo --- Disable Wi-Fi Sense
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting' /v 'value' /t 'REG_DWORD' /d '0' /f"
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /v "value" /t REG_DWORD /d 0 /f
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config' /v 'AutoConnectAllowedOEM' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----Disable app launch tracking (hides most-used apps)----
:: ----------------------------------------------------------
echo --- Disable app launch tracking (hides most-used apps)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' /v 'Start_TrackProgs' /t 'REG_DWORD' /d '0' /f"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $ignoreWindows10 =  $false; $ignoreWindows11 =  $false; $warn =  $false; $osVersion = [System.Environment]::OSVersion.Version; function Test-IsWindows10 { ($osVersion.Major -eq 10) -and ($osVersion.Build -lt 22000) }; function Test-IsWindows11 { ($osVersion.Major -gt 10) -or (($osVersion.Major -eq 10) -and ($osVersion.Build -ge 22000)) }; if (($ignoreWindows10 -and (Test-IsWindows10)) -or ($ignoreWindows11 -and (Test-IsWindows11))) {; echo "^""Skipping"^""; exit 0 <# Skip #>; }; if ($warn) {; Write-Warning "^""$message"^""; } else {; Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ---------Disable Website Access of Language List----------
:: ----------------------------------------------------------
echo --- Disable Website Access of Language List
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\Control Panel\International\User Profile' /v 'HttpAcceptLanguageOptOut' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --------------Disable Activity Feed feature---------------
:: ----------------------------------------------------------
echo --- Disable Activity Feed feature
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\System' /v 'EnableActivityFeed' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -------Disable typing feedback (sends typing data)--------
:: ----------------------------------------------------------
echo --- Disable typing feedback (sends typing data)
reg add "HKLM\SOFTWARE\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d 0 /f
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ---------Disable internet access for Windows DRM----------
:: ----------------------------------------------------------
echo --- Disable internet access for Windows DRM
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\WMDRM' /v 'DisableOnline' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --------------Disable game screen recording---------------
:: ----------------------------------------------------------
echo --- Disable game screen recording
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR' /v 'AllowGameDVR' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -------------Disable automatic map downloads--------------
:: ----------------------------------------------------------
echo --- Disable automatic map downloads
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Maps' /v 'AllowUntriggeredNetworkTrafficOnSettingsPage' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Maps' /v 'AutoDownloadAndUpdateMapData' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -------Enable strong Diffie-Hellman key requirement-------
:: ----------------------------------------------------------
echo --- Enable strong Diffie-Hellman key requirement
:: Require "Diffie-Hellman" key exchange algorithm to have at "2048" least bits keys for TLS/SSL connections
 reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\KeyExchangeAlgorithms\Diffie-Hellman" /v "ServerMinKeyBitLength" /t "REG_DWORD" /d "2048" /f
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\KeyExchangeAlgorithms\Diffie-Hellman' /v 'ClientMinKeyBitLength' /t 'REG_DWORD' /d '2048' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --Enable strong RSA key requirement (breaks Hyper-V VMs)--
:: ----------------------------------------------------------
echo --- Enable strong RSA key requirement (breaks Hyper-V VMs)
:: Require "PKCS" key exchange algorithm to have at "2048" least bits keys for TLS/SSL connections
:: reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\KeyExchangeAlgorithms\PKCS" /v "ServerMinKeyBitLength" /t "REG_DWORD" /d "2048" /f
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\KeyExchangeAlgorithms\PKCS' /v 'ClientMinKeyBitLength' /t 'REG_DWORD' /d '2048' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --------------Disable insecure "RC2" ciphers--------------
:: ----------------------------------------------------------
echo --- Disable insecure "RC2" ciphers
:: Disable the use of "RC2 40/128" cipher algorithm for TLS/SSL connections
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC2 40/128' /v 'Enabled' /t 'REG_DWORD' /d '0' /f"
:: Disable the use of "RC2 56/128" cipher algorithm for TLS/SSL connections
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC2 56/128' /v 'Enabled' /t 'REG_DWORD' /d '0' /f"
:: Disable the use of "RC2 128/128" cipher algorithm for TLS/SSL connections
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC2 128/128' /v 'Enabled' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --------------Disable insecure "RC4" ciphers--------------
:: ----------------------------------------------------------
echo --- Disable insecure "RC4" ciphers
:: Disable the use of "RC4 128/128" cipher algorithm for TLS/SSL connections
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 128/128' /v 'Enabled' /t 'REG_DWORD' /d '0' /f"
:: Disable the use of "RC4 64/128" cipher algorithm for TLS/SSL connections
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 64/128' /v 'Enabled' /t 'REG_DWORD' /d '0' /f"
:: Disable the use of "RC4 56/128" cipher algorithm for TLS/SSL connections
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 56/128' /v 'Enabled' /t 'REG_DWORD' /d '0' /f"
:: Disable the use of "RC4 40/128" cipher algorithm for TLS/SSL connections
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 40/128' /v 'Enabled' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --------------Disable insecure "DES" cipher---------------
:: ----------------------------------------------------------
echo --- Disable insecure "DES" cipher
:: Disable the use of "DES 56/56" cipher algorithm for TLS/SSL connections
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\DES 56/56' /v 'Enabled' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----------Disable insecure "Triple DES" cipher-----------
:: ----------------------------------------------------------
echo --- Disable insecure "Triple DES" cipher
:: Disable the use of "Triple DES 168" cipher algorithm for TLS/SSL connections
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\Triple DES 168' /v 'Enabled' /t 'REG_DWORD' /d '0' /f"
:: Disable the use of "Triple DES 168/168" cipher algorithm for TLS/SSL connections
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\Triple DES 168/168' /v 'Enabled' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --------------Disable insecure "NULL" cipher--------------
:: ----------------------------------------------------------
echo --- Disable insecure "NULL" cipher
:: Disable the use of "NULL" cipher algorithm for TLS/SSL connections
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\NULL' /v 'Enabled' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ---------------Disable insecure "MD5" hash----------------
:: ----------------------------------------------------------
echo --- Disable insecure "MD5" hash
:: Disable usage of "MD5" hash algorithm for TLS/SSL connections
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Hashes\MD5' /v 'Enabled' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --------------Disable insecure "SHA-1" hash---------------
:: ----------------------------------------------------------
echo --- Disable insecure "SHA-1" hash
:: Disable usage of "SHA" hash algorithm for TLS/SSL connections
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Hashes\SHA' /v 'Enabled' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ------------Disable insecure "SMBv1" protocol-------------
:: ----------------------------------------------------------
echo --- Disable insecure "SMBv1" protocol
:: Disable the "SMB1Protocol" feature
PowerShell -ExecutionPolicy Unrestricted -Command "$featureName = 'SMB1Protocol'; $feature = Get-WindowsOptionalFeature -FeatureName "^""$featureName"^"" -Online -ErrorAction Stop; if (-Not $feature) {; Write-Output "^""Skipping: The feature `"^""$featureName`"^"" is not found. No action required."^""; Exit 0; }; if ($feature.State -eq [Microsoft.Dism.Commands.FeatureState]::Disabled) {; Write-Output "^""Skipping: The feature `"^""$featureName`"^"" is already disabled. No action required."^""; Exit 0; }; try {; Write-Host "^""Disabling feature: `"^""$featureName`"^""."^""; Disable-WindowsOptionalFeature -FeatureName "^""$featureName"^"" -Online -NoRestart -LogLevel ([Microsoft.Dism.Commands.LogLevel]::Errors) -WarningAction SilentlyContinue -ErrorAction Stop | Out-Null; } catch {; Write-Error "^""Failed to disable the feature `"^""$featureName`"^"": $($_.Exception.Message)"^""; Exit 1; }; Write-Output "^""Successfully disabled the feature `"^""$featureName`"^""."^""; Exit 0"
:: Disable the "SMB1Protocol-Client" feature
PowerShell -ExecutionPolicy Unrestricted -Command "$featureName = 'SMB1Protocol-Client'; $feature = Get-WindowsOptionalFeature -FeatureName "^""$featureName"^"" -Online -ErrorAction Stop; if (-Not $feature) {; Write-Output "^""Skipping: The feature `"^""$featureName`"^"" is not found. No action required."^""; Exit 0; }; if ($feature.State -eq [Microsoft.Dism.Commands.FeatureState]::Disabled) {; Write-Output "^""Skipping: The feature `"^""$featureName`"^"" is already disabled. No action required."^""; Exit 0; }; try {; Write-Host "^""Disabling feature: `"^""$featureName`"^""."^""; Disable-WindowsOptionalFeature -FeatureName "^""$featureName"^"" -Online -NoRestart -LogLevel ([Microsoft.Dism.Commands.LogLevel]::Errors) -WarningAction SilentlyContinue -ErrorAction Stop | Out-Null; } catch {; Write-Error "^""Failed to disable the feature `"^""$featureName`"^"": $($_.Exception.Message)"^""; Exit 1; }; Write-Output "^""Successfully disabled the feature `"^""$featureName`"^""."^""; Exit 0"
:: Disable the "SMB1Protocol-Server" feature
PowerShell -ExecutionPolicy Unrestricted -Command "$featureName = 'SMB1Protocol-Server'; $feature = Get-WindowsOptionalFeature -FeatureName "^""$featureName"^"" -Online -ErrorAction Stop; if (-Not $feature) {; Write-Output "^""Skipping: The feature `"^""$featureName`"^"" is not found. No action required."^""; Exit 0; }; if ($feature.State -eq [Microsoft.Dism.Commands.FeatureState]::Disabled) {; Write-Output "^""Skipping: The feature `"^""$featureName`"^"" is already disabled. No action required."^""; Exit 0; }; try {; Write-Host "^""Disabling feature: `"^""$featureName`"^""."^""; Disable-WindowsOptionalFeature -FeatureName "^""$featureName"^"" -Online -NoRestart -LogLevel ([Microsoft.Dism.Commands.LogLevel]::Errors) -WarningAction SilentlyContinue -ErrorAction Stop | Out-Null; } catch {; Write-Error "^""Failed to disable the feature `"^""$featureName`"^"": $($_.Exception.Message)"^""; Exit 1; }; Write-Output "^""Successfully disabled the feature `"^""$featureName`"^""."^""; Exit 0"
:: Disable service(s): `mrxsmb10`
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'mrxsmb10'; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service `"^""$serviceName`"^"" could not be not found, no need to disable it."^""; Exit 0; }; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, stopping it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if already disabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if(!$startupType) {; $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if(!$startupType) {; $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if($startupType -eq 'Disabled') {; Write-Host "^""$serviceName is already disabled, no further action is needed"^""; }; <# -- 4. Disable service #>; try {; Set-Service -Name "^""$serviceName"^"" -StartupType Disabled -Confirm:$false -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }"
sc.exe config lanmanworkstation depend= bowser/mrxsmb20/nsi
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters' /v 'SMBv1' /t 'REG_DWORD' /d '0' /f"
:: Suggest restarting computer for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'For the changes to fully take effect, please restart your computer.'; $ignoreWindows10 =  $false; $ignoreWindows11 =  $false; $warn =  $false; $osVersion = [System.Environment]::OSVersion.Version; function Test-IsWindows10 { ($osVersion.Major -eq 10) -and ($osVersion.Build -lt 22000) }; function Test-IsWindows11 { ($osVersion.Major -gt 10) -or (($osVersion.Major -eq 10) -and ($osVersion.Build -ge 22000)) }; if (($ignoreWindows10 -and (Test-IsWindows10)) -or ($ignoreWindows11 -and (Test-IsWindows11))) {; echo "^""Skipping"^""; exit 0 <# Skip #>; }; if ($warn) {; Write-Warning "^""$message"^""; } else {; Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----------Disable insecure "NetBios" protocol------------
:: ----------------------------------------------------------
echo --- Disable insecure "NetBios" protocol
PowerShell -ExecutionPolicy Unrestricted -Command "$key = 'HKLM:SYSTEM\CurrentControlSet\services\NetBT\Parameters\Interfaces'; Get-ChildItem $key | ForEach {; Set-ItemProperty -Path "^""$key\$($_.PSChildName)"^"" -Name NetbiosOptions -Value 2 -Verbose; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----------Disable insecure "SSL 2.0" protocol------------
:: ----------------------------------------------------------
echo --- Disable insecure "SSL 2.0" protocol
:: Disable usage of "SSL 2.0" protocol for TLS/SSL connections
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Server' /v 'Enabled' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Server' /v 'DisabledByDefault' /t 'REG_DWORD' /d '1' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Client' /v 'Enabled' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Client' /v 'DisabledByDefault' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----------Disable insecure "SSL 3.0" protocol------------
:: ----------------------------------------------------------
echo --- Disable insecure "SSL 3.0" protocol
:: Disable usage of "SSL 3.0" protocol for TLS/SSL connections
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server' /v 'Enabled' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server' /v 'DisabledByDefault' /t 'REG_DWORD' /d '1' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Client' /v 'Enabled' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Client' /v 'DisabledByDefault' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----------Disable insecure "TLS 1.0" protocol------------
:: ----------------------------------------------------------
echo --- Disable insecure "TLS 1.0" protocol
:: Disable usage of "TLS 1.0" protocol for TLS/SSL connections
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server' /v 'Enabled' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server' /v 'DisabledByDefault' /t 'REG_DWORD' /d '1' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client' /v 'Enabled' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client' /v 'DisabledByDefault' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----------Disable insecure "TLS 1.1" protocol------------
:: ----------------------------------------------------------
echo --- Disable insecure "TLS 1.1" protocol
:: Disable usage of "TLS 1.1" protocol for TLS/SSL connections
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server' /v 'Enabled' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server' /v 'DisabledByDefault' /t 'REG_DWORD' /d '1' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client' /v 'Enabled' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client' /v 'DisabledByDefault' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----------Disable insecure "DTLS 1.0" protocol-----------
:: ----------------------------------------------------------
echo --- Disable insecure "DTLS 1.0" protocol
:: Disable usage of "DTLS 1.0" protocol for TLS/SSL connections
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\DTLS 1.0\Server' /v 'Enabled' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\DTLS 1.0\Server' /v 'DisabledByDefault' /t 'REG_DWORD' /d '1' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\DTLS 1.0\Client' /v 'Enabled' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\DTLS 1.0\Client' /v 'DisabledByDefault' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----------Disable insecure "LM & NTLM" protocols----------
:: ----------------------------------------------------------
echo --- Disable insecure "LM ^& NTLM" protocols
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Control\Lsa' /v 'LmCompatibilityLevel' /t 'REG_DWORD' /d '5' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --------------Disable insecure renegotiation--------------
:: ----------------------------------------------------------
echo --- Disable insecure renegotiation
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL' /v 'AllowInsecureRenegoClients' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL' /v 'AllowInsecureRenegoServers' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL' /v 'DisableRenegoOnServer' /t 'REG_DWORD' /d '1' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL' /v 'DisableRenegoOnClient' /t 'REG_DWORD' /d '1' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL' /v 'UseScsvForTls' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -------Disable insecure connections from .NET apps--------
:: ----------------------------------------------------------
echo --- Disable insecure connections from .NET apps
:: Configure "SchUseStrongCrypto" for .NET applications
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Microsoft\.NETFramework\v2.0.50727' /v 'SchUseStrongCrypto' /t 'REG_DWORD' /d '1' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v2.0.50727' /v 'SchUseStrongCrypto' /t 'REG_DWORD' /d '1' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Microsoft\.NETFramework\v4.0.30319' /v 'SchUseStrongCrypto' /t 'REG_DWORD' /d '1' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v4.0.30319' /v 'SchUseStrongCrypto' /t 'REG_DWORD' /d '1' /f"
:: Suggest restarting computer for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'For the changes to fully take effect, please restart your computer.'; $ignoreWindows10 =  $false; $ignoreWindows11 =  $false; $warn =  $false; $osVersion = [System.Environment]::OSVersion.Version; function Test-IsWindows10 { ($osVersion.Major -eq 10) -and ($osVersion.Build -lt 22000) }; function Test-IsWindows11 { ($osVersion.Major -gt 10) -or (($osVersion.Major -eq 10) -and ($osVersion.Build -ge 22000)) }; if (($ignoreWindows10 -and (Test-IsWindows10)) -or ($ignoreWindows11 -and (Test-IsWindows11))) {; echo "^""Skipping"^""; exit 0 <# Skip #>; }; if ($warn) {; Write-Warning "^""$message"^""; } else {; Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ------------Enable secure "DTLS 1.2" protocol-------------
:: ----------------------------------------------------------
echo --- Enable secure "DTLS 1.2" protocol
:: Enable "DTLS 1.2" protocol as default for TLS/SSL connections
PowerShell -ExecutionPolicy Unrestricted -Command "$targetWindowsVersion = 'Windows10-1607'; $parsedVersion=$null; if ($targetWindowsVersion -eq 'Windows11') {; $parsedVersion=[System.Version]::Parse('10.0.22000'); } elseif ($targetWindowsVersion -eq 'Windows10-1607') {; $parsedVersion=[System.Version]::Parse('10.0.14393'); }; if ([System.Environment]::OSVersion.Version -lt $parsedVersion) {; Write-Output "^""Skipping, versions before $parsedVersion are not supported."^""; exit 0; }; reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\DTLS 1.2\Server' /v 'Enabled' /t 'REG_DWORD' /d '1' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "$targetWindowsVersion = 'Windows10-1607'; $parsedVersion=$null; if ($targetWindowsVersion -eq 'Windows11') {; $parsedVersion=[System.Version]::Parse('10.0.22000'); } elseif ($targetWindowsVersion -eq 'Windows10-1607') {; $parsedVersion=[System.Version]::Parse('10.0.14393'); }; if ([System.Environment]::OSVersion.Version -lt $parsedVersion) {; Write-Output "^""Skipping, versions before $parsedVersion are not supported."^""; exit 0; }; reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\DTLS 1.2\Server' /v 'DisabledByDefault' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "$targetWindowsVersion = 'Windows10-1607'; $parsedVersion=$null; if ($targetWindowsVersion -eq 'Windows11') {; $parsedVersion=[System.Version]::Parse('10.0.22000'); } elseif ($targetWindowsVersion -eq 'Windows10-1607') {; $parsedVersion=[System.Version]::Parse('10.0.14393'); }; if ([System.Environment]::OSVersion.Version -lt $parsedVersion) {; Write-Output "^""Skipping, versions before $parsedVersion are not supported."^""; exit 0; }; reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\DTLS 1.2\Client' /v 'Enabled' /t 'REG_DWORD' /d '1' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "$targetWindowsVersion = 'Windows10-1607'; $parsedVersion=$null; if ($targetWindowsVersion -eq 'Windows11') {; $parsedVersion=[System.Version]::Parse('10.0.22000'); } elseif ($targetWindowsVersion -eq 'Windows10-1607') {; $parsedVersion=[System.Version]::Parse('10.0.14393'); }; if ([System.Environment]::OSVersion.Version -lt $parsedVersion) {; Write-Output "^""Skipping, versions before $parsedVersion are not supported."^""; exit 0; }; reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\DTLS 1.2\Client' /v 'DisabledByDefault' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -------------Enable secure "TLS 1.3" protocol-------------
:: ----------------------------------------------------------
echo --- Enable secure "TLS 1.3" protocol
:: Enable "TLS 1.3" protocol as default for TLS/SSL connections
PowerShell -ExecutionPolicy Unrestricted -Command "$targetWindowsVersion = 'Windows11'; $parsedVersion=$null; if ($targetWindowsVersion -eq 'Windows11') {; $parsedVersion=[System.Version]::Parse('10.0.22000'); } elseif ($targetWindowsVersion -eq 'Windows10-1607') {; $parsedVersion=[System.Version]::Parse('10.0.14393'); }; if ([System.Environment]::OSVersion.Version -lt $parsedVersion) {; Write-Output "^""Skipping, versions before $parsedVersion are not supported."^""; exit 0; }; reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.3\Server' /v 'Enabled' /t 'REG_DWORD' /d '1' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "$targetWindowsVersion = 'Windows11'; $parsedVersion=$null; if ($targetWindowsVersion -eq 'Windows11') {; $parsedVersion=[System.Version]::Parse('10.0.22000'); } elseif ($targetWindowsVersion -eq 'Windows10-1607') {; $parsedVersion=[System.Version]::Parse('10.0.14393'); }; if ([System.Environment]::OSVersion.Version -lt $parsedVersion) {; Write-Output "^""Skipping, versions before $parsedVersion are not supported."^""; exit 0; }; reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.3\Server' /v 'DisabledByDefault' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "$targetWindowsVersion = 'Windows11'; $parsedVersion=$null; if ($targetWindowsVersion -eq 'Windows11') {; $parsedVersion=[System.Version]::Parse('10.0.22000'); } elseif ($targetWindowsVersion -eq 'Windows10-1607') {; $parsedVersion=[System.Version]::Parse('10.0.14393'); }; if ([System.Environment]::OSVersion.Version -lt $parsedVersion) {; Write-Output "^""Skipping, versions before $parsedVersion are not supported."^""; exit 0; }; reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.3\Client' /v 'Enabled' /t 'REG_DWORD' /d '1' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "$targetWindowsVersion = 'Windows11'; $parsedVersion=$null; if ($targetWindowsVersion -eq 'Windows11') {; $parsedVersion=[System.Version]::Parse('10.0.22000'); } elseif ($targetWindowsVersion -eq 'Windows10-1607') {; $parsedVersion=[System.Version]::Parse('10.0.14393'); }; if ([System.Environment]::OSVersion.Version -lt $parsedVersion) {; Write-Output "^""Skipping, versions before $parsedVersion are not supported."^""; exit 0; }; reg add 'HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.3\Client' /v 'DisabledByDefault' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ------Enable secure connections for legacy .NET apps------
:: ----------------------------------------------------------
echo --- Enable secure connections for legacy .NET apps
:: Configure "SystemDefaultTlsVersions" for .NET applications
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Microsoft\.NETFramework\v2.0.50727' /v 'SystemDefaultTlsVersions' /t 'REG_DWORD' /d '1' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v2.0.50727' /v 'SystemDefaultTlsVersions' /t 'REG_DWORD' /d '1' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Microsoft\.NETFramework\v4.0.30319' /v 'SystemDefaultTlsVersions' /t 'REG_DWORD' /d '1' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v4.0.30319' /v 'SystemDefaultTlsVersions' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----------Disable basic authentication in WinRM-----------
:: ----------------------------------------------------------
echo --- Disable basic authentication in WinRM
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client' /v 'AllowBasic' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: Disable unauthorized user account discovery (anonymous SAM enumeration)
echo --- Disable unauthorized user account discovery (anonymous SAM enumeration)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v "RestrictAnonymousSAM" /t REG_DWORD /d 1 /f
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----Disable anonymous access to named pipes and shares----
:: ----------------------------------------------------------
echo --- Disable anonymous access to named pipes and shares
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters" /v "RestrictNullSessAccess" /t REG_DWORD /d 1 /f
:: ----------------------------------------------------------


:: Disable hidden remote file access via administrative shares (breaks remote system management software)
echo --- Disable hidden remote file access via administrative shares (breaks remote system management software)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters' /v 'AutoShareWks' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ---------Disable anonymous enumeration of shares----------
:: ----------------------------------------------------------
echo --- Disable anonymous enumeration of shares
reg add "HKLM\SYSTEM\CurrentControlSet\Control\LSA" /v "RestrictAnonymous" /t REG_DWORD /d "1" /f
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -------------Disable "Telnet Client" feature--------------
:: ----------------------------------------------------------
echo --- Disable "Telnet Client" feature
:: Disable the "TelnetClient" feature
PowerShell -ExecutionPolicy Unrestricted -Command "$featureName = 'TelnetClient'; $feature = Get-WindowsOptionalFeature -FeatureName "^""$featureName"^"" -Online -ErrorAction Stop; if (-Not $feature) {; Write-Output "^""Skipping: The feature `"^""$featureName`"^"" is not found. No action required."^""; Exit 0; }; if ($feature.State -eq [Microsoft.Dism.Commands.FeatureState]::Disabled) {; Write-Output "^""Skipping: The feature `"^""$featureName`"^"" is already disabled. No action required."^""; Exit 0; }; try {; Write-Host "^""Disabling feature: `"^""$featureName`"^""."^""; Disable-WindowsOptionalFeature -FeatureName "^""$featureName"^"" -Online -NoRestart -LogLevel ([Microsoft.Dism.Commands.LogLevel]::Errors) -WarningAction SilentlyContinue -ErrorAction Stop | Out-Null; } catch {; Write-Error "^""Failed to disable the feature `"^""$featureName`"^"": $($_.Exception.Message)"^""; Exit 1; }; Write-Output "^""Successfully disabled the feature `"^""$featureName`"^""."^""; Exit 0"
:: ----------------------------------------------------------


:: Remove "RAS Connection Manager Administration Kit (CMAK)" capability
echo --- Remove "RAS Connection Manager Administration Kit (CMAK)" capability
PowerShell -ExecutionPolicy Unrestricted -Command "Get-WindowsCapability -Online -Name 'RasCMAK.Client*' | Remove-WindowsCapability -Online"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --------Disable Windows Remote Assistance feature---------
:: ----------------------------------------------------------
echo --- Disable Windows Remote Assistance feature
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowFullControl" /t REG_DWORD /d 0 /f
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services' /v 'AllowBasic' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----------Disable "Net.TCP Port Sharing" feature----------
:: ----------------------------------------------------------
echo --- Disable "Net.TCP Port Sharing" feature
:: Disable the "WCF-TCP-PortSharing45" feature
PowerShell -ExecutionPolicy Unrestricted -Command "$featureName = 'WCF-TCP-PortSharing45'; $feature = Get-WindowsOptionalFeature -FeatureName "^""$featureName"^"" -Online -ErrorAction Stop; if (-Not $feature) {; Write-Output "^""Skipping: The feature `"^""$featureName`"^"" is not found. No action required."^""; Exit 0; }; if ($feature.State -eq [Microsoft.Dism.Commands.FeatureState]::Disabled) {; Write-Output "^""Skipping: The feature `"^""$featureName`"^"" is already disabled. No action required."^""; Exit 0; }; try {; Write-Host "^""Disabling feature: `"^""$featureName`"^""."^""; Disable-WindowsOptionalFeature -FeatureName "^""$featureName"^"" -Online -NoRestart -LogLevel ([Microsoft.Dism.Commands.LogLevel]::Errors) -WarningAction SilentlyContinue -ErrorAction Stop | Out-Null; } catch {; Write-Error "^""Failed to disable the feature `"^""$featureName`"^"": $($_.Exception.Message)"^""; Exit 1; }; Write-Output "^""Successfully disabled the feature `"^""$featureName`"^""."^""; Exit 0"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ---------------Disable "SMB Direct" feature---------------
:: ----------------------------------------------------------
echo --- Disable "SMB Direct" feature
:: Disable the "SmbDirect" feature
PowerShell -ExecutionPolicy Unrestricted -Command "$featureName = 'SmbDirect'; $feature = Get-WindowsOptionalFeature -FeatureName "^""$featureName"^"" -Online -ErrorAction Stop; if (-Not $feature) {; Write-Output "^""Skipping: The feature `"^""$featureName`"^"" is not found. No action required."^""; Exit 0; }; if ($feature.State -eq [Microsoft.Dism.Commands.FeatureState]::Disabled) {; Write-Output "^""Skipping: The feature `"^""$featureName`"^"" is already disabled. No action required."^""; Exit 0; }; try {; Write-Host "^""Disabling feature: `"^""$featureName`"^""."^""; Disable-WindowsOptionalFeature -FeatureName "^""$featureName"^"" -Online -NoRestart -LogLevel ([Microsoft.Dism.Commands.LogLevel]::Errors) -WarningAction SilentlyContinue -ErrorAction Stop | Out-Null; } catch {; Write-Error "^""Failed to disable the feature `"^""$featureName`"^"": $($_.Exception.Message)"^""; Exit 1; }; Write-Output "^""Successfully disabled the feature `"^""$featureName`"^""."^""; Exit 0"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --------------Disable "TFTP Client" feature---------------
:: ----------------------------------------------------------
echo --- Disable "TFTP Client" feature
:: Disable the "TFTP" feature
PowerShell -ExecutionPolicy Unrestricted -Command "$featureName = 'TFTP'; $feature = Get-WindowsOptionalFeature -FeatureName "^""$featureName"^"" -Online -ErrorAction Stop; if (-Not $feature) {; Write-Output "^""Skipping: The feature `"^""$featureName`"^"" is not found. No action required."^""; Exit 0; }; if ($feature.State -eq [Microsoft.Dism.Commands.FeatureState]::Disabled) {; Write-Output "^""Skipping: The feature `"^""$featureName`"^"" is already disabled. No action required."^""; Exit 0; }; try {; Write-Host "^""Disabling feature: `"^""$featureName`"^""."^""; Disable-WindowsOptionalFeature -FeatureName "^""$featureName"^"" -Online -NoRestart -LogLevel ([Microsoft.Dism.Commands.LogLevel]::Errors) -WarningAction SilentlyContinue -ErrorAction Stop | Out-Null; } catch {; Write-Error "^""Failed to disable the feature `"^""$featureName`"^"": $($_.Exception.Message)"^""; Exit 1; }; Write-Output "^""Successfully disabled the feature `"^""$featureName`"^""."^""; Exit 0"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -------------Remove "RIP Listener" capability-------------
:: ----------------------------------------------------------
echo --- Remove "RIP Listener" capability
PowerShell -ExecutionPolicy Unrestricted -Command "Get-WindowsCapability -Online -Name 'RIP.Listener*' | Remove-WindowsCapability -Online"
:: ----------------------------------------------------------


:: Remove "Simple Network Management Protocol (SNMP)" capability
echo --- Remove "Simple Network Management Protocol (SNMP)" capability
PowerShell -ExecutionPolicy Unrestricted -Command "Get-WindowsCapability -Online -Name 'SNMP.Client*' | Remove-WindowsCapability -Online"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----------Remove "SNMP WMI Provider" capability-----------
:: ----------------------------------------------------------
echo --- Remove "SNMP WMI Provider" capability
PowerShell -ExecutionPolicy Unrestricted -Command "Get-WindowsCapability -Online -Name 'WMI-SNMP-Provider.Client*' | Remove-WindowsCapability -Online"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----Disable Cloud Clipboard (breaks clipboard sync)------
:: ----------------------------------------------------------
echo --- Disable Cloud Clipboard (breaks clipboard sync)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\System' /v 'AllowCrossDeviceClipboard' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\Software\Microsoft\Clipboard' /v 'CloudClipboardAutomaticUpload' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----------------Disable clipboard history-----------------
:: ----------------------------------------------------------
echo --- Disable clipboard history
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\Software\Microsoft\Clipboard' /v 'EnableClipboardHistory' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\System' /v 'AllowClipboardHistory' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: Disable background clipboard data collection (`cbdhsvc`) (breaks clipboard history and sync)
echo --- Disable background clipboard data collection (`cbdhsvc`) (breaks clipboard history and sync)
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceQuery = 'cbdhsvc'; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceQuery -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service query `"^""$serviceQuery`"^"" did not yield any results, no need to disable it."^""; Exit 0; }; $serviceName = $service.Name; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, trying to stop it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if service info is not found in registry #>; $registryKey = "^""HKLM:\SYSTEM\CurrentControlSet\Services\$serviceName"^""; if(!(Test-Path $registryKey)) {; Write-Host "^""`"^""$registryKey`"^"" is not found in registry, cannot enable it."^""; Exit 0; }; <# -- 4. Skip if already disabled #>; if( $(Get-ItemProperty -Path "^""$registryKey"^"").Start -eq 4) {; Write-Host "^""`"^""$serviceName`"^"" is already disabled from start, no further action is needed."^""; Exit 0; }; <# -- 5. Disable service #>; try {; Set-ItemProperty $registryKey -Name Start -Value 4 -Force -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }"
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceQuery = 'cbdhsvc_*'; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceQuery -ErrorAction SilentlyContinue; if(!$service) {; Write-Host "^""Service query `"^""$serviceQuery`"^"" did not yield any results, no need to disable it."^""; Exit 0; }; $serviceName = $service.Name; Write-Host "^""Disabling service: `"^""$serviceName`"^""."^""; <# -- 2. Stop if running #>; if ($service.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is running, trying to stop it."^""; try {; Stop-Service -Name "^""$serviceName"^"" -Force -ErrorAction Stop; Write-Host "^""Stopped `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not stop `"^""$serviceName`"^"", it will be stopped after reboot: $_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is not running, no need to stop."^""; }; <# -- 3. Skip if service info is not found in registry #>; $registryKey = "^""HKLM:\SYSTEM\CurrentControlSet\Services\$serviceName"^""; if(!(Test-Path $registryKey)) {; Write-Host "^""`"^""$registryKey`"^"" is not found in registry, cannot enable it."^""; Exit 0; }; <# -- 4. Skip if already disabled #>; if( $(Get-ItemProperty -Path "^""$registryKey"^"").Start -eq 4) {; Write-Host "^""`"^""$serviceName`"^"" is already disabled from start, no further action is needed."^""; Exit 0; }; <# -- 5. Disable service #>; try {; Set-ItemProperty $registryKey -Name Start -Value 4 -Force -ErrorAction Stop; Write-Host "^""Disabled `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Error "^""Could not disable `"^""$serviceName`"^"": $_"^""; }"
:: ----------------------------------------------------------


:: Mitigate Spectre Variant 2 and Meltdown in host operating system
echo --- Mitigate Spectre Variant 2 and Meltdown in host operating system
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d 3 /f
wmic cpu get name | findstr "Intel" >nul && (
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /t REG_DWORD /d 0 /f
)
wmic cpu get name | findstr "AMD" >nul && (
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /t REG_DWORD /d 64 /f
)
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----Mitigate Spectre Variant 2 and Meltdown in Hyper-V----
:: ----------------------------------------------------------
echo --- Mitigate Spectre Variant 2 and Meltdown in Hyper-V
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Virtualization' /v 'MinVmVersionForCpuBasedMitigations' /t 'REG_SZ' /d '1.0' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----------Enable Data Execution Prevention (DEP)----------
:: ----------------------------------------------------------
echo --- Enable Data Execution Prevention (DEP)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer' /v 'NoDataExecutionPrevention' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\System' /v 'DisableHHDEP' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ---------------Disable AutoPlay and AutoRun---------------
:: ----------------------------------------------------------
echo --- Disable AutoPlay and AutoRun
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer' /v 'NoDriveTypeAutoRun' /t 'REG_DWORD' /d '255' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer' /v 'NoAutorun' /t 'REG_DWORD' /d '1' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer' /v 'NoAutoplayfornonVolume' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ------------Disable lock screen camera access-------------
:: ----------------------------------------------------------
echo --- Disable lock screen camera access
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization' /v 'NoLockScreenCamera' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----Disable storage of the LAN Manager password hashes----
:: ----------------------------------------------------------
echo --- Disable storage of the LAN Manager password hashes
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v "NoLMHash" /t REG_DWORD /d "1" /f
:: ----------------------------------------------------------


:: Disable "Always install with elevated privileges" in Windows Installer
echo --- Disable "Always install with elevated privileges" in Windows Installer
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Installer' /v 'AlwaysInstallElevated' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: Enable Structured Exception Handling Overwrite Protection (SEHOP)
echo --- Enable Structured Exception Handling Overwrite Protection (SEHOP)
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel' /v 'DisableExceptionChainValidation' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -Enable security against PowerShell 2.0 downgrade attacks-
:: ----------------------------------------------------------
echo --- Enable security against PowerShell 2.0 downgrade attacks
:: Disable the "MicrosoftWindowsPowerShellV2" feature
PowerShell -ExecutionPolicy Unrestricted -Command "$featureName = 'MicrosoftWindowsPowerShellV2'; $feature = Get-WindowsOptionalFeature -FeatureName "^""$featureName"^"" -Online -ErrorAction Stop; if (-Not $feature) {; Write-Output "^""Skipping: The feature `"^""$featureName`"^"" is not found. No action required."^""; Exit 0; }; if ($feature.State -eq [Microsoft.Dism.Commands.FeatureState]::Disabled) {; Write-Output "^""Skipping: The feature `"^""$featureName`"^"" is already disabled. No action required."^""; Exit 0; }; try {; Write-Host "^""Disabling feature: `"^""$featureName`"^""."^""; Disable-WindowsOptionalFeature -FeatureName "^""$featureName"^"" -Online -NoRestart -LogLevel ([Microsoft.Dism.Commands.LogLevel]::Errors) -WarningAction SilentlyContinue -ErrorAction Stop | Out-Null; } catch {; Write-Error "^""Failed to disable the feature `"^""$featureName`"^"": $($_.Exception.Message)"^""; Exit 1; }; Write-Output "^""Successfully disabled the feature `"^""$featureName`"^""."^""; Exit 0"
:: Disable the "MicrosoftWindowsPowerShellV2Root" feature
PowerShell -ExecutionPolicy Unrestricted -Command "$featureName = 'MicrosoftWindowsPowerShellV2Root'; $feature = Get-WindowsOptionalFeature -FeatureName "^""$featureName"^"" -Online -ErrorAction Stop; if (-Not $feature) {; Write-Output "^""Skipping: The feature `"^""$featureName`"^"" is not found. No action required."^""; Exit 0; }; if ($feature.State -eq [Microsoft.Dism.Commands.FeatureState]::Disabled) {; Write-Output "^""Skipping: The feature `"^""$featureName`"^"" is already disabled. No action required."^""; Exit 0; }; try {; Write-Host "^""Disabling feature: `"^""$featureName`"^""."^""; Disable-WindowsOptionalFeature -FeatureName "^""$featureName"^"" -Online -NoRestart -LogLevel ([Microsoft.Dism.Commands.LogLevel]::Errors) -WarningAction SilentlyContinue -ErrorAction Stop | Out-Null; } catch {; Write-Error "^""Failed to disable the feature `"^""$featureName`"^"": $($_.Exception.Message)"^""; Exit 1; }; Write-Output "^""Successfully disabled the feature `"^""$featureName`"^""."^""; Exit 0"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----------Disable "Windows Connect Now" wizard-----------
:: ----------------------------------------------------------
echo --- Disable "Windows Connect Now" wizard
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\Software\Policies\Microsoft\Windows\WCN\UI' /v 'DisableWcnUi' /t 'REG_DWORD' /d '1' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WCN\Registrars' /v 'DisableFlashConfigRegistrar' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WCN\Registrars' /v 'DisableInBand802DOT11Registrar' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WCN\Registrars' /v 'DisableUPnPRegistrar' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WCN\Registrars' /v 'DisableWPDRegistrar' /t 'REG_DWORD' /d '0' /f"
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WCN\Registrars' /v 'EnableRegistrars' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --------------Block Dropbox telemetry hosts---------------
:: ----------------------------------------------------------
echo --- Block Dropbox telemetry hosts
:: Add hosts entries for telemetry.dropbox.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='telemetry.dropbox.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for telemetry.v.dropbox.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='telemetry.v.dropbox.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --------------Block Spotify Live Tile hosts---------------
:: ----------------------------------------------------------
echo --- Block Spotify Live Tile hosts
:: Add hosts entries for spclient.wg.spotify.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='spclient.wg.spotify.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -------------Block Windows crash report hosts-------------
:: ----------------------------------------------------------
echo --- Block Windows crash report hosts
:: Add hosts entries for oca.telemetry.microsoft.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='oca.telemetry.microsoft.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for oca.microsoft.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='oca.microsoft.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for kmwatsonc.events.data.microsoft.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='kmwatsonc.events.data.microsoft.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----------Block Windows error reporting hosts------------
:: ----------------------------------------------------------
echo --- Block Windows error reporting hosts
:: Add hosts entries for watson.telemetry.microsoft.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='watson.telemetry.microsoft.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for umwatsonc.events.data.microsoft.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='umwatsonc.events.data.microsoft.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for ceuswatcab01.blob.core.windows.net
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='ceuswatcab01.blob.core.windows.net'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for ceuswatcab02.blob.core.windows.net
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='ceuswatcab02.blob.core.windows.net'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for eaus2watcab01.blob.core.windows.net
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='eaus2watcab01.blob.core.windows.net'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for eaus2watcab02.blob.core.windows.net
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='eaus2watcab02.blob.core.windows.net'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for weus2watcab01.blob.core.windows.net
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='weus2watcab01.blob.core.windows.net'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for weus2watcab02.blob.core.windows.net
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='weus2watcab02.blob.core.windows.net'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for co4.telecommand.telemetry.microsoft.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='co4.telecommand.telemetry.microsoft.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for cs11.wpc.v0cdn.net
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='cs11.wpc.v0cdn.net'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for cs1137.wpc.gammacdn.net
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='cs1137.wpc.gammacdn.net'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for modern.watson.data.microsoft.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='modern.watson.data.microsoft.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --------Block telemetry and user experience hosts---------
:: ----------------------------------------------------------
echo --- Block telemetry and user experience hosts
:: Add hosts entries for functional.events.data.microsoft.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='functional.events.data.microsoft.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for browser.events.data.msn.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='browser.events.data.msn.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for self.events.data.microsoft.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='self.events.data.microsoft.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for v10.events.data.microsoft.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='v10.events.data.microsoft.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for v10c.events.data.microsoft.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='v10c.events.data.microsoft.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for us-v10c.events.data.microsoft.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='us-v10c.events.data.microsoft.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for eu-v10c.events.data.microsoft.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='eu-v10c.events.data.microsoft.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for v10.vortex-win.data.microsoft.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='v10.vortex-win.data.microsoft.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for vortex-win.data.microsoft.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='vortex-win.data.microsoft.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for telecommand.telemetry.microsoft.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='telecommand.telemetry.microsoft.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for www.telecommandsvc.microsoft.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='www.telecommandsvc.microsoft.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for umwatson.events.data.microsoft.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='umwatson.events.data.microsoft.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for watsonc.events.data.microsoft.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='watsonc.events.data.microsoft.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for eu-watsonc.events.data.microsoft.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='eu-watsonc.events.data.microsoft.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ------------Block location data sharing hosts-------------
:: ----------------------------------------------------------
echo --- Block location data sharing hosts
:: Add hosts entries for inference.location.live.net
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='inference.location.live.net'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for location-inference-westus.cloudapp.net
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='location-inference-westus.cloudapp.net'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ------------Block maps data and updates hosts-------------
:: ----------------------------------------------------------
echo --- Block maps data and updates hosts
:: Add hosts entries for maps.windows.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='maps.windows.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for ecn.dev.virtualearth.net
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='ecn.dev.virtualearth.net'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for ecn-us.dev.virtualearth.net
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='ecn-us.dev.virtualearth.net'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for weathermapdata.blob.core.windows.net
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='weathermapdata.blob.core.windows.net'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----------Block remote configuration sync hosts-----------
:: ----------------------------------------------------------
echo --- Block remote configuration sync hosts
:: Add hosts entries for settings-win.data.microsoft.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='settings-win.data.microsoft.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for settings.data.microsoft.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='settings.data.microsoft.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --------Block Spotlight ads and suggestions hosts---------
:: ----------------------------------------------------------
echo --- Block Spotlight ads and suggestions hosts
:: Add hosts entries for arc.msn.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='arc.msn.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for ris.api.iris.microsoft.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='ris.api.iris.microsoft.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for api.msn.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='api.msn.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for assets.msn.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='assets.msn.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for c.msn.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='c.msn.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for g.msn.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='g.msn.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for ntp.msn.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='ntp.msn.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for srtb.msn.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='srtb.msn.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for www.msn.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='www.msn.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for fd.api.iris.microsoft.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='fd.api.iris.microsoft.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for staticview.msn.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='staticview.msn.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for mucp.api.account.microsoft.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='mucp.api.account.microsoft.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for query.prod.cms.rt.microsoft.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='query.prod.cms.rt.microsoft.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ------------Block Cortana and Live Tiles hosts------------
:: ----------------------------------------------------------
echo --- Block Cortana and Live Tiles hosts
:: Add hosts entries for business.bing.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='business.bing.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for c.bing.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='c.bing.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for th.bing.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='th.bing.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for edgeassetservice.azureedge.net
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='edgeassetservice.azureedge.net'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for c-ring.msedge.net
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='c-ring.msedge.net'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for fp.msedge.net
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='fp.msedge.net'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for I-ring.msedge.net
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='I-ring.msedge.net'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for s-ring.msedge.net
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='s-ring.msedge.net'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for dual-s-ring.msedge.net
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='dual-s-ring.msedge.net'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for creativecdn.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='creativecdn.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for a-ring-fallback.msedge.net
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='a-ring-fallback.msedge.net'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for fp-afd-nocache-ccp.azureedge.net
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='fp-afd-nocache-ccp.azureedge.net'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for prod-azurecdn-akamai-iris.azureedge.net
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='prod-azurecdn-akamai-iris.azureedge.net'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for widgetcdn.azureedge.net
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='widgetcdn.azureedge.net'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for widgetservice.azurefd.net
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='widgetservice.azurefd.net'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for fp-vs.azureedge.net
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='fp-vs.azureedge.net'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for ln-ring.msedge.net
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='ln-ring.msedge.net'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for t-ring.msedge.net
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='t-ring.msedge.net'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for t-ring-fdv2.msedge.net
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='t-ring-fdv2.msedge.net'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: Add hosts entries for tse1.mm.bing.net
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='tse1.mm.bing.net'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -------------Block Edge experimentation hosts-------------
:: ----------------------------------------------------------
echo --- Block Edge experimentation hosts
:: Add hosts entries for config.edge.skype.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='config.edge.skype.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ---------------Block Photos app sync hosts----------------
:: ----------------------------------------------------------
echo --- Block Photos app sync hosts
:: Add hosts entries for evoke-windowsservices-tas.msedge.net
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='evoke-windowsservices-tas.msedge.net'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --------------Block Weather Live Tile hosts---------------
:: ----------------------------------------------------------
echo --- Block Weather Live Tile hosts
:: Add hosts entries for tile-service.weather.microsoft.com
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='tile-service.weather.microsoft.com'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --------------Block OneNote Live Tile hosts---------------
:: ----------------------------------------------------------
echo --- Block OneNote Live Tile hosts
:: Add hosts entries for cdn.onenote.net
PowerShell -ExecutionPolicy Unrestricted -Command "$domain ='cdn.onenote.net'; $hostsFilePath = "^""$env:WINDIR\System32\drivers\etc\hosts"^""; $comment = "^""managed by privacy.sexy"^""; $hostsFileEncoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Utf8; $blockingHostsEntries = @(; @{ AddressType = "^""IPv4"^"";  IPAddress = '0.0.0.0'; }; @{ AddressType = "^""IPv6"^"";  IPAddress = '::1'; }; ); try {; $isHostsFilePresent = Test-Path -Path $hostsFilePath -PathType Leaf -ErrorAction Stop; } catch {; Write-Error "^""Failed to check hosts file existence. Error: $_"^""; exit 1; }; if (-Not $isHostsFilePresent) {; Write-Output "^""Creating a new hosts file at $hostsFilePath."^""; try {; New-Item -Path $hostsFilePath -ItemType File -Force -ErrorAction Stop | Out-Null; Write-Output "^""Successfully created the hosts file."^""; } catch {; Write-Error "^""Failed to create the hosts file. Error: $_"^""; exit 1; }; }; foreach ($blockingEntry in $blockingHostsEntries) {; Write-Output "^""Processing addition for $($blockingEntry.AddressType) entry."^""; try {; $hostsFileContents = Get-Content -Path "^""$hostsFilePath"^"" -Raw -Encoding $hostsFileEncoding -ErrorAction Stop; } catch {; Write-Error "^""Failed to read the hosts file. Error: $_"^""; continue; }; $hostsEntryLine = "^""$($blockingEntry.IPAddress)`t$domain $([char]35) $comment"^""; if ((-Not [String]::IsNullOrWhiteSpace($hostsFileContents)) -And ($hostsFileContents.Contains($hostsEntryLine))) {; Write-Output 'Skipping, entry already exists.'; continue; }; try {; Add-Content -Path $hostsFilePath -Value $hostsEntryLine -Encoding $hostsFileEncoding -ErrorAction Stop; Write-Output 'Successfully added the entry.'; } catch {; Write-Error "^""Failed to add the entry. Error: $_"^""; continue; }; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -------------------Disable online tips--------------------
:: ----------------------------------------------------------
echo --- Disable online tips
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\System' /v 'AllowOnlineTips' /t 'REG_DWORD' /d '0' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -------Disable "Internet File Association" service--------
:: ----------------------------------------------------------
echo --- Disable "Internet File Association" service
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer' /v 'NoInternetOpenWith' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----------Disable "Order Prints" picture task------------
:: ----------------------------------------------------------
echo --- Disable "Order Prints" picture task
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer' /v 'NoOnlinePrintsWizard' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --Disable "Publish to Web" option for files and folders---
:: ----------------------------------------------------------
echo --- Disable "Publish to Web" option for files and folders
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer' /v 'NoPublishingWizard' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -------Disable provider list downloads for wizards--------
:: ----------------------------------------------------------
echo --- Disable provider list downloads for wizards
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer' /v 'NoWebServices' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -------Disable history of recently opened documents-------
:: ----------------------------------------------------------
echo --- Disable history of recently opened documents
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoRecentDocsHistory" /t REG_DWORD /d 1 /f
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----Clear recently opened document history upon exit-----
:: ----------------------------------------------------------
echo --- Clear recently opened document history upon exit
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' /v 'ClearRecentDocsOnExit' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----------Disable lock screen app notifications-----------
:: ----------------------------------------------------------
echo --- Disable lock screen app notifications
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\System' /v 'DisableLockScreenAppNotifications' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----------Disable Live Tiles push notifications-----------
:: ----------------------------------------------------------
echo --- Disable Live Tiles push notifications
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications' /v 'NoTileApplicationNotification' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----Disable the "Look For An App In The Store" option-----
:: ----------------------------------------------------------
echo --- Disable the "Look For An App In The Store" option
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer' /v 'NoUseStoreOpenWith' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----------Disable sync provider notifications------------
:: ----------------------------------------------------------
echo --- Disable sync provider notifications
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' /v 'ShowSyncProviderNotifications' /t 'REG_DWORD' /d '0' /f"
:: Suggest restarting explorer.exe for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'This script will not take effect until you restart explorer.exe. You can restart explorer.exe by restarting your computer or by running following on command prompt: `taskkill /f /im explorer.exe & start explorer`.'; $ignoreWindows10 =  $false; $ignoreWindows11 =  $false; $warn =  $false; $osVersion = [System.Environment]::OSVersion.Version; function Test-IsWindows10 { ($osVersion.Major -eq 10) -and ($osVersion.Build -lt 22000) }; function Test-IsWindows11 { ($osVersion.Major -gt 10) -or (($osVersion.Major -eq 10) -and ($osVersion.Build -ge 22000)) }; if (($ignoreWindows10 -and (Test-IsWindows10)) -or ($ignoreWindows11 -and (Test-IsWindows11))) {; echo "^""Skipping"^""; exit 0 <# Skip #>; }; if ($warn) {; Write-Warning "^""$message"^""; } else {; Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------


:: Disable hibernation for faster startup and to avoid sensitive data storage
echo --- Disable hibernation for faster startup and to avoid sensitive data storage
powercfg -h off
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----------Enable camera on/off OSD notifications----------
:: ----------------------------------------------------------
echo --- Enable camera on/off OSD notifications
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' /v 'NoPhysicalCameraLED' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----------------Disable app usage tracking----------------
:: ----------------------------------------------------------
echo --- Disable app usage tracking
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\Software\Policies\Microsoft\Windows\EdgeUI' /v 'DisableMFUTracking' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -------------------Disable recent apps--------------------
:: ----------------------------------------------------------
echo --- Disable recent apps
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\Software\Policies\Microsoft\Windows\EdgeUI' /v 'DisableRecentApps' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -------------------Disable backtracking-------------------
:: ----------------------------------------------------------
echo --- Disable backtracking
PowerShell -ExecutionPolicy Unrestricted -Command "reg add 'HKCU\Software\Policies\Microsoft\Windows\EdgeUI' /v 'TurnOffBackstack' /t 'REG_DWORD' /d '1' /f"
:: ----------------------------------------------------------


:: Pause the script to view the final state
pause
:: Restore previous environment settings
endlocal
:: Exit the script successfully
exit /b 0