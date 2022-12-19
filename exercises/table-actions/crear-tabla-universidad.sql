create database if not EXISTS universidad
CHARACTER set utf8mb4;

use universidad;

create table if not exists persona (
    id int unsigned AUTO_INCREMENT PRIMARY key ,
    nif varchar(9),
    nombre varchar(25) not null,
    apellido1 varchar(50) not null,
    apellido2 varchar(50),
    ciudad varchar(25) not null,
    direccion varchar(50) not null,
    telefono varchar(9),
    fecha_nacimiento date not null,
    sexo enum ('H','M') not null,
    tipo enum ('profesor','alumno')
);

create table if not exists departamento (
id int unsigned AUTO_INCREMENT PRIMARY key,
nombre VARCHAR(50) not null
);

create table if not exists profesor(
id_profesor int unsigned primary key,
id_departamento int unsigned not null,
CONSTRAINT fk_prof_iddept_dept_id
FOREIGN key (id_departamento)
REFERENCES departamento(id),
CONSTRAINT fk_persona_id_profesor_id
foreign key (id_profesor)
references persona(id)
);



create table if not exists grado (
    id int unsigned AUTO_INCREMENT PRIMARY key,
    nombre varchar(100) not null
);

create table if not exists asignatura (
    id int unsigned AUTO_INCREMENT primary key ,
    nombre varchar(100) not null,
    creditos float not null,
    tipo enum ('Básica', 'Obligatoria', 'Optativa') not null,
    curso TINYINT unsigned not null ,
    cuatrimestre TINYINT unsigned not null,
    id_profesor int unsigned,
    id_grado int unsigned not null,
    CONSTRAINT fk_asign_idprof_prof_idprof
    FOREIGN KEY (id_profesor)
    references profesor(id_profesor),
    CONSTRAINT fk_asign_idgrado_grado_id
    FOREIGN KEY (id_grado)
    references grado(id)
);

create table if not exists curso_escolar (
    id int unsigned AUTO_INCREMENT PRIMARY key,
    ano_inicio year not null,
    ano_fin year not null
);

create table if not exists alumno_se_matricula_asignatura (
    id_alumno int unsigned,
    id_asignatura int UNSIGNED,
    id_curso_escolar int unsigned,
    primary key (id_alumno, id_asignatura, id_curso_escolar),
    CONSTRAINT fk_alummatr_idalum_persona_id
    FOREIGN KEY (id_alumno)
    REFERENCES persona(id),
    constraint fk_alummatr_idasig_asig_id
    FOREIGN KEY (id_asignatura)
    references asignatura(id),
    CONSTRAINT fk_alummatr_idcurso_curso_escolar_id
    FOREIGN KEY (id_curso_escolar)
    REFERENCES curso_escolar(id)
);

