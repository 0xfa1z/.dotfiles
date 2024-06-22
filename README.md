# Dotfiles Setup

## Dotfiles Setup

1. Generate an SSH key and add it to Github:
    ```sh
    ssh-keygen -t rsa -b 4096 -f ~/.ssh/git_me
    cat ~/.ssh/git_me.pub
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/git_me
    ```

2. Clone and checkout dotfiles:
    ```sh
    git clone --bare git@github.com:0xfa1z/dotfiles.git $HOME/.dotfiles
    git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout
    ./.local/bin/setup
    ```

3. Restart the shell.

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
```
