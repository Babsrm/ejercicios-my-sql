drop database if exists clientes_jardineria;

create database if not exists clientes_jardineria
character set latin1
collate latin1_spanish_ci;

use clientes_jardineria;

create table if not exists oficina (
codigo_oficina varchar(10) primary key,
ciudad varchar(30) not null,
pais varchar(50) not null,
region varchar(50),
codigo_postal varchar(10),
telefono varchar(20),
linea_direccion1 varchar(50),
linea_direccion2 varchar(50));

create table if not exists empleado (
codigo_empleado int primary key,
nombre varchar(50) not null,
apellido1 varchar(50) not null,
apellido2 varchar(50),
extension varchar(10) not null,
email varchar(100) not null,
codigo_oficina varchar(10) not null,
codigo_jefe int,
puesto varchar(50));

create table if not exists cliente (
codigo_cliente int primary key,
nombre_cliente varchar(50) not null,
nombre_contacto varchar(30),
apellido_contacto varchar(30),
telefono varchar(15) not null,
fax varchar(15) not null,
linea_direccion1 varchar(50) not null, 
linea_direccion2 varchar(50),
ciudad varchar(50) not null,
region varchar(50),
pais varchar(50),
codigo_postal varchar(10),
codigo_empleado_rep_ventas int,
limite_credito decimal(15,2));

create table if not exists pago (
codigo_cliente int,
fomar_pago varchar(40) not null,
id_transaccion varchar(50),
fecha_pago date not null,
total decimal(15,2) not null,
primary key (codigo_cliente, id_transaccion));

create table if not exists gama_producto (
gama varchar(50) primary key,
descripcion_texto text,
descripcion_html text,
imagen varchar(256));

create table if not exists producto (
codigo_producto varchar(15) primary key,
nombre varchar(70) not null,
gama varchar (50) not null,
dimensiones varchar(25),
proveedor varchar(50),
descripcion text, 
cantidad_en_stock smallint not null,
precio_venta decimal(15,2) not null,
precio_proveedor decimal(15,2));

create table if not exists detalle_pedido (
codigo_pedido int,
codigo_producto varchar(15),
cantidad int not null,
precio_unidad decimal(15,2) not null,
numero_linea smallint not null,
primary key (codigo_pedido, codigo_producto));

create table if not exists pedido (
codigo_pedido int primary key,
fecha_pedido date not null,
fecha_esperada date not null,
fecha_entrega date,
estado varchar(15) not null,
comentarios text,
codigo_cliente int not null);

alter table empleado add
constraint fk_empleado_cod_ofi_oficina_cod_ofi
foreign key (codigo_oficina)
references oficina(codigo_oficina),
add
constraint fk_empleado_cod_jefe_a_cod_empleado
foreign key(codigo_jefe)
references empleado(codigo_empleado);

alter table cliente add
constraint fk_cliente_cod_empl_empleado_cod_empleado
foreign key(codigo_empleado_rep_ventas)
references empleado(codigo_empleado);

alter table pago add
constraint fk_pago_cod_cliente_cliente_cod_cliente
foreign key (codigo_cliente)
references cliente(codigo_cliente);

alter table producto add
constraint fk_producto_gama_gama_producto_gama
foreign key (gama)
references gama_producto (gama);

alter table detalle_pedido add
constraint fk_detalleped_codprod_producto_codprod
foreign key (codigo_producto)
references producto(codigo_producto),
add
constraint fk_detalleped_codped_pedido_codped
foreign key (codigo_pedido)
references pedido(codigo_pedido);

alter table pedido add
constraint fk_pedido_codcli_cliente_codcli
foreign key (codigo_cliente)
references cliente(codigo_cliente);