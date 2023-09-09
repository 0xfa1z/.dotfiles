#!/bin/bash

trim() {
    read -rd '' -a arr <<<"$@"
    echo -n "${arr[@]}"
}

# DOTFILES='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

set -e
source .env

dotfiles() {
	  git --git-dir=$HOME/.dotfiles --work-tree=$HOME "$@"
}


# git --git-dir=$HOME/.dotfiles --work-tree=$HOME config --local status.showUntrackedFiles no
dotfiles config --local status.showUntrackedFiles no
git --git-dir=$HOME/.dotfiles --work-tree=$HOME reset README.md
git --git-dir=$HOME/.dotfiles --work-tree=$HOME update-index --assume-unchanged README.md


# if ! grep -q "^README.md$" $HOME/.dotfiles/info/exclude; then
#   echo "README.md" >> $HOME/.dotfiles/info/exclude
# fi

[ -f "README.md" ] && mv $HOME/README.md $HOME/.dotfiles/README.md

touch .hushlogin

sudo apt update
sudo apt -y upgrade

# do you want git setup based on .env?
# sudo apt install -y git
# 
# mkdir -p ~/$PARENT_FOLDER
# 
# IFS=',' read -ra PROFILE_ARRAY <<< "$PROFILES"
# for PROFILE_NAME in "${PROFILE_ARRAY[@]}"; do
#     # Trim spaces
#     PROFILE_NAME=$(trim "$raw_profile")
# 
#     # Access the corresponding PROFILE variable
#     PROFILE_DETAILS_VAR=$PROFILE_NAME
#     IFS=',' read -ra DETAILS <<< "${!PROFILE_DETAILS_VAR}"
# 
#     # Break down the details
#     USERNAME=$(trim ${DETAILS[0]})
#     EMAIL=$(trim ${DETAILS[1]})
#     TOKEN=$(trim ${DETAILS[2]})
# 
#     # Create a folder named after the profile
#     mkdir -p ~/$PARENT_FOLDER/$PROFILE_NAME
# 
#     # Populate git config or whatever is needed for this profile
#     # ...
# 
# done

# add origin git@github.com:username/repo.git

# do you want zsh?

# zsh

# alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

