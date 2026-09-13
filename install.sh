#!/usr/bin/env bash

# Timezone
sudo rm -rf /etc/localtime
sudo ln -s /usr/share/zoneinfo/America/Montreal /etc/localtime

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

# Install pnpm and yarn if node is available
if command -v node > /dev/null 2>&1; then
    npm install -g pnpm@latest
    corepack enable
fi
