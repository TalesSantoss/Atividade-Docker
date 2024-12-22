# Atividade-Docker
Essa atividade tem como objetivo fazer o deploy de uma aplicação Wordpress por meio de docker em duas instâncias AWS EC2, um conteiner de aplicação AWS RDS MySQL, a utilização de um serviço EFS AWS para os estaticos do conteiner e um load balancer para gerenciar o trafego.
![arq](https://github.com/user-attachments/assets/a67a7220-2c70-4fdb-8500-a8533598747a)


# Objetivos
1. Criar VPC(Virtual Private Cloud) e suas devidas sub-redes
2. Criar Security Groups
3. Criar um RDS(Relational Database Service)
4. Criar script de automatização(user_data.sh)
5. Criar EFS(Elastic File System)

# Pré-requisitos
1. Uma conta AWS com as permissões certas.

# 1. Criação da VPC
1.1 Entrar na sua conta AWS e acessar aba de "VPC" e clique em "Criar VPC"

1.2 Em recursos a serem criados selecione "VPC e muito mais"

1.3 De resto, nomeie sua VPC, mantenha tudo em seu estado padrão e aperte em "criar VPC"

1.4 Após isso sua VPC deve ter uma estrutura similar a essa:
![image](https://github.com/user-attachments/assets/4045f80d-3347-4593-821e-db34c0ec9e37)

# 2. Criação dos Security Groups
2.1 Acesse a aba de "Security Groups" ou "Grupos de Segurança"

2.2 Aperte em "Criar Grupo de Segurança", e crie um grupo com as seguintes regras de entrada:
![image](https://github.com/user-attachments/assets/c5848a95-e4e0-4027-910b-6b6d927ed4d8)
Esse será o grupo público utilizado para o Load Balancer

2.3 Crie outro grupo com as seguintes regras:
![image](https://github.com/user-attachments/assets/fad132af-8f2b-488c-bb1d-3efd40bf17dc)
Esse será o grupo privado utilizado para a instância EC2, O RDS, e o EFS

**OBS: A regra de HTTP tem origem no grupo de segurança do Load Balancer**

2.4 Pronto! Seus grupos de segurança foram criados

# 3. Criação do Banco de dados RDS:
3.1 Vá na aba de "RDS" e selecione "Instâncias de banco de dados"

3.2 Aperte em "Criar banco de dados"

3.3 Selecione "MySQL" nas "opções de mecanismo", e selecione nivel gratuito em modelos

3.4 Nomeie e crie uma senha em "configurações de credenciais"

3.5 Escolha "db.t3.micro" em "configurações da instância"

3.6 Em "conectividade" escolha o grupo de segurança privado feito anteriormente, de resto as outras configurações ficam as mesmas

3.7 Aperte em "criar banco de dados"

# 4. Criação do EFS
4.1 Vá ate a aba de "EFS"

4.2 Aperte em "Criar sistema de arquivos, nomeie e crie seu EFS

# 5. Criação do script user_data.sh
5.1 Deve ser feito em shell e deve conter uma instalação do docker

5.2 Também deve ter um arquivo docker compose e a montagem do EFS

# 6. 



