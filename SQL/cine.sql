CREATE DATABASE IF NOT EXISTS cine_db;

USE cine_db;

CREATE TABLE IF NOT EXISTS cliente(
	cli_id INT NOT NULL AUTO_INCREMENT,
    cli_nombre VARCHAR(50) NOT NULL,
    cli_correo VARCHAR(40) NOT NULL,
    cli_password VARCHAR(10) NOT NULL,
    PRIMARY KEY(cli_id)
);

CREATE TABLE IF NOT EXISTS pelicula(
	pel_id INT NOT NULL AUTO_INCREMENT,
    pel_nombre VARCHAR(30) NOT NULL,
    pel_duracion INT NOT NULL,
    PRIMARY KEY(pel_id)
);

CREATE TABLE IF NOT EXISTS sala(
	sal_id INT NOT NULL AUTO_INCREMENT,
    sal_nombre ENUM('SALA A', 'SALA B', 'SALA C', 'SALA D'),
    sal_asiento ENUM('A1','A2','A3','A4','A5','B1','B2','B3','B4','B5'),
    PRIMARY KEY(sal_id)
);

CREATE TABLE IF NOT EXISTS funcion(
	fun_id INT NOT NULL,
    fun_pel_id INT,
    fun_sal_id INT,
    fun_fecha_hora DATETIME NOT NULL,
    PRIMARY KEY(fun_id),
    
    CONSTRAINT fk_funcion_pelicula
		FOREIGN KEY (fun_pel_id)
        REFERENCES pelicula(pel_id),
        
	CONSTRAINT fk_funcion_sala
		FOREIGN KEY (fun_sal_id)
        REFERENCES sala(sal_id)
);

CREATE TABLE IF NOT EXISTS boleto(
	bol_id INT NOT NULL AUTO_INCREMENT,
    bol_cli_id INT,
    bol_fun_id INT,
    bol_precio DECIMAL(5,2),
    PRIMARY KEY (bol_id),
    
    CONSTRAINT fk_boleto_cliente
		FOREIGN KEY (bol_cli_id)
        REFERENCES cliente (cli_id),
        
	CONSTRAINT fk_boleto_funcion
		FOREIGN KEY (bol_fun_id)
        REFERENCES funcion (fun_id)
);

CREATE TABLE IF NOT EXISTS pago(
	pag_id INT NOT NULL,
    pag_bol_id INT,
    pag_nombre_completo VARCHAR(30),
    pag_tarjeta VARCHAR(16),
    pag_dig_seg VARCHAR(3),
    PRIMARY KEY (pag_id),
    
    CONSTRAINT fk_pago_boleto
		FOREIGN KEY (pag_bol_id)
        REFERENCES boleto(bol_id)
);