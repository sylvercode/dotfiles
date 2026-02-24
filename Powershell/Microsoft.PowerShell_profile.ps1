Invoke-Expression (&starship init powershell)
Import-Module posh-git
$env:PNPM_HOME="/home/$env:USER/.local/share/pnpm"
$env:PATH="$env:PNPM_HOME`:$env:PATH"
