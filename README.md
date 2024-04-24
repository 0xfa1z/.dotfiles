# dotfiles

```shell
sudo apt-get update
sudo apt-get upgrade

sudo adduser sfaiz
sudo usermod -aG sudo newusername
groups newusername
su - sfaiz
ssh-keygen -t rsa -b 4096
cat ~/.ssh/id_rsa.pub




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
rm .ssh/config_old
sudo ./.local/bin/install_dotfiles
chsh -s $(which zsh)

sudo apt-get install build-essential
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
tar -xvf nvim-linux64.tar.gz
cp nvim-linux64/bin/nvim .local/bin
cp -r nvim-linux64/share/nvim .local/share
rm -r nvim-linux64 nvim-linux64.tar.gz

sudo apt-get install ripgrep tree
git clone git@me:0xfa1z/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim

wget https://nodejs.org/dist/v20.10.0/node-v20.10.0-linux-x64.tar.xz
mkdir ~/.local/nodejs
tar -xJvf node-v20.10.0-linux-x64.tar.xz -C ~/.local/nodejs --strip-components=1
# update path to contain ~/.local/nodejs/bin

in nvim do :Copilot setup
```

clean up with: 
```shell
find . -mindepth 1 -maxdepth 1 ! -name '.env' | xargs rm -r
```

todo:
- setup git dev folders all with ssh enabled
- fix clipboard properly
