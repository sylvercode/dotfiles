oh-my-posh init pwsh --config "~/.poshthemes/slimfat.omp.json" | Invoke-Expression
Import-Module posh-git
$env:PNPM_HOME="/home/$env:USER/.local/share/pnpm"
$env:PATH="$env:PNPM_HOME`:$env:PATH"
