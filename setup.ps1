<#
Turns a fresh copy of this template into a project.

  .\setup.ps1 -Name "My Project"                      # repo name defaults to the folder name
  .\setup.ps1 -Name "My Project" -Repo my-project -Build "npm run build"

What it does:
  - fills {{PROJECT_NAME}}, {{REPO}}, {{FOLDER}} and {{BUILD_COMMAND}} in AGENTS.md and PROGRESS.md
  - replaces this README with a one-line project README
  - adds AGENTS.md, CLAUDE.md and PROGRESS.md to .gitignore and stops tracking them
    (they are local working notes, never committed in a real project)
  - deletes itself
#>
param(
    [Parameter(Mandatory = $true)][string]$Name,
    [string]$Repo = '',
    [string]$Build = ''
)
$ErrorActionPreference = 'Stop'
$root = $PSScriptRoot
$folder = Split-Path -Leaf $root
if ($Repo -eq '') { $Repo = $folder }
$utf8 = New-Object System.Text.UTF8Encoding($false)

function Write-Utf8([string]$path, [string]$text) {
    [System.IO.File]::WriteAllText($path, $text, $utf8)
}

foreach ($file in 'AGENTS.md', 'PROGRESS.md') {
    $path = Join-Path $root $file
    $text = [System.IO.File]::ReadAllText($path, $utf8)
    $text = $text.Replace('{{PROJECT_NAME}}', $Name).Replace('{{REPO}}', $Repo).Replace('{{FOLDER}}', $folder)
    if ($Build -ne '') { $text = $text.Replace('{{BUILD_COMMAND}}', $Build) }
    Write-Utf8 $path $text
}

Write-Utf8 (Join-Path $root 'README.md') "# $Name`n"

$ignore = Join-Path $root '.gitignore'
$existing = ''
if (Test-Path $ignore) { $existing = [System.IO.File]::ReadAllText($ignore, $utf8) }
if ($existing -notmatch '(?m)^AGENTS\.md$') {
    $block = "`n# Local agent working notes (never committed)`nAGENTS.md`nCLAUDE.md`nPROGRESS.md`n"
    Write-Utf8 $ignore ($existing.TrimEnd() + "`n" + $block)
}

if (Test-Path (Join-Path $root '.git')) {
    Push-Location $root
    try {
        git rm --cached --quiet --ignore-unmatch AGENTS.md CLAUDE.md PROGRESS.md setup.ps1 | Out-Null
    } finally { Pop-Location }
}

Remove-Item -LiteralPath $PSCommandPath -Force

Write-Host "Set up '$Name' (repo tianiste/$Repo)."
Write-Host "Placeholders still to fill in AGENTS.md (PROGRESS.md ones are filled as you work):"
Select-String -Path (Join-Path $root 'AGENTS.md') -Pattern '\{\{[^}]+\}\}' -AllMatches |
    ForEach-Object { $_.Matches } | ForEach-Object { $_.Value } | Sort-Object -Unique | ForEach-Object { "  $_" }
if (Test-Path (Join-Path $root '.git')) {
    Write-Host "Commit the README/.gitignore changes; AGENTS.md, CLAUDE.md and PROGRESS.md are now untracked local notes."
}
