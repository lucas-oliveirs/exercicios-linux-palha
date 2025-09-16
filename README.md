# Exercícios Linux – Samba

Lista de exercícios didáticos dados em aula para a matéria de Laboratório de Desenvolvimento II - Utilizando Linux Ubuntu Server v18.11

---

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

Comandos sequenciais:
1. cd /home  # para criar o diretório  
2. mkdir testedir  
3. chmod o+w testedir  # dando o direito de escrita aos others (o = others; w = write)  
4. ls -l  # visualizar permissões do diretório  
5. useradd marisa  # criar o usuário localmente
6. useradd gabriela  # criar o usuário localmente
7. cat /etc/passwd  # verificar a criação do usuário  
8. smbpasswd -a gabriela  # criação do usuário no Samba
9. smbpasswd -a marisa  # criação do usuário no Samba
10. pdbedit -L  # verifica os usuários Samba  
11. systemctl restart smbd  # reiniciando o Samba  
12. systemctl status smbd  # verificando o status/conexão do Samba  
13. ip -br a  # verificar o IP para teste no cliente
14. Teste de acesso remoto no Windows: colocar o IP da máquina na aba de acesso rápido
15. Realizar alguma alteração de teste para verificar o compartilhamento de escrita

---

## Exercício 3 – Apache + Samba

Integração de um site web com Apache e compartilhamento de arquivos via Samba.

### 1. Preparação e instalação
1) cd /  # voltar à raiz  
2) apt-get update  # atualizar lista de pacotes  
3) apt-get install apache2  # instalar Apache (e Samba se necessário)  
4) systemctl status apache2  # verificar se o Apache está ativo  
5) ip -br a  # verificar IP da máquina  

### 2. Configuração do Apache
1) cd /var/www/html  # acessar pasta padrão do Apache  
2) mkdir nportifolio  # criar diretório do portfólio  
3) cd nportifolio  # entrar no diretório  
4) cp /etc/apache2/sites-available/000-default.conf nportifolio.conf  # copiar configuração default

Conteúdo do nportifolio.conf com comentários explicativos:  
~~~apache
<VirtualHost *:80>
    # O site vai responder em todas as interfaces (*) na porta 80 (HTTP)
    ServerName serv1.nportifolio.local

    # E-mail do administrador (usado em mensagens de erro do Apache)
    ServerAdmin root@nportifolio.local

    # Pasta onde ficam os arquivos do site (index.html, CSS, imagens etc.)
    DocumentRoot /var/www/html/nportifolio

    # Nome alternativo para acessar o site (além do ServerName)
    ServerAlias nportifolio

    # Caminho do log de erros específicos deste VirtualHost
    ErrorLog ${APACHE_LOG_DIR}/error.log

    # Caminho do log de acessos, usando o formato combinado (mais detalhado)
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
~~~

5) a2ensite nportifolio.conf  # ativar site  
6) systemctl reload apache2  # reiniciar serviço Apache  
7) systemctl status apache2  # verificar status  

### 3. Configuração do Samba
1) nano /etc/samba/smb.conf  # editar configuração do Samba

Adicionar compartilhamento (salvar com ^O e sair com ^X):  
~~~ini
[portfolio]
comment = Portfólio pessoal; Mescla de Apache com Samba
path = /var/www/html/nportifolio
writable = yes
valid users = aluno, Magda, marisa, gabriela, loqueta
~~~

2) systemctl restart smbd  # reiniciar serviço Samba  

### 4. Testes e resultado
- Abrir navegador e acessar: http://<IP-da-máquina>  
- Usuários configurados no Samba podem acessar e editar os arquivos no diretório nportifolio  
- Integração completa entre serviço web (Apache) e compartilhamento de rede (Samba)

---

## Observações
- Execute todos os comandos como **root** ou **sudo**.  
- Certifique-se de que a rede local permite acesso aos serviços configurados.  
- Teste sempre o compartilhamento de escrita e a visualização da página web após alterações.  
- Este arquivo é um guia passo a passo; não é um script automatizado.
