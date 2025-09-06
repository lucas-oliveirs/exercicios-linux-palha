# Exercícios Linux – Samba

Roteiro passo a passo de exercício de aula. Executado como root/sudo.

## Exercício 1 – Compartilhamento

1) apt install samba  # verificando a instalação do samba  
2) networkctl status  # verificando as configurações de rede da máquina  
3) systemctl status smbd  # verificando o status do samba  
4) cd /  # voltando para a raiz  
5) cd /etc/samba  # indo ao diretório do samba  
6) ls  # listando os diretórios  
7) nano smbd.conf  # editando o arquivo de configuração do samba

Declaração de novo compartilhamento (salvar com ^O e sair com ^X):  
~~~ini
[SECRETARIA]  # nome
path = /home/SECDIR  # caminho do diretório
valid users = jussara  # usuário proprietário
~~~

8) cd /home  # voltando ao diretório home  
9) mkdir SECDIR  # criando o diretório definido no samba  
10) cd /home/SECDIR  # entrando no diretório  
11) nano aviso.txt  # criar arquivo de teste  
12) cd /  # voltar à raiz  
13) useradd jussara  # criação do usuário  
14) cat /etc/passwd  # verificar criação do usuário  
15) smbpasswd -a jussara  # definir senha do usuário no samba  
16) pdbedit -L  # listar usuários do samba  
17) systemctl restart smbd  # reiniciar o serviço  
18) networkctl status  # verificar o IP da máquina  

19) Teste no Windows: na barra de endereços, digite \\IP_DA_MÁQUINA  (ex.: \\192.168.0.12)

---

## Exercício 2 – Compartilhamento público (múltiplos usuários)

1) cd /  # voltar à raiz  
2) nano /etc/samba/smb.conf  # editar configuração

Conteúdo (salvar com ^O e sair com ^X):  
~~~ini
[publico]
comment = teste de compartilhamento de escrita  # comentário
path = /home/testedir
valid users = marisa, gabriela
writable = yes
~~~

3) cd /home  
4) mkdir testedir  # criar diretório  
5) chmod o+w testedir  # ajustar permissões (gravação para outros)


- `ip -br a`  # lista os IPs das interfaces de rede em formato resumido (brief)  
- `nano -l /etc/samba/smb.conf`  # editando a configuração do Samba com numeração de linhas


Comandos sequenciais:
1. `cd /home`  # para criar o diretório  
2. `mkdir testedir`  
3. `chmod o+w testedir`  # dando o direito de escrita aos others (o = others; w = write)  
4. `ls -l`  # para visualizar o resultado, ver as permissões do diretório  
5. `useradd marisa`  # criar o usuário localmente
6. `useradd gabriela` # criar o usuário localmente
7. `cat /etc/passwd`  # verificar a criação do usuário  
8. `smbpasswd -a gabriela`  # criação do usuário no Samba
9. `smbpasswd -a marisa`  # criação do usuário no Samba
10. `pdbedit -L`  # verifica os usuários Samba  
11. `systemctl restart smbd`  # reiniciando o Samba  
12. `systemctl status smbd`  # verificando o status/conexão do Samba  
13. `ip -br a`  # verificar o IP para teste no cliente
14. Realizar o acesso remoto colocando o IP da máquina na aba de acesso rápido do Windows
15. Realizar alguma alteração de teste para verificar o compartilhamento de escrita

---

## Observações
- Execute os comandos como **root** ou com **sudo**.  
- Este arquivo é um guia passo a passo; não é um script automatizado.
