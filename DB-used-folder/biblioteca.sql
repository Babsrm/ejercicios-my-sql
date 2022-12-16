-- Active: 1667910552053@@127.0.0.1@3306@clientes_jardineria
DROP DATABASE IF EXISTS biblioteca;
CREATE DATABASE biblioteca   character set latin1 collate latin1_spanish_Ci;
use biblioteca;
--
-- Table structure for table autores
--
DROP TABLE IF EXISTS autores;

CREATE TABLE autores (
  idAutor smallint unsigned NOT NULL AUTO_INCREMENT,
  nombre varchar(15),
  apellidos varchar(30),
  PRIMARY KEY (idAutor)
) ;


INSERT INTO autores 
VALUES (1,'Carmen','Mola'),
       (2,'Arturo','Pérez-Reverte'),
       (3,'Pere','Chardi García'),
       (4,'Bjarne','Stroustrup'),
       (5,'Herbert','Schidlt'),
       (6,'Jim','Melton'),
       (7,'Andrew','Eisenberg'),
       (8,'Almudena','Grandes'),
       (9,'Dan','Brown'),
       (10,'Miguel','De Cervantes'),
       (11,'Dan','Brown'),
       (12,'Miguel','De Cervantes'),
       (13,'Dan','Brown'),
       (14,'Miguel','De Cervantes');

--
-- Table structure for table editoriales
--

DROP TABLE IF EXISTS editoriales;
CREATE TABLE editoriales (
  codEditorial smallint unsigned AUTO_INCREMENT,
  nombre varchar(20),
  anio smallint DEFAULT NULL,
  PRIMARY KEY (codEditorial)
);

INSERT INTO editoriales 
VALUES (1,'Alfawara',1985),
       (2,'Planeta',1998),
       (3,'Anaya',2001),
       (4,'Marcombo',2006);

       --
-- Table structure for table libros
--

DROP TABLE IF EXISTS libros;
CREATE TABLE libros (
  isbn char(13)NOT NULL,
  titulo varchar(50),
  codEditorial smallint unsigned ,
  anio smallint,
  num_pags smallint,
  precio float(5,2),
  cantidad int unsigned,
  precioCD float(5,2),
  PRIMARY KEY (isbn),
  KEY idx_libros_titulo (titulo),
  KEY idx_libros_anio (anio),
  KEY fk_libros_codeditorial (codEditorial),
  CONSTRAINT fk_libros_codeditorial FOREIGN KEY (codEditorial) REFERENCES editoriales (codEditorial)
) ;

--
INSERT INTO libros 
VALUES ('9788413185583','La bestia',2,2021,544,9.95,1,NULL),
       ('9788420460505','El italiano',1,2021,400,12.50,2,NULL),
       ('9788426721006','SQL Fácil',4,2014,384,95.00,4,NULL),
       ('9788426721236','C++',3,2010,457,75.90,5,1.75),
       ('9788441539402','JAVA 9',3,2017,448,87.90,3,1.75),
       ('9788445397502','SQL y JAVA. JDBC ySQLJ',3,2016,358,70.85,2,1.75);



--
-- Table structure for table autorlibro
--

DROP TABLE IF EXISTS autorlibro;

CREATE TABLE autorlibro (
  idAutor smallint unsigned,
  isbn char(13),
  CONSTRAINT pk_autorlibro__idAutor_isbn PRIMARY KEY (idAutor,isbn),
  CONSTRAINT fk_autorlibro_idAutor FOREIGN KEY (idAutor) REFERENCES autores (idAutor),
  CONSTRAINT fk_autorlibro_isbn FOREIGN KEY (isbn) REFERENCES libros (isbn)
) ;


INSERT INTO autorlibro
VALUES (1,'9788413185583'),
       (2,'9788420460505'),
       (3,'9788426721006'),
       (4,'9788426721236'),
       (5,'9788426721236'),
       (5,'9788441539402'),
       (6,'9788445397502'),
       (7,'9788445397502');