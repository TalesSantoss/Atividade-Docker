# Atividade-Docker
Essa atividade tem como objetivo fazer o deploy de uma aplicação Wordpress por meio de docker em duas instâncias AWS EC2, um conteiner de aplicação AWS RDS MySQL, a utilização de um serviço EFS AWS para os estaticos do conteiner e um load balancer para gerenciar o trafego.
# Objetivos
1. Criar um script de automação(user_data.sh)
2. Subir uma instância EC2 com as tags certas e com o script
3. Criar banco de dados RDS AWS
4. Criar um EFS(Elastic Fyle System)
5. Criar um Load Balancer

# Pré-requisitos
1. Uma conta AWS com as permissões certas.   
2. Qualquer terminal de ssh(putty, MobaXterm, etc...)

# Requisitos do Script de automação(user_data.sh)
1. Instalar Docker
2. Instalar e configurar o MySQL
3. Criar arquivo "Docker-compose.yml", que contem o wordpress e suas devidas configurações

# Configuração da instância EC2
1. Entrar e fazer login no site da AWS
2. Entrar na aba de "EC2"
3. Colocar as devidas Tags
4. Escolher opções adequadas ao nível gratuito
5. Permitir IP público(para conexão SSH)
6. Selecionar grupos de segurança corretamente
7. ir na aba de "dados adicionais" e colocar o script user_data.sh no campo especificado
8. Executar instância

# Criar Banco de dados RDS
1. Entrar na aba de "RDS"
2. Apertar em criar banco de dados
3. Escolher "MySQL" e "Instância de banco de dados única"
4. Configurar normalmente e selecionar grupos de segurança
5. Apertar em "Criar banco de dados"
# Criar um Elastic File System
# Criar um Load Balancer
