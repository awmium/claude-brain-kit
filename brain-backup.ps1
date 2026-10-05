# Mirrors every ~/.claude/projects/*/memory/ into the Brain.
# Runs from the SessionEnd hook in ~/.claude/settings.json. Brain\projects\ is
# machine-managed (true mirror, deletions propagate); Brain\global\ is never touched.
# Compatible with Windows PowerShell 5.1 and PowerShell 7+.

$ErrorActionPreference = 'SilentlyContinue'

# --- configure ---------------------------------------------------------------
$brainRoot = 'C:\CHANGE-ME\Brain'   # your Brain folder (ideally inside OneDrive)

# Optional: readable mirror folder names. Key = the raw folder name under
# ~\.claude\projects\ (the sanitized project path); value = the name you want.
# Unknown projects fall back to their raw name.
$friendlyNames = @{
    # 'd--Repos-My-Client-Project' = 'my-client-project'
}
# ------------------------------------------------------------------------------

$projectsRoot = Join-Path $env:USERPROFILE '.claude\projects'
$mirrorRoot   = Join-Path $brainRoot 'projects'

$synced = @()
Get-ChildItem -Path $projectsRoot -Directory | ForEach-Object {
    if ($_.Name -match '-worktrees-') { return }
    $mem = Join-Path $_.FullName 'memory'
    if (-not (Test-Path $mem)) { return }
    if (-not (Get-ChildItem $mem -File -Recurse | Select-Object -First 1)) { return }

    $key  = $_.Name
    $name = $friendlyNames[$key]
    if (-not $name) {
        $match = $friendlyNames.Keys | Where-Object { $_ -ieq $key } | Select-Object -First 1
        $name = if ($match) { $friendlyNames[$match] } else { $key }
    }

    $dest = Join-Path $mirrorRoot $name
    robocopy $mem $dest /MIR /R:1 /W:1 /NP /NJH /NJS | Out-Null
    $synced += $name
}

$stamp = Join-Path $brainRoot 'last-backup.txt'
"$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')  synced: $($synced -join ', ')" | Set-Content $stamp
exit 0
