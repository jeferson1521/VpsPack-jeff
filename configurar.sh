#!/bin/bash
clear
echo ""
echo "$(tput bold) Configurar Vps com Squid Proxy Autenticado. Script By @Jfsthebugs $(tput sgr0)"
echo "" 
 
apt update

apt upgrade

apt install nano 

apt install htop

apt install squid3

killall apache2

apt purge apache2

echo "Qual o IP do servidor?"
read ip

echo "Port 443" >> /etc/ssh/sshd_config

rm -rf /etc/squid3/squid.conf

echo "acl x dstdomain $ip" >> /etc/squid3/squid.conf

echo "auth_param basic program /usr/lib/squid3/basic_ncsa_auth /etc/squid3/passwd" >> /etc/squid3/squid.conf

echo "auth_param basic children 5" >> /etc/squid3/squid.conf

echo "acl usuarios_autenticados proxy_auth REQUIRED" >> /etc/squid3/squid.conf

echo "http_access allow x" >> /etc/squid3/squid.conf

echo "http_access allow usuarios_autenticados" >> /etc/squid3/squid.conf

echo "http_port 80" >> /etc/squid3/squid.conf

echo "http_port 8080" >> /etc/squid3/squid.conf

echo "visible_hostname jfsthebugs" >> /etc/squid3/squid.conf

echo "forwarded_for off" >> /etc/squid3/squid.conf

echo "via off" >> /etc/squid3/squid.conf

apt install apache2-utils

echo "Qual o nome do usuario para autenticar o squid ?"
read nome

cd /etc/squid3

htpasswd -c passwd $nome

cd
sleep 4
service squid3 restart 
sleep 4
service ssh restart
echo "$(tput bold) Servidor configurado com sucesso.Script By @jfsthebugs $(tput sgr0)"