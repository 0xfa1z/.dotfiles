#!/bin/bash

# Function Definitions

setupDotfilesRepo() {
  dotfiles() {
    git --git-dir=$HOME/.dotfiles --work-tree=$HOME "$@"
  }
  dotfiles config --local status.showUntrackedFiles no

  if [ -f "README.md" ]; then
    dotfiles reset README.md
    dotfiles update-index --assume-unchanged README.md
    mv $HOME/README.md $HOME/.dotfiles/README.md
  fi

  if [ -f "env" ]; then
    dotfiles reset env
    dotfiles update-index --assume-unchanged env
    rm $HOME/env
  fi
}

setupZsh() {
  sudo apt -y install zsh
  echo $USER_PASS | chsh -s $(which zsh)
}

setupGit() {
        sudo apt -y install git

  # Create the parent folder
  mkdir -p $HOME/$PARENT_FOLDER

  IFS=',' read -ra PROFILE_ARRAY <<< "$PROFILES"
  FIRST_PROFILE_NAME=$(echo "${PROFILE_ARRAY[0]}" | xargs)

  FIRST_PROFILE_VAR="${FIRST_PROFILE_NAME^^}"  # Uppercase conversion
  FIRST_PROFILE_DETAILS="${!FIRST_PROFILE_VAR}"

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

  for PROFILE_NAME in "${PROFILE_ARRAY[@]}"; do
          PROFILE_NAME=$(echo "$PROFILE_NAME" | xargs)  # Remove extra spaces if any
          PROFILE_VAR="${PROFILE_NAME^^}"  # Uppercase conversion
          PROFILE_DETAILS="${!PROFILE_VAR}"

          IFS=', ' read -ra DETAILS <<< "$PROFILE_DETAILS"
          USERNAME="${DETAILS[0]}"
          EMAIL="${DETAILS[1]}"
          TOKEN="${DETAILS[2]}"

          mkdir -p $HOME/$PARENT_FOLDER/$PROFILE_NAME

  # Generate .gitconfig file
  echo "[user]
  name = $USERNAME
  email = $EMAIL
[credential]
  helper = store" > $HOME/$PARENT_FOLDER/$PROFILE_NAME/.gitconfig

done
}

# Main Execution

set -e
# source .env

setupDotfilesRepo
touch .hushlogin
mkdir -p .local/bin
sudo apt update
sudo apt -y upgrade

if [ "$SET_ZSH" = "true" ]; then
  setupZsh
fi

# if [ "$SET_GIT" = "true" ]; then
#   setupGit
# fi
