#!/bin/bash

# Lendo configurações gerais
. vhost.conf

echo "----------------------------------------------------------------------";
echo "                 Processo de Criação do Virtual Host                  ";
echo "----------------------------------------------------------------------";
 
echo "Informe o projeto: (deve estar dentro de $path)"
read vhost
 
echo "----------------------------------------------------------------------";
echo "                        Criando o virtual host                        ";
echo "----------------------------------------------------------------------";
echo "
<VirtualHost *:80>
	ServerAdmin webmaster@localhost
	ServerName $vhost
	ServerAlias www.$vhost 
	DocumentRoot $path/$vhost
	<Directory $path/$vhost>
		Options Indexes FollowSymLinks MultiViews
		AllowOverride All
		Order allow,deny
		Allow from all
	</Directory>
</VirtualHost>" > /etc/apache2/sites-available/$vhost.conf

echo "----------------------------------------------------------------------";
echo "                        Ativando VHOST $vhost                         ";

a2ensite $vhost.conf;

echo "----------------------------------------------------------------------";
echo "                      Atualizando arquivo hosts                       ";

echo "127.0.1.1     $vhost www.$vhost" >> /etc/hosts;

echo "----------------------------------------------------------------------";
echo "                       Restartando o A  pache                         ";

service apache2 restart
 
echo "Virtual Host criado, use esse endereço para acessar: http://$vhost";