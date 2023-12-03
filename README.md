# dotfiles

```shell
sudo apt-get update
sudo apt-get upgrade

mkdir .ssh
cd .ssh
vi create_cert
chmod +x create_cert
vi config
git config --global user.name "0xfa1z"
git config --global user.email "sofian@faiz.digital"

git clone --bare git@me:0xfa1z/dotfiles.git $HOME/.dotfiles
mv .ssh/config .ssh/config_old
git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout
sudo ./.local/bin/install_dotfiles
chsh -s $(which zsh)
```

clean up with: 
```shell
find . -mindepth 1 -maxdepth 1 ! -name '.env' | xargs rm -r
```

todo:
- setup git dev folders all with ssh enabled
- fix clipboard properly
