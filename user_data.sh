#!/bin/bash

sudo su
apt update -y
apt upgrade -y
apt install -y docker.io git
systemctl start docker
systemctl enable docker
apt install mysql -y

mysql -h (domínio ou host) -P 3306 -u (usuário) -p(senha)! <<EOF
CREATE DATABASE ;
EXIT;
EOF

mkdir -p /usr/lib/docker/cli-plugins
curl -o /usr/lib/docker/cli-plugins/dockercompose -SL https://github.com/docker/compose/releases/download/v2.30.3/docker-compose-linux-x86_64 
chmod +x /usr/lib/docker/cli-plugins/dockercompose
usermod -aG docker ubuntu
mkdir -p /home/ubuntu/wordpress
cd /home/ubuntu/wordpress

sudo cat <<EOF > Docker-Compose.yml
services:
  wordpress:
    image: wordpress:latest
    restart: always
    ports:
      - 8080:80
    enviroment
      WORDPRESS_DB_HOST: 
      WORDPRESS_DB_USER: 
      WORDPRESS_DB_PASSWORD: 
      WORDPRESS_DB_NAME: 
volumes:
  wordpress_data:
EOF
