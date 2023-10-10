include ../.env.im

DOCKERFILE ?= Dockerfile
TARGET ?= docker-env
TAG ?= njams-containerized

build:
	docker build --target $(TARGET) --build-arg GIT_TOKEN=$(GIT_TOKEN) --build-arg GIT_NAME=$(GIT_NAME) --build-arg GIT_EMAIL=$(GIT_EMAIL) -t $(TAG) -f $(DOCKERFILE) .

docker-build:
	docker build --build-arg GIT_TOKEN=$(GIT_TOKEN) --build-arg GIT_NAME=$(GIT_NAME) --build-arg GIT_EMAIL=$(GIT_EMAIL) -t $(TAG) -f Dockerfile.docker .

run:
	docker run -it --name $(TAG) -v /var/run/docker.sock:/var/run/docker.sock -v $(shell pwd)/workdir:/home/sfaiz/workdir -v $(HOME)/.ssh:/home/sfaiz/.ssh $(TAG) /bin/zsh

.PHONY: build run
