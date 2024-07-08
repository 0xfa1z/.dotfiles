# Dotfiles Setup

## Dotfiles Setup

1. Generate an SSH key and add it to Github:
    ```sh
    ssh-keygen -t rsa -b 4096 -f ~/.ssh/git-me
    cat ~/.ssh/git-me.pub
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/git-me
    ```

2. Clone and checkout dotfiles:
    ```sh
    git clone --bare git@github.com:0xfa1z/dotfiles.git $HOME/.dotfiles
    git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout
    ./.local/bin/setup
    ```

3. Restart the shell.

4. Add ths WSL to Docker Desktop under Settings, Resources, WSL integration

5. Add current user to docker group
   ```sh
   sudo usermod -aG docker $USER
   newgrp docker
   ```

6. Start Neovim and invoke :Copilot setup

---

## User Setup

1. Add a new user and grant sudo access:
    ```sh
    sudo adduser sfaiz
    sudo usermod -aG sudo sfaiz
    groups sfaiz
    su - sfaiz
    ```

## Cleanup

To clean up the current directory:
```sh
find . -mindepth 1 -maxdepth 1 | xargs rm -r

# or to keep the git key

sudo find . -mindepth 1 -maxdepth 1 ! -name '.ssh' -exec rm -r {} +
rm .ssh/config
```
