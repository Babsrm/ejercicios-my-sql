drop database if exists parque_atracciones;
create database parque_atracciones character set latin1 collate latin1_spanish_Ci;
USE parque_atracciones;

create table if not exists clientes(
    cliente_id int unsigned AUTO_INCREMENT PRIMARY key,
    nombre varchar(20),
    apellido1 varchar(30),
    apellido2 varchar(30),
    dni varchar(9),
    fecha_nacimiento date,
    cod_postal char(5),
    tutor_id int unsigned,
    constraint fk_clientes_tutorid_clientes_clienteid
    foreign key (tutor_id) 
    references clientes (cliente_id)
);

create table if not exists tipos_entradas(
    cod_entrada SMALLINT unsigned AUTO_INCREMENT primary key,
    nombre varchar(30),
    tipo enum ('Adulto', 'Adulto Preferente', 'Niño', 'Niño Preferente'),
    horario enum ('Mañana', 'Tarde', 'Completo'),
    precio float
);

create table if not exists entradas (
    entrada_id int unsigned AUTO_INCREMENT PRIMARY KEY,
    cod_entrada SMALLINT unsigned,
    cliente_id int unsigned,
    fecha date not null,
    descuento float,
    altura_min TINYINT(1) unsigned,
    CONSTRAINT fk_entradas_codentrada_tiposentradas_codentrada
    FOREIGN KEY (cod_entrada)
    references tipos_entradas (cod_entrada),
    constraint fk_entradas_clienteid_clientes_clienteid
    FOREIGN KEY (cliente_id)
    references clientes (cliente_id)
);

create table if not exists pases_atracciones(
    cod_atraccion smallint unsigned,
    entrada_id int unsigned,
    hora_acceso timestamp,
    hora_inicio timestamp,
    primary key (cod_atraccion, entrada_id, hora_acceso),
    CONSTRAINT fk_pa_entradaid_entradas_entradaid
    foreign key (entrada_id)
    references entradas (entrada_id)
);

create table if not exists atracciones (
    cod_atraccion smallint unsigned AUTO_INCREMENT primary key,
    nombre varchar(30) not null,
    descripcion varchar(100),
    aforo TINYINT unsigned,
    tiempo_medio_espera float,
    altura_min TINYINT(1) unsigned
);

alter table tipos_entradas ADD
constraint ck_tipos_entradas_precio_mayor_que_30
check(precio>30);

alter table pases_atracciones add
constraint fk_pasesatrac_codatrac_atracciones_codatrac
foreign key (cod_atraccion)
references atracciones(cod_atraccion);