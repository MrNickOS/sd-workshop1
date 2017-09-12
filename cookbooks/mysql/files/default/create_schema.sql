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
