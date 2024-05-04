#!/bin/sh
sudo apt update
sudo apt -y upgrade
sudo apt install -y git
curl -sSL https://get.docker.com/ | CHANNEL=stable bash
git clone $1 project
cd project
sudo docker compose up --build -d
