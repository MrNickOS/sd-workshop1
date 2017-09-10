# Taller 1 Sistemas Distribuidos
### Autor: Nicolás Machado Sáenz (A00052208)
### Tema: Aprovisionamiento de Infraestructura con Vagrant y Chef

En este primer taller, se realizará el aprovisionamiento de una pequeña infraestructura de red compuesta
de los siguientes elementos:
  * Un servidor de base de datos.
  * Dos servidores web conectados a la base de datos.
  * Un balanceador de cargas apuntando a los web servers.
  * Una máquina cliente (equipo físico del Laboratorio).

Para el desarrollo de la actividad debe contarse con los siguientes recursos:
 * Máquina física (Ubuntu 16.10 client)
 * Vagrant
 * Boxes de CentOS 7.
 
 El primer paso es crear una estructura jerárquica de directorios asociados a los servicios que residirán
 en las máquinas a aprovisionar. Debe ser parecida a esta:
 
 <<img estructura>>
 
Los directorios httpd_a y httpd_b hacen referencia a los dos servidores web (principal y secundario) que
permiten acceder al contenido de una base de datos. A continuación se listan los comandos para instalar y
configurar el servicio httpd; estos se automatizan desde un script denominado receta (escrito en Ruby);
al ejecutar ese script, la VM instala httpd usando estos comandos:

  yum install httpd
  yum install php
  yum install php-mysql
  yum -y install http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
  yum -y install mysql-community-server
  setsebool -P httpd_can_network_connect=1
  systemctl stop firewalld
  systemctl mask firewalld
  yum -y install iptables-services
  systemctl enable iptables
  service network restart
  iptables -I INPUT  -p tcp -m state --state NEW -m tcp --dport 80 -j ACCEPT
  service iptables save
  
