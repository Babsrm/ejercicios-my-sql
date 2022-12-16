drop database if exists entradas_espectaculos;

create database
    if not exists entradas_espectaculos character set latin1 collate latin1_spanish_ci;

use entradas_espectaculos;

create table
    if not exists espectaculos (
        cod_espectaculo smallint unsigned primary key,
        nombre varchar(30) not null,
        tipo varchar(10),
        fecha_inicial date,
        fecha_final date,
        interprete varchar(20),
        cod_recinto char(5)
    );

create table
    if not exists precios_espectaculos (
        cod_espectaculo smallint unsigned,
        cod_recinto char(5),
        zona char(3),
        precio float check(precio >= 0),
        primary key (
            cod_espectaculo,
            cod_recinto,
            zona
        )
    );

create table
    if not exists recintos (
        cod_recinto char(5) primary key,
        nombre varchar(20) not null,
        direccion varchar(50),
        ciudad varchar(20),
        telefono char(9),
        horario enum('Mañana', 'Tarde', 'Noche')
    );

create table
    if not exists zonas_recintos (
        cod_recinto char(5),
        zona char(3),
        capacidad smallint unsigned,
        primary key (cod_recinto, zona)
    );

create table
    if not exists asientos (
        cod_recinto char(5),
        zona char(3),
        fila char(2),
        numero char(2),
        adaptado enum('Si', 'No'),
        pasillo BOOLEAN,
        primary key (cod_recinto, zona, fila, numero)
    );

create table
    if not exists representaciones (
        cod_espectaculo smallint unsigned primary key,
        fecha date,
        hora time,
        premier enum('Si', 'No')
    );

create table
    if not exists entradas (
        cod_espectaculo smallint unsigned,
        cod_recinto char(5),
        zona char(3),
        fila char(2),
        numero char(2),
        fecha date,
        hora time,
        dni_cliente char(9),
        primary key (
            cod_espectaculo,
            cod_recinto,
            zona,
            fila,
            numero,
            fecha,
            hora,
            dni_cliente
        )
    );

create table
    if not exists espectadores (
        dni_cliente char(9) primary key,
        nombre varchar (20),
        direccion varchar(50),
        telefono char(9),
        ciudad varchar(20),
        n_tarjeta smallint unsigned
    );

alter table espectaculos
add
    constraint fk_espectaculos_cod_recinto_recintos_cod_recinto foreign key (cod_recinto) references recintos(cod_recinto);

alter table
    precios_espectaculos
add
    constraint fk_precios_espectaculos_cod_espec_espectaculos_cod_espec foreign key (cod_espectaculo) references espectaculos(cod_espectaculo),
add
    constraint fk_precios_espectaculos_cod_zona_zonas_recintos_cod_zona foreign key (cod_recinto, zona) references zonas_recintos(cod_recinto, zona);

alter table zonas_recintos
add
    constraint fk_zonas_recintos_cod_recinto_recintos_cod_recintos foreign key (cod_recinto) references recintos(cod_recinto);

alter table asientos
add
    constraint fk_asientos_cod_recinto_zona_zonas_recintos_cod_recinto_zona foreign key (cod_recinto, zona) references zonas_recintos(cod_recinto, zona);

alter table representaciones
add
    constraint fk_representaciones_cod_espectaculo_espectaculos_cod_espectaculo foreign key (cod_espectaculo) references espectaculos(cod_espectaculo);

alter table entradas
add
    constraint fk_entradas_cod_precios_espectaculos_cod_espec_cod_recinto_zona foreign key (
        cod_espectaculo,
        cod_recinto,
        zona
    ) references precios_espectaculos(
        cod_espectaculo,
        cod_recinto,
        zona
    ),
add
    constraint fk_entrada_cod_rec_zona_fila_n_asientos_cod_rec_zona_fila_n foreign key (cod_recinto, zona, fila, numero) references asientos(cod_recinto, zona, fila, numero),
add
    constraint fk_entradas_dni_cliente_espectadores_dni_cliente foreign key (dni_cliente) references espectadores(dni_cliente);