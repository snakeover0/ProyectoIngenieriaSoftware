#***///--AQUI INICIAMOS CON LA CREACION DE LA BASE DE DATOS--\\\***

CREATE SCHEMA inventario; #CREAMOS EL ESCHEMA INVENTARIO
USE inventario; 	      #CAMBIAMOS LA BD O ESCHEMA DEFAULT A LA NUESTRA

CREATE TABLE estante(
	id_sector VARCHAR(2) UNIQUE, 
	descripcion TEXT
);

CREATE TABLE proveedores(
	no_proveedor SMALLINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(30),
    telefono VARCHAR(10)
);
#ALTERAMOS EL INICIO DEL PK
ALTER TABLE proveedores AUTO_INCREMENT=1000;


CREATE TABLE usuarios(
	usuario VARCHAR(30) NOT NULL,
    contrasenia VARCHAR(40) NOT NULL,
    auntenticacion BOOLEAN DEFAULT FALSE,
    tipo VARCHAR(8) CHECK (tipo='empleado' OR tipo='admin')
);

CREATE TABLE productos(
	no_producto INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(30) NOT NULL,
    descripcion TEXT,
    cantidad SMALLINT UNSIGNED DEFAULT 0 CHECK (cantidad >= 0),	
    tipo VARCHAR(30),	
    sector VARCHAR(2),
    proveedor SMALLINT,
    FOREIGN KEY (sector) REFERENCES estante(id_sector) ON UPDATE CASCADE,
    FOREIGN KEY (proveedor) REFERENCES proveedores(no_proveedor)
);
#ALTERAMOS EL INICIO DEL PK
ALTER TABLE productos AUTO_INCREMENT=4020;

CREATE TABLE producto_proveedor(
	producto INT UNSIGNED,
    proveedor SMALLINT,
    FOREIGN KEY (producto) 
		REFERENCES productos(no_producto) 
        ON DELETE CASCADE,
    FOREIGN KEY (proveedor) 
		REFERENCES proveedores(no_proveedor) 
        ON DELETE CASCADE
);


#AQUI COMIENZAN LOS INSERT DE PRUEBA

insert into estante values(
	'a',
    'Este estante contiene tornillos'
);

insert into usuarios (usuario, contrasenia, tipo) values(
	'snakeover',
     sha1('snake'), #PASSWORD WITH SHA1
    'admin'
);

insert into proveedores (nombre, telefono) values(
	'metalcrue','9512567678'
);

insert into productos (nombre, descripcion, tipo, sector, proveedor) values(
	'tornillo_x',
	'undefined',
	'tornillos',
	'a',
	'1000'
);

insert into producto_proveedor values(
	4020,
    1000
);

#AQUI COMIENZAN LOS SELECT DE PRUEBA
select * from productos;
select * from usuarios;
select * from proveedores;
select * from estante;
select * from producto_proveedor;

#***///--AQUI TERMINAN LOS PROCESOS CON LOS BASES DE DATOS--\\\***