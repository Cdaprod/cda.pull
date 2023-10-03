#!/bin/bash

# Update package lists
sudo apt update

# Install SSH Server (for Ansible)
sudo apt install -y openssh-server

# Install Python-related packages
sudo apt install -y python3 python3-pip
sudo pip3 install ansible boto3

# Install Networking tools
sudo apt install -y net-tools ufw wireless-tools wpasupplicant
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Install Version Control and Code Editors
sudo apt install -y git neovim zsh

# Install Git Credential Manager
sudo apt install -y libsecret-1-0 libsecret-1-dev
cd /usr/share/doc/git/contrib/credential/libsecret
sudo make
git config --global credential.helper /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret

# Install Shell and Terminal Utilities
sudo apt install -y zsh tmux

# Install Web Server
sudo apt install -y nginx

# Install Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install -y docker-ce

# Install Docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Install Minikube for Kubernetes
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Install Node.js and npm (JavaScript Packages)
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt install -y nodejs

# Install Node Version Manager (NVM)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

# Install AWS CLI
curl "https://d1vvhvl2y92vvt.cloudfront.net/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Install GitHub CLI
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
sudo apt-add-repository https://cli.github.com/packages
sudo apt update
sudo apt install gh

# Install Tailscale (VPN)
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.gpg | sudo apt-key add -
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.list | sudo tee /etc/apt/sources.list.d/tailscale.list
sudo apt update
sudo apt install -y tailscale

# Print installed versions for verification
echo "=== Installed Versions ==="
ansible --version
docker --version
docker-compose --version
python3 --version
pip3 --version
aws --version
gh --version
git --version
ufw --version
nvim --version
zsh --version
tmux -V
nginx -v
minikube version
node -v
npm -v
tailscale --version

echo "=== All packages installed successfully ==="
