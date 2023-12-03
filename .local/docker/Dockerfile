# ----- Base Stage ----- 
FROM ubuntu:latest AS base-env

## Installations
# Run package updates and install packages
RUN apt-get update && \
    apt-get install -y apt-utils sudo git vim zsh tmux wget curl unzip tar tree make 
#     rm -rf /var/lib/apt/lists/*

# Add Docker's official GPG key:
RUN sudo apt-get install -y ca-certificates curl gnupg && \
    sudo install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    sudo chmod a+r /etc/apt/keyrings/docker.gpg 

# Add the repository to Apt sources:
RUN echo \
    "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN sudo apt-get update

RUN sudo apt-get install -y docker-ce-cli docker-buildx-plugin docker-compose-plugin

# Set root password
RUN echo 'root:root' | chpasswd

# Create user and set password
RUN useradd -m -s /bin/zsh sfaiz && \
    echo 'sfaiz:sfaiz' | chpasswd && \
    usermod -aG sudo sfaiz

RUN groupadd -g 1001 docker # -g <HOST_DOCKER_GROUP_GID> docker
# RUN groupmod -g 1001 docker
RUN usermod -aG docker sfaiz

# You could COPY a .zshrc file here if you have one on your host
COPY .zshrc /home/sfaiz/.zshrc
COPY .tmux.conf /home/sfaiz/.tmux.conf
RUN chown sfaiz:sfaiz /home/sfaiz/.zshrc
RUN chown sfaiz:sfaiz /home/sfaiz/.tmux.conf
# RUN mkdir -p /home/sfaiz/workdir && chown sfaiz:sfaiz /home/sfaiz/workdir
# VOLUME ["/home/sfaiz/workdir"]
USER sfaiz
WORKDIR /home/sfaiz

# ----- Go Stage -----
FROM base AS go-env

# Install Go
USER root

RUN apt-get update && \
    rm -rf /var/lib/apt/lists/*

# Download and extract Go
RUN wget https://go.dev/dl/go1.21.2.linux-amd64.tar.gz && \
    tar -xvf go1.21.2.linux-amd64.tar.gz && \
    mv go /usr/local && \
    rm go1.21.2.linux-amd64.tar.gz

USER sfaiz
RUN echo 'export PATH=$PATH:/usr/local/go/bin' >> /home/sfaiz/.zshrc

# ----- Java Stage -----
FROM base AS java-env

# Install Java
USER root
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk && \
    rm -rf /var/lib/apt/lists/*
USER sfaiz

# ----- ANN Stage -----
FROM base AS ann-env

USER root 
ENV DEBIAN_FRONTEND=noninteractive
# to allow for add-apt-repository:
RUN apt-get install -y software-properties-common
RUN apt install -y wget build-essential libncursesw5-dev libssl-dev \
libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev

RUN add-apt-repository ppa:deadsnakes/ppa

RUN apt install -y python3.11

RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python3.11 get-pip.py
USER sfaiz
