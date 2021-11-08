#!/usr/bin/env bash
sudo rm -rf /etc/localtime
sudo ln -s /usr/share/zoneinfo/America/Montreal /etc/localtime

pwsh ~/dotfiles/Powershell/InstallPoshModules.ps1
mkdir -p ~/.config/powershell/
cp ~/dotfiles/Powershell/Microsoft.PowerShell_profile.ps1 ~/.config/powershell/
