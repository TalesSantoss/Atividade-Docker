# Atividade-Docker
Essa atividade tem como objetivo fazer o deploy de uma aplicação Wordpress por meio de docker em duas instâncias AWS EC2, um conteiner de aplicação AWS RDS MySQL, a utilização de um serviço EFS AWS para os estaticos do conteiner e um load balancer para gerenciar o trafego.
# Objetivos
1.Criar um script de automação(user_data.sh)
2.Subir uma instância EC2 com as tags certas e com o script
3.Criar banco de dados RDS AWS
4.Criar um EFS(Elastic Fyle System)
5.Criar um Load Balancer
# Pré-requisitos
1. Uma conta AWS com as permissões certas.
2. Qualquer terminal de ssh(putty, MobaXterm, etc...)
# Configuração do Script de automação(user_data.sh)
