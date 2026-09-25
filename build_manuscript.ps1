$ErrorActionPreference = 'Stop'
$savedEnvironment = @{}
foreach ($variableName in @('TEXMFHOME', 'TEXMFVAR', 'TEXMFCONFIG', 'LC_ALL')) {
    $savedEnvironment[$variableName] = [Environment]::GetEnvironmentVariable($variableName, 'Process')
}
Push-Location -LiteralPath $PSScriptRoot
try {
    $env:LC_ALL = 'C'
    if (Test-Path -LiteralPath '.texmf/tex/latex/newtx/newtxtext.sty') {
        $env:TEXMFHOME = Join-Path $PSScriptRoot '.texmf'
        $env:TEXMFVAR = Join-Path $PSScriptRoot '.texmf-var'
        $env:TEXMFCONFIG = Join-Path $PSScriptRoot '.texmf-config'
        New-Item -ItemType Directory -Path $env:TEXMFVAR, $env:TEXMFCONFIG -Force | Out-Null
        if (-not (Test-Path -LiteralPath '.texmf-var/fonts/map/pdftex/updmap/pdftex.map')) {
            & updmap-user
            if ($LASTEXITCODE -ne 0) { throw 'Font map generation failed.' }
        }
    }
    & latexmk -norc -r manuscript.latexmkrc SICE-SI_manuscript.tex
    if ($LASTEXITCODE -ne 0) { throw 'LaTeX compilation failed.' }
    Copy-Item -LiteralPath '.manuscript-build/SICE-SI_manuscript.pdf' -Destination 'SICE-SI_manuscript.pdf' -Force
    Write-Output 'Created SICE-SI_manuscript.pdf'
}
finally {
    Pop-Location
    foreach ($variableName in $savedEnvironment.Keys) {
        [Environment]::SetEnvironmentVariable($variableName, $savedEnvironment[$variableName], 'Process')
    }
}
