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

#change defautl shell to pwsh
sudo tee /usr/local/bin/pwsh-login > /dev/null <<'EOF'
#!/usr/bin/env bash
exec /usr/bin/pwsh -NoLogo -NoProfileLoadTime "$@"
EOF
sudo chmod 755 /usr/local/bin/pwsh-login

grep -qxF /usr/local/bin/pwsh-login /etc/shells || echo /usr/local/bin/pwsh-login | sudo tee -a /etc/shells

usermod -s /usr/local/bin/pwsh-login $USER

pwsh -NoProfile -Command "Install-Module posh-git -Scope CurrentUser -Force"

# docker-outside-of-docker (from devcontainers/features)
curl -fsSL https://raw.githubusercontent.com/devcontainers/features/refs/heads/main/src/docker-outside-of-docker/install.sh -o /tmp/docker-outside-of-docker-install.sh
chmod +x /tmp/docker-outside-of-docker-install.sh
sudo VERSION="latest" MOBY="false" DOCKERDASHCOMPOSEVERSION="v2" INSTALLDOCKERBUILDX="true" bash /tmp/docker-outside-of-docker-install.sh
rm -f /tmp/docker-outside-of-docker-install.sh

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

# Install delta 
gh release download --repo dandavison/delta --pattern "*amd64.deb" -D /tmp
sudo dpkg -i /tmp/git-delta_*.deb
rm -f /tmp/git-delta_*.deb

# Install eza
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza

# Install ripgrep
gh release download --repo BurntSushi/ripgrep --pattern "*amd64.deb" -D /tmp
sudo dpkg -i /tmp/ripgrep_*_amd64.deb
rm -f /tmp/ripgrep_*_amd64.deb

# Install Yazi
curl -fsSL https://yazi-rs.github.io/builds/yazi-keyring.gpg | sudo tee /usr/share/keyrings/yazi-keyring.gpg >/dev/null
echo 'deb [signed-by=/usr/share/keyrings/yazi-keyring.gpg] https://yazi-rs.github.io/builds/ stable main' | sudo tee /etc/apt/sources.list.d/yazi.list >/dev/null
sudo apt update && sudo apt install -y yazi

# Install Micro (getmic.ro)
curl https://getmic.ro | bash
