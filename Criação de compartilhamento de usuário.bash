apt install samba # verificando a instalação do samba

networkctl status  # verificando as configurações de rede da máquina

systemctl status smbd # verificando o status do samba

cd / # voltando para a raiz

cd /etc/samba # indo ao diretório do samba

ls # listando os diretórios

nano smbd.conf # editando o arquivo de configuração do samba

# declaração de novo compartilhamento

[SECRETARIA] # NOME
path = /home/SECDIR # caminho do diretório
valid user = jussara # nome do usuário proprietário desse diretório

##

cd /home ## voltando ao diretório home

mkdir SECDIR # criando o diretório que foi criado no samba, já que no samba, foi a configuração de um arquivo
# na linha de comando que é realmente criado o diretório

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





