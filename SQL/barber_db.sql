CREATE DATABASE IF NOT EXISTS barber_db;

USE barber_db;

CREATE TABLE IF NOT EXISTS usuarios(
	id INT AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    correo VARCHAR(30) NOT NULL,
    contraseña VARCHAR(30) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS barbero(
	id INT AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    correo varchar(45) NOT NULL,
    contraseña VARCHAR(30) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS cita(
	id INT AUTO_INCREMENT,
    usu_id INT,
    bar_id INT,
    servicio ENUM('CORTE DE PELO','AFEITADO DE BARBA','CORTE Y AFEITADO') NOT NULL,
    precio DECIMAL(5,2) NOT NULL,
    fecha_hora DATETIME NOT NULL,
    PRIMARY KEY (id),
    
    CONSTRAINT fk_cita_usuario
		FOREIGN KEY (usu_id)
        REFERENCES usuarios(id),
	
        CONSTRAINT cita_barbero
		FOREIGN KEY (bar_id)
        REFERENCES barbero(id)
);


CREATE TABLE IF NOT EXISTS pago(
	id INT NOT NULL,
    cit_id INT,
    tarjeta VARCHAR(20) NOT NULL,
    seguridad VARCHAR(3) NOT NULL,
    PRIMARY KEY(id),
    
    CONSTRAINT fk_pago_cita
		FOREIGN KEY(cit_id)
        REFERENCES cita(id)    
);



