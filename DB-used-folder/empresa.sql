-- Active: 1667910552053@@127.0.0.1@3306@empresa
drop database if exists empresa;
create database empresa  character set latin1 collate latin1_spanish_Ci;
USE empresa;
create table centros (
  cod_centro SMALLINT UNSIGNED primary key,
  nombre varchar(30),
  direccion varchar(50)
);
create table empleados (
  cod_empleado SMALLINT UNSIGNED primary key,
  cod_departamento SMALLINT UNSIGNED,
  telefono int(3),
  fecha_nacimiento DATE,
  fecha_ingreso DATE,
  salario SMALLINT,
  comision SMALLINT,
  num_hijos int(2),
  nombre VARCHAR(50)
);
create table departamentos (
  cod_departamento SMALLINT UNSIGNED PRIMARY KEY,
  cod_centro smallint UNSIGNED,
  cod_director SMALLINT UNSIGNED,
  tipo_dir ENUM('P', 'F'),
  presupuesto SMALLINT(5),
  cod_dpto_jefe SMALLINT UNSIGNED,
  nombre varchar(50), 
  constraint fk_departamentos_cod_centro foreign key(cod_centro) references centros(cod_centro),
  constraint fk_departamentos_cod_director foreign key(cod_director) references empleados(cod_empleado),
  constraint fk_departamentos_cod_dpto_jefe foreign key(cod_dpto_jefe) references departamentos(cod_departamento)
);


INSERT INTO centros(cod_centro,nombre,direccion) 
VALUES(10,'SEDE CENTRAL','C. ALCALA 820, MADRID'),
(20,'RELACION CON CLIENTES','C. ATOCHA 405, MADRID');


INSERT INTO empleados(cod_empleado,cod_departamento,telefono,fecha_nacimiento,fecha_ingreso,salario,comision,num_hijos,nombre) 
VALUES(110,121,350,'1959-11-10','1980-02-10',1310,NULL,3,'PONS, CESAR'),
      (120,112,840,'1965-06-09','1998-10-01',1350,110,1,'LASA, MARIO'),
      (130,112,810,'1975-11-09','1999-02-01',1290,110,2,'TEROL, LUCIANO'),
      (150,121,340,'1960-08-10','1978-01-15',1440,NULL,0,'PEREZ, JULIO'),
      (160,111,740,'1969-07-09','1998-11-11',1310,110,2,'AGUIRRE, AUREO'),
      (180,110,508,'1964-10-18','1986-03-18',1480,50,2,'PEREZ, MARCOS'),
      (190,121,350,'1962-05-12','1992-02-11',1300,NULL,4,'VEIGA, JULIANA'),
      (210,100,200,'1970-09-28','1989-01-22',1380,NULL,2,'GALVEZ, PILAR'),
      (240,111,760,'1972-02-26','1996-02-24',1280,100,3,'SANZ, LAVINIA'),
      (250,100,250,'1976-10-27','1997-03-01',1450,NULL,0,'ALBA, ADRIANA'),
      (260,100,220,'1973-12-03','1998-07-12',1720,NULL,6,'LOPEZ, ANTONIO'),
      (270,112,800,'1975-05-21','1996-09-10',1380,80,3,'GARCIA, OCTAVIO'),
      (280,130,410,'1978-01-11','2001-10-08',1290,NULL,5,'FLOR, DOROTEA'),
      (285,122,620,'1979-10-25','1998-02-15',1380,NULL,0,'POLO, OTILIA'),
      (290,120,910,'1977-11-30','1998-02-14',1270,NULL,3,'GIL, GLORIA'),
      (310,130,480,'1976-11-21','2001-01-15',1420,NULL,0,'GARCIA, AUGUSTO'),
      (320,122,620,'1987-12-25','2008-02-05',1405,NULL,2,'SANZ, CORNELIO'),
      (330,112,850,'1978-08-19','2002-03-01',1280,90,0,'DIEZ, AMELIA'),
      (350,122,610,'1979-04-13','2014-09-10',1450,NULL,1,'CAMPS, AURELIO'),
      (360,111,750,'1988-10-29','1998-10-10',1250,100,2,'LARA, DORINDA'),
      (370,121,360,'1997-06-22','2017-01-20',1190,NULL,1,'RUIZ, FABIOLA'),
      (380,112,880,'1998-03-30','2018-01-01',1180,NULL,0,'MARTIN, MICAELA'),
      (390,110,500,'1996-02-19','2016-10-08',1215,NULL,1,'MORAN, CARMEN'),
      (400,111,780,'1999-08-18','2017-11-01',1185,NULL,0,'LARA, LUCRECIA'),
      (410,122,660,'1998-07-14','2018-10-13',1175,NULL,0,'MU‹OZ, AZUCENA'),
      (420,130,450,'1996-10-22','2018-11-19',1400,NULL,0,'FIERRO, CLAUDIA'),
      (430,122,650,'1997-10-26','2018-11-19',1210,NULL,1,'MORA, VALERIANA'),
      (440,111,760,'1996-09-27','2016-02-28',1210,100,0,'DURAN, LIVIA'),
      (450,112,880,'1996-10-21','2016-02-28',1210,100,0,'PEREZ, SABINA'),
      (480,111,760,'1995-04-04','2016-02-28',1210,100,1,'PINO, DIANA'),
      (490,112,880,'1994-06-06','2018-01-01',1180,100,0,'TORRES, HORACIO'),
      (500,111,750,'1995-10-08','2017-01-01',1200,100,0,'VAZQUEZ, HONORIA'),
      (510,110,550,'1996-05-04','2016-11-01',1200,NULL,1,'CAMPOS, ROMULO'),
      (550,111,780,'2000-01-10','2018-01-21',1100,120,0,'SANTOS, SANCHO');

INSERT INTO departamentos(cod_departamento,cod_centro,cod_director,tipo_dir,presupuesto,cod_dpto_jefe,nombre) 
VALUES(100,10,260,'P',12,NULL,'DIRECCION GENERAL'),
      (110,20,180,'P',15,100,'DIRECC. COMERCIAL'),
      (111,20,180,'F',11,110,'SECTOR INDUSTRIAL'),
      (112,20,270,'P',9,100,'SECTOR SERVICIOS'),
      (120,10,150,'F',3,100,'ORGANIZACION'),
      (121,10,150,'P',2,120,'PERSONAL'),
      (122,10,350,'P',6,120,'PROCESO DE DATOS'),
      (130,10,310,'P',2,100,'FINANZAS');
alter table empleados add constraint fk_empleados_cod_departamento foreign key(cod_departamento) references departamentos(cod_departamento);