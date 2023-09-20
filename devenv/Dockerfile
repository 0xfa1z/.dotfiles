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

