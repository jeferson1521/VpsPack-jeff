#!/bin/bash
clear
echo ""
echo "$(tput bold) Script Para Autenticar o Squid proxy By @Jfsthebugs $(tput sgr0)"
echo "" 
 
apt update

apt upgrade


rm -rf /etc/squid3/squid.conf

echo "auth_param basic program /usr/lib/squid3/basic_ncsa_auth /root/passwd" >> /etc/squid3/squid.conf


echo "auth_param basic children 5" >> /etc/squid3/squid.conf

echo "acl usuarios_autenticados proxy_auth REQUIRED" >> /etc/squid3/squid.conf

echo "http_access allow usuarios_autenticados" >> /etc/squid3/squid.conf

echo "http_port 80" >> /etc/squid3/squid.conf

echo "http_port 8080" >> /etc/squid3/squid.conf

echo "visible_hostname jfsthebugs" >> /etc/squid3/squid.conf

echo "forwarded_for off" >> /etc/squid3/squid.conf

echo "via off" >> /etc/squid3/squid.conf

apt install apache2-utils

echo "Qual o nome do usuario ?"
read nome

htpasswd -c passwd $nome

sleep 4
service squid3 restart 
sleep 4
service ssh restart
echo "$(tput bold) Squid autenticado com sucesso.Script By @jfsthebugs $(tput sgr0)"