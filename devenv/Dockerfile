# Use an existing image as a base
FROM ubuntu:latest

# Run package updates and install packages
RUN apt-get update \
    && apt-get install -y git vim curl

# Set an environment variable for the Git token
ARG GIT_TOKEN
ARG GIT_NAME
ARG GIT_EMAIL
ENV GIT_TOKEN=${GIT_TOKEN}
ENV GIT_NAME=${GIT_NAME}
ENV GIT_EMAIL=${GIT_EMAIL}

# Setup Git Configurations
RUN git config --global user.name ${GIT_NAME} \
    && git config --global user.email ${GIT_EMAIL}

# Change to home directory, clone the repository, and setup the work tree
RUN cd $HOME \
    && git clone --bare https://github.com/0xfa1z/dotfiles.git $HOME/.dotfiles \
    && git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout

# Execute the install script
RUN chmod +x $HOME/install.sh \
    && $HOME/install.sh
