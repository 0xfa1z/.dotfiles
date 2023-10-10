# ----- Base Stage ----- 
FROM ubuntu:latest AS base

# Run package updates and install packages
RUN apt-get update && \
    apt-get install -y git vim curl zsh sudo make tar tree wget 
#     rm -rf /var/lib/apt/lists/*
# to allow for add-apt-repository:
RUN apt-get install -y software-properties-common
RUN apt-get install -y docker.io

# Set an environment variable for the Git token
ARG GIT_TOKEN
ARG GIT_NAME
ARG GIT_EMAIL
ENV GIT_TOKEN=${GIT_TOKEN}
ENV GIT_NAME=${GIT_NAME}
ENV GIT_EMAIL=${GIT_EMAIL}

# Set root password
RUN echo 'root:root' | chpasswd

# Create user and set password
RUN useradd -m -s /bin/zsh sfaiz && \
    echo 'sfaiz:sfaiz' | chpasswd && \
    usermod -aG sudo sfaiz

# RUN groupadd docker # -g <HOST_DOCKER_GROUP_GID> docker
RUN groupmod -g 1001 docker
RUN usermod -aG docker sfaiz


# Switch to the user
USER sfaiz
WORKDIR /home/sfaiz


# You could COPY a .zshrc file here if you have one on your host
USER root
COPY .zshrc /home/sfaiz/.zshrc
RUN chown sfaiz:sfaiz /home/sfaiz/.zshrc
RUN mkdir -p /home/sfaiz/workdir && chown sfaiz:sfaiz /home/sfaiz/workdir
VOLUME ["/home/sfaiz/workdir"]
USER sfaiz

# Setup Git Configurations
RUN git config --global user.name ${GIT_NAME} \
    && git config --global user.email ${GIT_EMAIL}

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
