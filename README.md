# dotfiles

```shell
ssh-keygen -t rsa -b 4096 -f ~/.ssh/git_me
cat ~/.ssh/git_me.pub
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/git_me

git clone --bare git@github.com:0xfa1z/dotfiles.git $HOME/.dotfiles
git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout
./.local/bin/install_dotfiles

# restart the shell

dot remote set-url origin git@me:0xfa1z/dotfiles.git
dot push --set-upstream origin main

---

# If you need to setup a User:
sudo adduser sfaiz
sudo usermod -aG sudo sfaiz
groups sfaiz
su - sfaiz

clean up with: 
```shell
find . -mindepth 1 -maxdepth 1 | xargs rm -r
```
