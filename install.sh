#!/usr/bin/env bash

# Timezone
sudo rm -rf /etc/localtime
sudo ln -s /usr/share/zoneinfo/America/Montreal /etc/localtime

# Latest Git
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt-get update -q
sudo apt-get install -y git

# Latest PowerShell
curl -sL https://aka.ms/install-powershell.sh | sudo bash

# Starship prompt
sudo curl -sS https://starship.rs/install.sh | sh -s -- --yes

scriptDirectory=$(dirname "$(readlink -f "$0")")

mkdir -p ~/.config/powershell/
cp $scriptDirectory/Powershell/Microsoft.PowerShell_profile.ps1 ~/.config/powershell/

cp $scriptDirectory/starship.toml ~/.config/starship.toml

pwsh -NoProfile -Command "Install-Module posh-git -Scope CurrentUser -Force"
