# Dotfiles Setup

Welcome to my dotfiles repository! This repository contains my personal configurations for setting up a fresh Ubuntu machine, typically for WSL but also compatible with any Ubuntu server.

## Overview

This repository contains configuration files for:
- Git (`.gitconfig`)
- Zsh (`.zshrc`)
- Tmux (`.tmux.conf`)
- SSH (`.ssh/config`)
- Custom scripts (`.local/bin`)

## Prerequisites

Before you begin, ensure you have met the following requirements:
- You have Git installed.
- You have `sudo` access.

## Installation

### Step 1: Generate an SSH key and add it to GitHub
This step ensures secure access to your GitHub repositories.
```sh
ssh-keygen -t rsa -b 4096 -f ~/.ssh/git-me
cat ~/.ssh/git-me.pub
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/git-me
```
[Detailed Guide](https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

### Step 2: Clone and checkout dotfiles
This step clones the dotfiles repository and sets up the environment.
```sh
git clone --bare git@github.com:0xfa1z/.dotfiles.git $HOME/.dotfiles
git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout
./.local/bin/setup
```

### Step 3: Restart the shell
Restart your shell to apply the new configurations.

### Step 4: Set up Neovim
Start Neovim and run `:Copilot setup` to configure the Copilot plugin.

### Step 5 (Optional): Docker Setup

If you wish to set up Docker, follow these additional steps.

#### Step 1: Add WSL to Docker Desktop
Add the WSL to Docker Desktop under Settings -> Resources -> WSL Integration.

#### Step 2: Add current user to docker group
```sh
sudo usermod -aG docker $USER
newgrp docker
```

## Uninstall

To clean up the complete home directory:
```sh
find . -mindepth 1 -maxdepth 1 | xargs rm -r

# or keeping the ssh keys
sudo find . -mindepth 1 -maxdepth 1 ! -name '.ssh' -exec rm -r {} +
rm .ssh/config
```
