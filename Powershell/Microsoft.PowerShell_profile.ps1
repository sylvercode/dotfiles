Invoke-Expression (&starship init powershell)
if (Get-Module -ListAvailable -Name posh-git) { Import-Module posh-git }
$env:PNPM_HOME = "/home/$env:USER/.local/share/pnpm"
$env:PATH = "$env:PNPM_HOME`:$env:PATH"

# Word navigation
Set-PSReadLineKeyHandler -Key Ctrl+LeftArrow  -Function BackwardWord
Set-PSReadLineKeyHandler -Key Ctrl+RightArrow -Function NextWord

# Word deletion
Set-PSReadLineKeyHandler -Key Ctrl+Backspace -Function BackwardKillWord
Set-PSReadLineKeyHandler -Key Ctrl+Delete    -Function KillWord

# Line editing
Set-PSReadLineKeyHandler -Key Ctrl+Home -Function BackwardDeleteLine
Set-PSReadLineKeyHandler -Key Ctrl+End  -Function DeleteLine
Set-PSReadLineKeyHandler -Key Escape -Function DeleteLine

# History search
Set-PSReadLineKeyHandler -Key Ctrl+r -Function ReverseSearchHistory
Set-PSReadLineKeyHandler -Key Ctrl+s -Function ForwardSearchHistory

# Misc editing
Set-PSReadLineKeyHandler -Key Ctrl+u -Function BackwardKillLine
Set-PSReadLineKeyHandler -Key Ctrl+k -Function KillLine
Set-PSReadLineKeyHandler -Key Ctrl+y -Function Yank
