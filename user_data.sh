#!/bin/bash 
#Indica ao sistema para usar o interpretador bash
 
sudo yum update -y #atualiza o sistema
sudo yum install docker -y #instala o docker
sudo systemctl start docker # inicia o serviço docker
sudo systemctl enable docker #Faz com que o docker seja inicializado toda vez que a maquina for ligada
sudo usermod -aG docker ec2-user #Adiciona o usuário ec2-user para o grupo docker
newgrp docker #Muda a sessão shell para o grupo docker
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose #instala o docker  compose
sudo chmod +x /usr/local/bin/docker-compose #torna o docekr-compose executável
sudo mkdir /home/ec2-user/wordpress #cria uma pasta chamada wordpress
cat <<EOF > /home/ec2-user/wordpress/docker-compose.yml #cria um arquivo docker compose do wordpress
services:
 
  wordpress:
    image: wordpress
    restart: always
    ports:
      - 8080:80
    environment:
      WORDPRESS_DB_HOST: <Endpoint do RDS>:3306
      WORDPRESS_DB_USER: <usuário do RDS>
      WORDPRESS_DB_PASSWORD: <Senha do RDS>
      WORDPRESS_DB_NAME: <Nome do banco de dados>
    volumes:
      - /mnt/efs:/var/www/html
EOF
 sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport <DNS do EFS>:/ /mnt/efs #faz a montagem do EFS
docker-compose -f /home/ec2-user/wordpress/docker-compose.yml up -d #Inicia o container docker-compose.yml
