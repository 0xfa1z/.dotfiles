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
alias df=dotfiles
alias vzsh='vi ~/.zshrc'
# alias host='echo $HOSTNAME'

# create work go-work-container go-dev-env
# create personal go-personal-container go-dev-env

build() {
	local build_target=$1
	local image_name=$2
	local dockerfile='Dockerfile'

        docker build --target $build_target -t $image_name -f $dockerfile .
}

create() {
        local image=$1
	local profile=$2
        local container_name=$3
        local ssh_folder_path
        local git_author_name
        local git_author_email

        if [ "$profile" == "me" ]; then
            ssh_folder_path="$HOME/.ssh.me"
            git_author_name="0xfa1z"
            git_author_email="sofian@faiz.digital"
	elif [ "$profile" == "im" ]; then
            ssh_folder_path="$HOME/.ssh"
            git_author_name="sfa1z"
            git_author_email="sfaiz@integrationmatters.com"
	elif [ "$profile" == "uni" ]; then
	    ssh_folder_path="$HOME/.ssh.uni"
            git_author_name="sof1an"
            git_author_email="sofian.faiz@rub.de"
        else
            echo "Invalid profile. Choose either 'me', 'im' or 'uni'."
            return 1
        fi

        docker run -it --name $container_name \
            -v /var/run/docker.sock:/var/run/docker.sock \
            -v $(pwd)/workdir:/home/sfaiz/workdir \
            -v $ssh_key_path:/root/.ssh/id_rsa \
            -e GIT_AUTHOR_NAME="$git_author_name" \
            -e GIT_AUTHOR_EMAIL="$git_author_email" \
            $image /bin/zsh


	# docker run -it --name $1 -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd)/workdir:/home/sfaiz/workdir -v $HOME/.ssh:/home/sfaiz/.ssh $2 /bin/zsh
}

enter() {
	docker start $1 > /dev/null
	docker exec -it $1 /bin/zsh
}

