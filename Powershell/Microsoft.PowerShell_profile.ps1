Invoke-Expression (&starship init powershell)
if (Get-Module -ListAvailable -Name posh-git) { Import-Module posh-git }
$env:PNPM_HOME="/home/$env:USER/.local/share/pnpm"
$env:PATH="$env:PNPM_HOME`:$env:PATH"
