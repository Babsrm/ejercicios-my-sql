drop database if exists empresa;

create database if not exists empresa
character set latin1
collate latin1_spanish_ci;

use empresa;

create table if not exists empleados (
dni char(9) primary key,
nombre varchar(10) not null,
apellido1 varchar(15) not null,
apellido2 varchar(15),
direcc1 varchar(25),
direcc2 varchar(20),
ciudad varchar(20),
provincia varchar(20),
cod_postal char(5),
sexo enum('H','M'), -- o char(1) check(sexo='V' OR sexo='M')
fecha_nac date);

create table if not exists historial_laboral (
empleado_dni char(9),
trabajo_cod char(5),
fecha_inicio date,
fecha_fin date,
dpto_cod char(5),
supervisor_dni char(9),
primary key(empleado_dni, trabajo_cod, fecha_inicio));

create table if not exists historial_salarial (
empleado_dni char(9),
salario float not null check(salario>=0),
fecha_comienzo date,
fecha_fin date,
primary key (empleado_dni, fecha_comienzo));

create table if not exists departamentos (
dpto_cod char(5) primary key,
nombre_dpto varchar(30) unique,
dpto_padre char(5),
presupuesto float not null,
pres_actual float);

create table if not exists estudios (
empleado_dni char(9),
universidad char(5),
ano year,
grado varchar(3),
especialidad varchar(20),
primary key (empleado_dni, grado));

create table if not exists universidades (
univ_cod char(5) primary key,
nombre_univ varchar(25) not null,
ciudad varchar(20),
municipio varchar(20),
cod_postal char(5));

create table if not exists trabajos (
trabajo_cod char(5) primary key,
nombre_trab varchar(20) unique,
salario_min float not null check(salario_min>0),
salario_max float not null check(salario_max>0),
constraint ck_trabajos_salario_max_mayor_salario_min
check(salario_max>salario_min));

alter table historial_laboral add
constraint fk_historial_laboral_empleado_dni_empleados_dni
foreign key (empleado_dni)
references empleados(dni),
add
constraint fk_historial_laboral_supervisor_dni_empleados_dni
foreign key (supervisor_dni)
references empleados(dni),
add
constraint fk_historial_laboral_trabajo_cod_trabajos_trabajo_cod
foreign key (trabajo_cod)
references trabajos(trabajo_cod),
add
constraint fk_historial_laboral_dpto_cod_departamentos_dpto_cod
foreign key (dpto_cod)
references departamentos(dpto_cod);

alter table historial_salarial add
constraint fk_historial_salarial_empleado_dni_empleados_dni
foreign key (empleado_dni)
references empleados(dni);

alter table departamentos add
constraint fk_departamentos_dpto_padre_departamentos_dpto_cod
foreign key (dpto_padre)
references departamentos(dpto_cod);

alter table estudios add
constraint fk_estudios_empleado_dni_empleados_dni
foreign key (empleado_dni)
references empleados(dni),
add
constraint fk_estudios_universidad_universidades_univ_cod
foreign key (universidad)
references universidades(univ_cod);
