# dotfiles

# get access to the private Repo

copy the create_cert script
create the certificate and enter it into github
create the .gitconfig

``` bash
git clone --bare https://github.com/0xfa1z/dotfiles.git $HOME/.dotfiles
git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout
```

clean up with: 
```shell
find . -mindepth 1 -maxdepth 1 ! -name '.env' | xargs rm -r
```

todo:
- setup git dev folders all with ssh enabled
- fix clipboard properly
