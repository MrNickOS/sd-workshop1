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

  ```bash
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
  ```
Al ejecutar este script (en los servidores web A y B) se procede a instalar el servidor de base de datos
en su máquina correspondiente. Se ejecutan las recipes de los cookbooks correspondientes a MySQL; dentro
de la VM, se siguen estas instrucciones:

  ```bash
  yum -y install http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
  yum -y install mysql-community-server
  systemctl stop firewalld
  systemctl mask firewalld
  yum -y install iptables-services
  systemctl enable iptables
  service network restart
  iptables -I INPUT 5 -p tcp -m state --state NEW -m tcp --dport 3306 -j ACCEPT
  service iptables save
  ```
Una vez instalado y en funcionamiento el servicio de BD, se crea un esquema que genera una BD de muestra y
unos usuarios que pueden acceder a ella con credenciales y desde equipos autorizados.

  ```sql
  CREATE database base_datos_1;
  USE base_datos_1;
  CREATE TABLE cursos (
    id INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY(id),
    nombre VARCHAR(50),
    horas_semana INT,
    salon VARCHAR(10)
  );
  INSERT INTO cursos (nombre,horas_semana,salon) VALUES ('Internet of Things',3,'501L');
  INSERT INTO cursos (nombre,horas_semana,salon) VALUES ('Distribuidos',3,'307C');
  INSERT INTO cursos (nombre,horas_semana,salon) VALUES ('Redes Convergentes',3,'306C');
  INSERT INTO cursos (nombre,horas_semana,salon) VALUES ('PDG II',2,'307L');
  INSERT INTO cursos (nombre,horas_semana,salon) VALUES ('Electiva en Ética',2,'102D');
  
  GRANT ALL PRIVILEGES ON *.* to 'usuario1'@'192.168.60.100' IDENTIFIED BY 'database2017' WITH GRANT OPTION;
  GRANT ALL PRIVILEGES ON *.* to 'usuario2'@'192.168.60.110' IDENTIFIED BY 'database2017' WITH GRANT OPTION;
  ```
Los siguientes comandos son entonces para verificar que se puede acceder a la BD como root.
  
  ```bash
  cat create_schema.sql | mysql -u root -pdistribuidos
  ```
  
La siguiente máquina a instalar y aprovisionar es el balanceador de carga. Se usó NGINX como balanceador.

  ```bash
  yum -y install nginx
  systemctl stop firewalld
  systemctl mask firewalld
  yum -y install iptables-services
  systemctl enable iptables
  service network restart
  iptables -I INPUT  -p tcp -m state --state NEW -m tcp --dport 8080 -j ACCEPT
  service iptables save
  service httpd stop
  nginx
  ```
