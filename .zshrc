## Prompt and Shell Settings
bindkey -v # Enable Vim keybindings in the shell

# Set the main prompt to show the current directory in cyan
PROMPT="%F{cyan}%~ %f "

# Git prompt configuration
autoload -Uz vcs_info # Load version control information system
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info ) # Add vcs_info to precmd functions
setopt prompt_subst # Enable prompt substitution
RPROMPT=\$vcs_info_msg_0_ # Set right prompt to show version control info
zstyle ':vcs_info:git:*' formats '%F{yellow}(%b) %r%f' # Format git info: yellow (branch) repository
zstyle ':vcs_info:*' enable git # Enable vcs_info for git

# History settings
HISTFILE=~/.zsh_history
SAVEHIST=1000

# Autocompletion settings
autoload -Uz compinit && compinit # Initialize completion system
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}=[A-Za-z]' # Make autocompletion case-insensitive

## Aliases
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias dot=dotfiles
alias dots='dot status'
alias vzsh='vi ~/.zshrc'
alias vinit='vi ~/.config/nvim/init.lua'
alias host='hostname'
# alias host='echo $HOSTNAME'
alias l='ls -la'
alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias gaa='git add -A'
alias gc='git commit -m '
alias gp='git push'
# alias gcap='git pull && git add -A && git commit -m "Update" && git push'
alias vi='nvim'
alias vim='nvim'
alias ..='cd ../..'
alias ...='cd ../../..'
alias ....='cd ../../../..'
alias ta='tmux attach-session -t'
alias tl='tmux list-sessions'
alias tk='tmux kill-session -t'
alias tka='tmux kill-server'
alias python-cont='docker run -it --rm -v .:/workdir -w /workdir python:alpine3.20 ash'

## Environment Variables
export PATH="$HOME/.local/bin:/opt/nvim/bin:$PATH"
export CDPATH=".:$HOME:$HOME/dev:$HOME/dev/me:$HOME/dev/im:$HOME/dev/uni:$HOME/.local:$HOME/.config"

if [ "$TMUX" = "" ]; then tmux; fi

gcap() {
	if [ -z $1 ]
	then
		git pull && git add -A && git commit -m "Update" && git push
	else
		git pull && git add -A && git commit -m $1 && git push
	fi
}

# Custom cd function to silence output when CDPATH is applied
cd() {
	if [ -z $1 ]  # If no argument is provided
	then builtin cd ~ # Change to home directory
	else builtin cd "$1" > /dev/null  # Change to specified directory, suppressing output
	fi
}

chrome() {
  "/mnt/c/Program Files/Google/Chrome/Application/chrome.exe" "$(wslpath -w "$1")"
}

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
export PATH=$PATH:/usr/local/go/bin
