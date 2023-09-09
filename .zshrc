## prompt
bindkey -v # vim mode
PROMPT="%F{cyan}%~ %f "
# RPROMPT="%*"
# git prompt
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{yellow}(%b) %r%f'
zstyle ':vcs_info:*' enable git

# makes autocompletion not case-sensitive
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}=[A-Za-z]'

alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
