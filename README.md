# Atividade-Docker
Essa atividade tem como objetivo fazer o deploy de uma aplicação Wordpress por meio de docker na AWS em duas instâncias EC2, um conteiner de aplicação RDS MySQL, a utilização de um serviço EFS para os estaticos do conteiner, um load balancer para gerenciar o trafego e um grupo de Auto Scaling para gerar escalabilidade para a aplicação
![arq](https://github.com/user-attachments/assets/a67a7220-2c70-4fdb-8500-a8533598747a)


# Objetivos
1. Criar VPC(Virtual Private Cloud) e suas devidas sub-redes
2. Criar Security Groups
3. Criar um RDS(Relational Database Service)
4. Criar EFS(Elastic file System)
5. Criar script de automatização(user_data.sh)
6. Criar Instância EC2
7. Criar Load Balancer
8. Criar Grupo de Auto Scaling
9. Testar o Wordpress

# Pré-requisitos
1. Uma conta AWS com as permissões certas.

# 1. Criação da VPC
1.1 Entrar na sua conta AWS e acessar aba de "VPC" e clique em "Criar VPC"

1.2 Em recursos a serem criados selecione "VPC e muito mais"

1.3 De resto, nomeie sua VPC, escolha "1 por AZ" em Gateways NAT, mantenha as outras configurações como estão e aperte em "criar VPC"

1.4 Após isso sua VPC deve ter uma estrutura similar a essa:
![image](https://github.com/user-attachments/assets/a4fa9cec-0537-44c5-8a29-05e00af75805)

# 2. Criação dos Security Groups
2.1 Acesse a aba de "Security Groups" ou "Grupos de Segurança"

2.2 Aperte em "Criar Grupo de Segurança", e crie um grupo público com as seguintes regras de entrada:
<img src="https://github.com/user-attachments/assets/5ef01ab2-e7fa-4e96-8be8-ada0c5a9f0ef" alt="Descrição da imagem">
<div align="center">
Esse será o grupo público utilizado para o Load Balancer
</div>
<br/>

2.3 Crie outro grupo com as seguintes regras:

<img src="https://github.com/user-attachments/assets/46519c5f-4dcb-4c9c-bada-8f3b18d526f5" alt="Descrição da imagem">
<div align="center">
Esse será o grupo privado utilizado para a instância EC2, O RDS, e o EFS
</div>
<br/>

***OBS: A regra de HTTP e HTTPS tem origem no grupo de segurança público***

# 3. Criação do Banco de dados RDS:

3.1 Vá ate a aba "RDS" e antes de criar o banco de dados aperte em "Grupos de Subredes" no canto direito da tela

3.2 Aperte em "Criar Grupo de Subredes"

3.3 Selecione a VPC e as Subredes privadas e depois aperte em "Criar"

3.4 Na aba de "RDS" selecione "Instâncias de banco de dados"

3.5 Aperte em "Criar banco de dados"

3.6 Selecione "MySQL" nas "opções de mecanismo", e selecione nivel gratuito em modelos

3.4 Nomeie e crie uma senha em "configurações de credenciais"

3.5 Escolha "db.t3.micro" em "configurações da instância"

3.6 Em "conectividade" escolha o grupo de segurança privado feito anteriormente

3.7 Em "detalhes adicionais" dê um nome ao banco de dados, de resto as outras configurações ficam as mesmas

3.7 Aperte em "criar banco de dados"

# 4. Criação do EFS
4.1 Vá ate a aba de "EFS"

4.2 Aperte em "Criar sistema de arquivos, nomeie e crie seu EFS

4.3 Vá nos detalhes do sistema de aequivos e aperte em "anexar", lá escolha a montagem pelo DNS e copie a segunda opção para usar no "user_data.sh"

# 5. Criação do script user_data.sh
5.1 Deve ser feito em shell e deve conter uma instalação do docker

5.2 Também deve ter um arquivo docker compose e a montagem do EFS

5.3 Deve ficar mais ou menos assim:

``` 
#!/bin/bash 
 
sudo yum update -y 
sudo yum install docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user
newgrp docker
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo mkdir /home/ec2-user/wordpress
cat <<EOF > /home/ec2-user/wordpress/docker-compose.yml
services:
 
  wordpress:
    image: wordpress
    restart: always
    ports:
      - 80:80
    environment:
      WORDPRESS_DB_HOST: <Endpoint do Banco>
      WORDPRESS_DB_USER: <Usuário do banco>
      WORDPRESS_DB_PASSWORD: <Senha do Usuário>
      WORDPRESS_DB_NAME: <Nome do banco de dados feito anteriormente>
    volumes:
      - /mnt/efs:/var/www/html
EOF
sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport <DNS do EFS>:/ /mnt/efs
docker-compose -f /home/ec2-user/wordpress/docker-compose.yml up -d
``` 
# 6. Criação da EC2
6.1 Vá até a aba de EC2 e aperte em "executar instância"

6.2 Ao criar a instância, utilize as tags necessárias e o tipo de instância "t2.micro"

6.3 Selecione um par de chaves e em conectividade, escolha nâo habilitar ip publico e selecione uma subrede privada e o grupo de segurança privado

6.4 Após isso, em "detalhes avançados", coloque o script "user_data.sh" em "dados do usuário" e depois clique em "executar instância"

6.5 Faça o mesmo processo duas vezes, e no segundo escolha uma subrede privada em outra zona de disponibilidade

6.6 Após a criação, escolha qualquer uma das duas instâncias vá em "Ações > Imagens e modelos > criar modelo a partir da instância" e nessa parte coloque qualquer coisa que estiver faltando e na area de subredes, selecione "Não incluir no modelo de execução" e depois aperte em "criar modelo de execução"
***OBS:Essa ultima etapa será usada para criação do Auto Scaling***

# 7. Criação do Load Balancer
***OBS: Espere as instâncias inicializarem antes de iniciar essa etapa***

7.1 Vá até a aba de "Load Balancer" e aperte em "criar Load Balancer"

7.2 Selecione "Classic Load Balancer

7.3 Nomeie o load balancer, escolha a vpc, as subredes públicas e o grupo de segurança público

7.4 Em "verificações de integridade", na parte de "caminho de ping", coloque "/wp-admin/install.php", e nas "configurações avançadas de verificação de integridade" colocar:
![image](https://github.com/user-attachments/assets/fbdd7448-bcdb-4bab-af56-fbbaa2e413cf)

7.5 Selecione as instâncias criadas e depois aperte em "Criar Load Balancer"

# 8. Criação do Grupo de Auto Scaling

8.1 Na aba de EC2, selecione "Grupos de Auto Scaling"

8.2 Aperte em "criar grupo de Auto Scaling"

8.3 Nomeie e selecione o modelo de execução criado anteriormente

8.4 Na etapa 2, selecione a vpc e as subredes privadas

8.5 Na etapa 3, anexe o load balancer criado anteriormente

8.6 Na etapa 4, coloque o tamanho do grupo e a escalabilidade como "2"

8.7 O resto das configurações prossegue normalmente e depois é só apertar em "criar grupo de auto scaling"

# 9. Testagem do Wordpress

9.1 Copie o DNS do Load Balancer e coloque no seu navegador de internet

9.2 Se a tela de login do Wordpress aparecer, tudo correu como o esperado
![image](https://github.com/user-attachments/assets/d44e411f-8044-4c1c-b69e-8434075d744b)

