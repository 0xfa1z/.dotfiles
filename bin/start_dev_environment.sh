#!/bin/bash
export GIT_TOKEN=$(cat .env.im | grep GIT_TOKEN | cut -d '=' -f2)
export GIT_NAME=$(cat .env.im | grep GIT_NAME | cut -d '=' -f2)
export GIT_EMAIL=$(cat .env.im | grep GIT_EMAIL | cut -d '=' -f2)
docker-compose up --build -d 

