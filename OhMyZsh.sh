#!/bin/bash

# Function to install Zsh on macOS
install_zsh_mac() {
  brew install zsh
}

# Function to install Zsh on Linux
install_zsh_linux() {
  sudo apt update
  sudo apt install -y zsh
}

# Function to install Oh My Zsh
install_oh_my_zsh() {
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

# Check if Zsh is already installed
if command -v zsh &>/dev/null; then
    echo "Zsh is already installed. Skipping..."
else
    echo "Installing Zsh..."
    # Detect the platform (Linux or macOS)
    platform=$(uname)
    
    if [ "$platform" = "Linux" ]; then
        install_zsh_linux
    elif [ "$platform" = "Darwin" ]; then
        install_zsh_mac
    else
        echo "Unknown platform: $platform"
        exit 1
    fi

    echo "Zsh installed successfully!"
fi

# Install Oh My Zsh
if [ -d "$HOME/.oh-my-zsh" ]; then
  echo "Oh My Zsh is already installed. Skipping..."
else
  echo "Installing Oh My Zsh..."
  install_oh_my_zsh
  echo "Oh My Zsh installed successfully!"
fi
