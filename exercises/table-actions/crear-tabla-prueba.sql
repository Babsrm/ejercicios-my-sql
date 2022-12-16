create database prueba;

show character set;
show collation;

create database if not exists biblioteca
character set latin1
collate latin1_spanish_ci;

use biblioteca;

create table if not exists editoriales (
	cod_editorial smallint unsigned auto_increment,
    nombre varchar (12),
    ano int(4) unsigned,
    primary key (cod_editorial));
    
	

create table if not exists libros (
	isbn char(13), 
    titulo varchar(50),
    cod_editorial smallint unsigned,
    ano int(4) unsigned,
    num_pags smallint unsigned,
    primary key (isbn),
    constraint fk_cod_editorial_editoriales_cod_editorial
    -- la linea 27 le da un nombre a la clave foránea. columna, tabla, columna a la que va referenciada. fk hace eco a foreign key. pk sería primary key
    foreign key(cod_editorial)
    references editoriales(cod_editorial))