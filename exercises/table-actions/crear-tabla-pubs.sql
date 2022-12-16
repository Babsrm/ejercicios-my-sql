drop database if exists pubs;

create database if not exists pubs 
character set latin1
collate latin1_spanish_ci;

use pubs;

create table if not exists pubs (
cod_pub char(5) primary key,
nombre varchar (30) not null,
licencia_fiscal char(9) not null,
domicilio varchar (50),
fecha_apertura date not null,
horario enum('HOR1', 'HOR2', 'HOR3') not null default 'HOR1',
cod_localidad smallint unsigned not null);

create table if not exists titulares ( 
dni_titular char(9) primary key,
nombre varchar (30) not null,
domicilio varchar (50),
cod_pub char(5) not null);

create table if not exists empleados (
dni_empleado char (9) primary key,
nombre varchar(30) not null,
domicilio varchar(50));

create table if not exists existencias (
cod_articulo char(5) primary key,
nombre varchar(30) not null,
cantidad smallint unsigned not null,
precio float not null,
cod_pub char(5) not null,
constraint ck_precio_mayor_que_cero check(precio>0));

create table if not exists localidades (
cod_localidad smallint unsigned primary key, 
nombre varchar(30) not null);

create table if not exists pub_empleado (
cod_pub char(5),
dni_empleado char(9),
funcion enum('camarero','seguridad','limpieza'),
primary key(cod_pub, dni_empleado, funcion));

-- ahora vamos a poner las claves foráneas y realcionamos las tablas entre sí
alter table pubs add 
-- le damos nombre a la clave foránea, el primer termino es el campo nombre de tabla y foráneo, la tabla y columna a la que referencio
constraint fk_pubs_cod_localidad_localidades_cod_localidad
foreign key (cod_localidad)
references localidades(cod_localidad);

alter table titulares add
constraint fk_titulares_cod_pub_pub_cod_pub
foreign key (cod_pub)
references pubs(cod_pub);

alter table existencias add
constraint fk_existencias_cod_pub_pub_cod_pub
foreign key (cod_pub)
references pubs(cod_pub);

alter table pub_empleado add
constraint fk_pub_empleado_cod_pub_pub_cod_pub
foreign key (cod_pub) 
references pubs(cod_pub), 
add
constraint fk_pub_empleado_dni_empleado_empleados_dni_empleado
foreign key (dni_empleado)
references empleados(dni_empleado);