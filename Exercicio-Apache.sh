cd / # voltando a raiz
apt-get update # atualiza a lista de pacotes
apt-get install apache2 # instala o Samba e o Apache se necessário
systemctl status apache2 # verifica o status do serviço Apache
ip -br a # ip da máquina

cd /var/www/html # indo a pasta html para criar uma página
mkdir nportifolio # criando meu diretório de portifólio
cd nportifolio # mudando de pasta

cp 000-default.conf nportifolio.conf # copiando o arquivo default de configuração 

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

a2ensite.conf # ativando o site

systemctl reload apache2 # reiniciando o serviço
systemctl status apache2 


