#!/usr/bin/env bash
sudo rm -rf /etc/localtime
sudo ln -s /usr/share/zoneinfo/America/Montreal /etc/localtime
sudo apt-get install unzip

scriptDirectory=$(dirname "$(readlink -f "$0")")

pwsh $scriptDirectory/Powershell/InstallPoshModules.ps1
mkdir -p ~/.config/powershell/
cp $scriptDirectory/Powershell/Microsoft.PowerShell_profile.ps1 ~/.config/powershell/

cp $scriptDirectory/starship.toml ~/.config/starship.toml
