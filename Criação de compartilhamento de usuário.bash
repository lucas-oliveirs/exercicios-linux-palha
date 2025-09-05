apt install samba # verificando a instalação do samba

networkctl status  # verificando as configurações de rede da máquina

systemctl status smbd # verificando o status do samba

cd / # voltando para a raiz

cd /etc/samba # indo ao diretório do samba

ls # listando os diretórios

nano smbd.conf # editando o arquivo de configuração do samba

# declaração de novo compartilhamento

## ARQUIVO DE CONFIGURAÇÃO DO SAMBA
[SECRETARIA] # NOME
path = /home/SECDIR # caminho do diretório
valid user = jussara # nome do usuário proprietário desse diretório
## ARQUIVO DE CONFIGURAÇÃO DO SAMBA
## APÓS A DEFINIÇÃO, ^O E ^X - SALVAR E SAIR


cd /home ## voltando ao diretório home

mkdir SECDIR # criando o diretório que foi criado no samba, já que no samba foi somente a configuração de um arquivo
# na linha de comando que é realmente criado o diretório

cd /home/SECDIR # indo para o diretório SECDIR
 
nano aviso.txt # criação de um arquivo de texto com um simples teste

cd / # voltando a raiz

useradd jussara # criação do usuário jussara

cat /etc/passwd # verificação da criação do usuário

smbpasswd -a jussara # criação da senha do novo usuário

pdbedit -L # verificação de usuários samba

systemctl restart smbd # reiniciando o samba

networkctl status # verificando o ip da máquina

## após isso, verificar no lado cliente no windows. indo na barra de acesso rápido e coloca o ip da máquina linux
# com duas barras invertidas "\\". ex: \\192.168.0.12


# EXERCICIO 2 

cd / # voltando a raiz

nano /etc/samba/smb.conf # configurando novamente o samba

## ARQUIVO DE CONFIGURAÇÃO DO SAMBA
[publico] 
comment = teste de compartilhamento de escrita # comentáro
path = /home/testedir
valid user = marisa, gabriela
writable = yes
## ARQUIVO DE CONFIGURAÇÃO DO SAMBA
## APÓS A DEFINIÇÃO, ^O E ^X - SALVAR E SAIR

cd /home 

mkdir testedir # criação do diretorio

chmod o+w testedir # alterando o moderador/dono do diretório (permissões)



