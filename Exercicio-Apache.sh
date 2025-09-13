apt-get update # atualiza a lista de pacotes
apt-get install -y samba apache2 # instala o Samba e o Apache se necessário
systemctl status apache2 # verifica o status do serviço Apache
ip -br a # exibe os endereços IP das interfaces de rede
systemctl status smbd # verifica o status do serviço Samba

cd /var/www/
mkdir ndominio # cria o diretório ndominio
cd ndominio
nano index.html # cria um arquivo HTML simples

cd /etc/apache2/sites-available/

cp 000-default.conf ndominio.conf # copia o arquivo de configuração padrão

nano -l ndominio.conf # edita o arquivo de configuração para o novo domínio

a2ensite ndominio.conf # habilita o novo site
systemctl reload apache2 # recarrega o serviço Apache para aplicar as mudanças