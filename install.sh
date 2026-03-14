#!/usr/bin/env bash

# Timezone
sudo rm -rf /etc/localtime
sudo ln -s /usr/share/zoneinfo/America/Montreal /etc/localtime

# Latest Git (from devcontainers/features)
curl -fsSL https://raw.githubusercontent.com/devcontainers/features/main/src/git/install.sh -o /tmp/git-install.sh
chmod +x /tmp/git-install.sh
sudo VERSION="latest" PPA="true" bash /tmp/git-install.sh
rm -f /tmp/git-install.sh

# Latest PowerShell (from devcontainers/features)
curl -fsSL https://raw.githubusercontent.com/devcontainers/features/main/src/powershell/install.sh -o /tmp/powershell-install.sh
chmod +x /tmp/powershell-install.sh
sudo VERSION="latest" bash /tmp/powershell-install.sh
rm -f /tmp/powershell-install.sh

# Starship prompt
sudo curl -sS https://starship.rs/install.sh | sh -s -- --yes

scriptDirectory=$(dirname "$(readlink -f "$0")")

mkdir -p ~/.config/powershell/
cp $scriptDirectory/Powershell/Microsoft.PowerShell_profile.ps1 ~/.config/powershell/

cp $scriptDirectory/starship.toml ~/.config/starship.toml

pwsh -NoProfile -Command "Install-Module posh-git -Scope CurrentUser -Force"

# Docker-in-Docker (from devcontainers/features)
curl -fsSL https://raw.githubusercontent.com/devcontainers/features/main/src/docker-in-docker/install.sh -o /tmp/docker-in-docker-install.sh
chmod +x /tmp/docker-in-docker-install.sh
sudo VERSION="latest" MOBY="false" DOCKERDASHCOMPOSEVERSION="v2" INSTALLDOCKERBUILDX="true" bash /tmp/docker-in-docker-install.sh
rm -f /tmp/docker-in-docker-install.sh

# GitHub CLI (from devcontainers/features)
curl -fsSL https://raw.githubusercontent.com/devcontainers/features/main/src/github-cli/install.sh -o /tmp/github-cli-install.sh
chmod +x /tmp/github-cli-install.sh
sudo VERSION="latest" bash /tmp/github-cli-install.sh
rm -f /tmp/github-cli-install.sh

# GitHub Copilot CLI (from devcontainers/features)
curl -fsSL https://raw.githubusercontent.com/devcontainers/features/main/src/copilot-cli/install.sh -o /tmp/copilot-cli-install.sh
chmod +x /tmp/copilot-cli-install.sh
sudo bash /tmp/copilot-cli-install.sh
rm -f /tmp/copilot-cli-install.sh

# Node.js nvm only (from devcontainers/features)
curl -fsSL https://raw.githubusercontent.com/devcontainers/features/main/src/node/install.sh -o /tmp/node-install.sh
chmod +x /tmp/node-install.sh
sudo VERSION="none" PNPMVERSION="none" INSTALLYARNUSINGAPT="false" bash /tmp/node-install.sh
rm -f /tmp/node-install.sh

# Install pnpm and yarn if node is available
if command -v node > /dev/null 2>&1; then
    npm install -g pnpm@latest
    corepack enable
fi
