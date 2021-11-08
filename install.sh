#!/usr/bin/env bash
sudo rm -rf /etc/localtime
sudo ln -s /usr/share/zoneinfo/America/Montreal /etc/localtime

su vscode -c "pwsh ~/dotfiles/Powershell/InstallPoshModules.ps1"
su vscode -c "cp ~/dotfiles/Powershell/Microsoft.PowerShell_profile.ps1 .config/powershell/"
