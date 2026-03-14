#!/usr/bin/env bash
sudo rm -rf /etc/localtime
sudo ln -s /usr/share/zoneinfo/America/Montreal /etc/localtime
sudo curl -sS https://starship.rs/install.sh | sh -s -- --yes

scriptDirectory=$(dirname "$(readlink -f "$0")")

mkdir -p ~/.config/powershell/
cp $scriptDirectory/Powershell/Microsoft.PowerShell_profile.ps1 ~/.config/powershell/

cp $scriptDirectory/starship.toml ~/.config/starship.toml

pwsh -NoProfile -Command  Install-Module posh-git -Scope CurrentUser -Force
