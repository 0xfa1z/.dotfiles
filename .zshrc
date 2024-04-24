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

HISTFILE=~/.zsh_history
SAVEHIST=1000

# makes autocompletion not case-sensitive
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}=[A-Za-z]'

alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias df=dotfiles
alias vzsh='vi ~/.zshrc'
alias vinit='vi ~/.config/nvim/init.lua'
# alias host='echo $HOSTNAME'
alias l='ls -la'
alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias ga='git add'
alias gaa='git add -A'
alias gc='git pull && git commit -m '
alias gp='git push'
alias vi='nvim'
alias vim='nvim'
alias .='cd ..'
alias ..='cd ../..'
alias ...='cd ../../..'
alias ....='cd ../../../..'

export JAVA_HOME="/usr"
export MAVEN_HOME="/opt/apache-maven-3.9.6"
export PATH="$HOME/.local/bin:$HOME/.local/nodejs/bin:$MAVEN_HOME/bin:$PATH"
export CDPATH=".:$HOME:$HOME/dev:$HOME/dev/im"
export KIP_HOME="$HOME/dev/im/kip"
export APP_DATA_PATH="$KIP_HOME/dev/appdata/dracar"

build() {
	local build_target=$1
	local image_name=$2
	local dockerfile="$HOME/.local/docker/Dockerfile"

        docker build --target $build_target -t $image_name -f $dockerfile .
}

create() {
        local image=$1
        local container_name=$2

        docker run -it --name $container_name \
            -v /var/run/docker.sock:/var/run/docker.sock \
            -v $HOME/:/home/sfaiz/ \
            -p 8080:8080 \
            $image /bin/zsh
}

enter() {
	docker start $1 > /dev/null
	docker exec -it $1 /bin/zsh
}

run() {
	local command=$1
	shift

	if [[ "$command" == "mvn" ]]; then
	    # docker run -it --rm --name mvn_build -v "$(pwd)":/usr/src/code -v $HOME/.m2:/root/.m2 -p 8081:8081 -w /usr/src/code maven:3.8.5-openjdk-17 mvn $@
	    docker run -it --rm --name mvn_build -v "$(pwd)":/usr/src/code -v $HOME/.m2:/root/.m2 -p 8081:8081 -w /usr/src/code maven:3.9.5 mvn $@
	elif [[ "$command" == "java" ]]; then
	    # docker run -it --rm --name java_run -v "$(pwd)":/usr/src/code -w /usr/src/code openjdk:17 java $@
	    docker run -it --rm --name java_run -v "$(pwd)":/usr/src/code -w /usr/src/code openjdk:21 java $@
	fi
}

if [ "$TMUX" = "" ]; then tmux; fi

# silences cd output, when cdpath is applied
cd() {
	# -z checks if empty
	if [ -z $1 ]
	then builtin cd ~
	else builtin cd "$1" > /dev/null
	fi
}

# Add JBang to environment
# alias j!=jbang
# export PATH="$HOME/.jbang/bin:$HOME/.jbang/currentjdk/bin:$PATH"
# export JAVA_HOME=$HOME/.jbang/currentjdk
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
export PATH="$PATH:/opt/mssql-tools18/bin"
