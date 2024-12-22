# Atividade-Docker
Essa atividade tem como objetivo fazer o deploy de uma aplicação Wordpress por meio de docker em duas instâncias AWS EC2, um conteiner de aplicação AWS RDS MySQL, a utilização de um serviço EFS AWS para os estaticos do conteiner e um load balancer para gerenciar o trafego.
![arq](https://github.com/user-attachments/assets/a67a7220-2c70-4fdb-8500-a8533598747a)


# Objetivos
1. Criar VPC(Virtual Private Cloud) e suas devidas sub-redes
2. Criar NAT Gateway
3. Criar Security Groups
4. Criar um RDS(Relational Database Service)
5. Criar EFS(Elastic file System)
6. Criar script de automatização(user_data.sh)
7. Criar Instância EC2

# Pré-requisitos
1. Uma conta AWS com as permissões certas.

# 1. Criação da VPC
1.1 Entrar na sua conta AWS e acessar aba de "VPC" e clique em "Criar VPC"

1.2 Em recursos a serem criados selecione "VPC e muito mais"

1.3 De resto, nomeie sua VPC, mantenha tudo em seu estado padrão e aperte em "criar VPC"

1.4 Após isso sua VPC deve ter uma estrutura similar a essa:
![image](https://github.com/user-attachments/assets/4045f80d-3347-4593-821e-db34c0ec9e37)

# 2. Criação do NAT Gateway
2.1 Vá ate a aba de "Gateways NAT" e aperte em "criar gateway NAT"

2.2 Selecione uma subrede publica e aloque um ip elástivo, apos isso clique em "criar gateway NAT"

2.3 Após isso, vá até "Tabela de Rotas", selecione as tabelas ligadas as subredes privadas e adicione uma rota em cada uma com alvo no gateway NAT
![image](https://github.com/user-attachments/assets/3fe5dd69-ba71-4eff-83b4-fbfa6e052b84)


# 3. Criação dos Security Groups
3.1 Acesse a aba de "Security Groups" ou "Grupos de Segurança"

3.2 Aperte em "Criar Grupo de Segurança", e crie um grupo com as seguintes regras de entrada:
![image](https://github.com/user-attachments/assets/c5848a95-e4e0-4027-910b-6b6d927ed4d8)
Esse será o grupo público utilizado para o Load Balancer

3.3 Crie outro grupo com as seguintes regras:
![image](https://github.com/user-attachments/assets/fad132af-8f2b-488c-bb1d-3efd40bf17dc)
Esse será o grupo privado utilizado para a instância EC2, O RDS, e o EFS

**OBS: A regra de HTTP tem origem no grupo de segurança do Load Balancer**

# 4. Criação do Banco de dados RDS:
4.1 Vá na aba de "RDS" e selecione "Instâncias de banco de dados"

4.2 Aperte em "Criar banco de dados"

4.3 Selecione "MySQL" nas "opções de mecanismo", e selecione nivel gratuito em modelos

4.4 Nomeie e crie uma senha em "configurações de credenciais"

4.5 Escolha "db.t3.micro" em "configurações da instância"

4.6 Em "conectividade" escolha o grupo de segurança privado feito anteriormente, de resto as outras configurações ficam as mesmas

4.7 Aperte em "criar banco de dados"

# 5. Criação do EFS
5.1 Vá ate a aba de "EFS"

5.2 Aperte em "Criar sistema de arquivos, nomeie e crie seu EFS

# 6. Criação do script user_data.sh
6.1 Deve ser feito em shell e deve conter uma instalação do docker

6.2 Também deve ter um arquivo docker compose e a montagem do EFS

# 7. Criação da EC2
7.1 Vá até a aba de EC2 e aperte em "executar instância"

7.2 Ao criar a instância, utilize as tags necessárias e o tipo de instância "t2.micro"

7.3 Selecione um par de chaves e em conectividade, escolha nâo habilitar ip publico e selecione uma subrede privada e o grupo de segurança privado

7.4 Após isso, em "detalhes avançados", coloque o script "user_data.sh" e clique em "executar instância"
