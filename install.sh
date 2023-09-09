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

dotfiles config --local status.showUntrackedFiles no
# Check if README.md exists in the repository
# if dotfiles ls-files | grep -q 'README.md'; then
if [ -f "README.md" ]; then
  # dotfiles update-index --skip-worktree README.md
  git --git-dir=$HOME/.dotfiles --work-tree=$HOME reset README.md
  git --git-dir=$HOME/.dotfiles --work-tree=$HOME update-index --assume-unchanged README.md
fi

if [ -f "env" ]; then
  git --git-dir=$HOME/.dotfiles --work-tree=$HOME reset env
  git --git-dir=$HOME/.dotfiles --work-tree=$HOME update-index --assume-unchanged env
fi


# git --git-dir=$HOME/.dotfiles --work-tree=$HOME config --local status.showUntrackedFiles no

# if ! grep -q "^README.md$" $HOME/.dotfiles/info/exclude; then
#   echo "README.md" >> $HOME/.dotfiles/info/exclude
# fi

[ -f "README.md" ] && mv $HOME/README.md $HOME/.dotfiles/README.md
[ -f "env" ] && rm $HOME/env

touch .hushlogin
mkdir -p .local/bin

sudo apt update
sudo apt -y upgrade

sudo apt -y install zsh

# make zsh default shell
echo $USER_PASS | chsh -s $(which zsh)

# do you want git setup based on .env?
sudo apt -y install git
# 
# mkdir -p ~/$PARENT_FOLDER
# 
IFS=',' read -ra PROFILE_ARRAY <<< "$PROFILES"
# MAIN_PROFILE_NAME=$(trim "$PROFILE_ARRAY[0]")
# MAIN_PROFILE_NAME=$PROFILE_ARRAY[0]
# mkdir -p ~/$PARENT_FOLDER/$PROFILE_ARRAY

FIRST_PROFILE_NAME=$(echo "${PROFILE_ARRAY[0]}" | xargs)

# Use indirect referencing to get the details of the first profile
FIRST_PROFILE_VAR="${FIRST_PROFILE_NAME^^}"  # Uppercase conversion
FIRST_PROFILE_DETAILS="${!FIRST_PROFILE_VAR}"

# Parse these details to extract username, email, and token
IFS=', ' read -ra DETAILS <<< "$FIRST_PROFILE_DETAILS"
USERNAME="${DETAILS[0]}"
EMAIL="${DETAILS[1]}"
TOKEN="${DETAILS[2]}"

# Generate .gitconfig file
echo "[user]
        name = $USERNAME
        email = $EMAIL
[credential]
	helper = store" > $HOME/.gitconfig

# IFS=',' read -ra MAIN_PROFILE_DETAILS <<< "$PROFILE1"
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

