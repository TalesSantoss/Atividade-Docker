# Atividade-Docker
Essa atividade tem como objetivo fazer o deploy de uma aplicação Wordpress por meio de docker em duas instâncias AWS EC2, um conteiner de aplicação AWS RDS MySQL, a utilização de um serviço EFS AWS para os estaticos do conteiner e um load balancer para gerenciar o trafego.
![arq](https://github.com/user-attachments/assets/a67a7220-2c70-4fdb-8500-a8533598747a)


# Objetivos
2. Subir uma instância EC2 com as tags certas e com o script user_data.sh
3. Criar banco de dados RDS AWS
4. Criar um EFS(Elastic Fyle System)
5. Criar um Load Balancer
6. Criar um Grupo de Auto Scaling

# Pré-requisitos
1. Uma conta AWS com as permissões certas.

# Grupos de Segurança
EFS:Tipo NFS
EC2:Tipo HTTP com origem 0.0.0.0/0, tipo SSH com origem 0.0.0.0/0, tipo MYSQL/AURORA com origem 0.0.0.0/0
RDS:Tipo MYSQL/AURORA com origem no grupo de segurança EC2
LOADBALANCER:Tipo HTTP com origem 0.0.0.0/0

# Requisitos do Script de automação(user_data.sh)
1. Instalar Docker
2. Instalar o Docker Compose
3. Criar arquivo "Docker-compose.yml", que contem o wordpress e suas devidas configurações

# Configuração do modelo de execução da instância EC2
1. Entrar na aba de "EC2"
2. Entrar em "Modelos de execução" e selecione "criar modelo de execução"
3. Colocar tags
4. Escolher opções adequadas ao nível gratuito
5. Selecionar grupos de segurança corretamente
6. ir na aba de "dados adicionais" e colocar o script user_data.sh no campo especificado
7. Salvar modelo

# Criar Banco de dados RDS
1. Entrar na aba de "RDS"
2. Apertar em criar banco de dados
3. Escolher "MySQL" e "Instância de banco de dados única"
4. Configurar normalmente e selecionar grupos de segurança
5. Apertar em "Criar banco de dados"

# Criar um Elastic File System
1. Entrar na aba "EFS"
2. Apertar em "criar sistema de arquivos"
3. Selecione o nome e a VPC
4. Aperte em "criar"

# Criar um Load Balancer
1. Ir na aba de "Load Balancers"
2. Aperte em "criar um Load Balancer"
3. Selecione "criar um Load Balancer Classic"
4. 
