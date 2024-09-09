#!/bin/bash

# Dockerのインストール
# sudo dnf install -y docker
sudo yum install -y docker

# ec2-userをdockerグループに追加
sudo usermod -a -G docker ec2-user

# Dockerサービスの自動起動を設定
sudo systemctl enable docker

# Dockerサービスを開始
sudo systemctl start docker

# Docker Composeのインストール
DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
mkdir -p $DOCKER_CONFIG/cli-plugins
curl -SL https://github.com/docker/compose/releases/download/v2.4.1/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose

# 実行後、インスタンスの再起動（グループが反映されてdockerコマンドが使えるようになる）
sudo reboot