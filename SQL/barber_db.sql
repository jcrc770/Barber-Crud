CREATE DATABASE barber_db;

USE barber_db;

CREATE TABLE IF NOT EXISTS barbero(
	bar_id INT NOT NULL AUTO_INCREMENT,
    bar_nombre VARCHAR(20) NOT NULL,
    bar_apellidos VARCHAR(30) NOT NULL,
    PRIMARY KEY(bar_id)
);

CREATE TABLE IF NOT EXISTS cuenta_barbero(
	cba_id INT NOT NULL,
    cba_bar_id INT,
    cba_correo VARCHAR(40) NOT NULL,
    cba_pass VARCHAR(30) NOT NULL,
    cba_tipo ENUM('ADMINISTRADOR', 'LOCAL'),
    PRIMARY KEY(cba_id),
    
    CONSTRAINT fk_barbero_cuenta_barbero
		FOREIGN KEY (cba_bar_id)
        REFERENCES barbero(bar_id)
);

CREATE TABLE IF NOT EXISTS cliente(
	cli_id INT NOT NULL AUTO_INCREMENT,
    cli_nombre VARCHAR(20) NOT NULL,
    cli_apellidos VARCHAR(30) NOT NULL,
    cli_edad INT NOT NULL,
    PRIMARY KEY(cli_id)
);

CREATE TABLE IF NOT EXISTS cuenta_cliente(
	ccl_id INT NOT NULL AUTO_INCREMENT,
    ccl_cli_id INT,
    ccl_correo VARCHAR(40),
    ccl_pass VARCHAR(30),
    PRIMARY KEY(ccl_id),
    
    CONSTRAINT fk_cliente_cuenta_cliente
		FOREIGN KEY (ccl_cli_id)
        REFERENCES cliente (cli_id)
);


CREATE TABLE IF NOT EXISTS servicio(
	ser_id INT NOT NULL AUTO_INCREMENT,
    ser_nombre VARCHAR(40) NOT NULL,
    ser_precio INT NOT NULL,
    PRIMARY KEY (ser_id)
);

CREATE TABLE IF NOT EXISTS producto(
	pro_id INT NOT NULL AUTO_INCREMENT,
    pro_nombre VARCHAR(30) NOT NULL,
    pro_precio INT NOT NULL,
    pro_detalles TEXT NOT NULL,
    pro_imagen BLOB NOT NULL,
    PRIMARY KEY(pro_id)
);

CREATE TABLE IF NOT EXISTS cita(
	cit_id INT NOT NULL AUTO_INCREMENT,
    cit_cba_id INT,
    cit_ccl_id INT,
    cit_ser_id INT,
    cit_fecha DATE NOT NULL,
    cit_hora TIME NOT NULL,
    cit_precio_total DECIMAL(5,2) NOT NULL,
    PRIMARY KEY(cit_id),
    
    CONSTRAINT fk_cita_cuenta_barbero
		FOREIGN KEY(cit_cba_id)
        REFERENCES cuenta_barbero(cba_id),
        
	CONSTRAINT fk_cita_cuenta_cliente
		FOREIGN KEY (cit_ccl_id)
        REFERENCES cuenta_cliente(ccl_id),
        
	CONSTRAINT fk_cita_servicio
		FOREIGN KEY (cit_ser_id)
        REFERENCES servicio(ser_id)
);

CREATE TABLE IF NOT EXISTS pago(
	pag_id INT NOT NULL AUTO_INCREMENT,
    pag_cit_id INT,
    pag_tarjeta VARCHAR(16) NOT NULL,
    pag_num_seguridad VARCHAR(3) NOT NULL,
    pag_fecha_vencimiento DATE NOT NULL,
    
    PRIMARY KEY(pag_id),
    
    CONSTRAINT fk_pago_cita
		FOREIGN KEY (pag_cit_id)
        REFERENCES cita (cit_id)
);

CREATE TABLE IF NOT EXISTS pedido(
	ped_id INT NOT NULL,
    ped_pro_id INT,
    ped_ccl_id INT,
    ped_cantidad INT NOT NULL,
    ped_total DECIMAL(5,2) NOT NULL,
    PRIMARY KEY(ped_id),
    
    CONSTRAINT fk_pedido_producto
		FOREIGN KEY (ped_pro_id)
        REFERENCES producto(pro_id),
        
	CONSTRAINT fk_pedido_cuenta_cliente
		FOREIGN KEY (ped_ccl_id)
        REFERENCES cuenta_cliente(ccl_id)
);

CREATE TABLE IF NOT EXISTS producto_pago(
	ppa_id INT NOT NULL AUTO_INCREMENT,
    ppa_ped_id INT,
    ppa_tarjeta VARCHAR(16) NOT NULL,
    ppa_num_seguridad VARCHAR(3) NOT NULL,
    ppa_fecha_vencimiento DATE NOT NULL,
    
    PRIMARY KEY(ppa_id),
    
    CONSTRAINT fk_producto_pago_pedido
		FOREIGN KEY (ppa_ped_id)
        REFERENCES pedido (ped_id)
);