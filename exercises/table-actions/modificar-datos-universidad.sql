--Inserta a una persona con los siguientes datos:
/*nif: 99999999
nombre: Elon Reeve
apellido1: Musk
ciudad: New York
direccion: 5th avenue
telefono: 55555555
fecha nacimeinto 28 de junio 1971
sexo H
tipo Profesor */

insert into persona (id, nif, nombre, apellido1, ciudad, direccion, telefono, fecha_nacimiento, sexo, tipo)
values (null, '99999999', 'Elon Reeve', 'Musk', 'New York', '5th avenue', '55555555', '1971-06-28', 'H', 'Profesor');

insert into persona
set nif='99999999', nombre= 'Elon Reeve', apellido1='Musk', ciudad= 'New York', direccion='5th avenue', telefono='555555555', fecha_nacimiento='1971-06-28', sexo='h', tipo='profesor';

-- Añade a Elon Musk al departamento Informática
select * from departamento; -- buscamos el cod dpto y cod profesor
select * from persona where nombre='Elon Reeve'; -- idpersona 25 coddpto 1
insert into profesor
values(25, 1);

-- Inserta una asignatura nueva con los datos:
/*Nombre: 'Como arruinar twitter en 2 semanas'
Créditos: 6
tipo: Optativa
curso: 1
cuatrimestre: 1
imparte: Elon*/
select * from grado; -- grado 4
insert into asignatura (id, nombre, creditos, tipo, curso, cuatrimestre, id_profesor, id_grado)
values (null, 'Cómo arruinar twitter en 2 semanas', 6, 'optativa', 1, 1, 25, 4);

-- Muestra un listado de los profesores y las asignaturas que imparten
select pe.nombre, pe.apellido1, a.nombre from persona pe 
join profesor p on pe.id=p.id_profesor
join asignatura a on p.id_profesor=a.id_profesor;

-- Matricula a los alumnos 7, 19 y 22 en la asignatura anterior
select * from curso_escolar; -- vamos a insertar un curso académico más actualizado
insert into curso_escolar (ano_inicio, ano_fin)
values (2022,2023);
insert into alumno_se_matricula_asignatura
values (7, 84, 6); -- id alumno, id asignatura y id curso academico
insert into alumno_se_matricula_asignatura
values (19, 84, 6), 
        (22,84, 6);

-- Actualiza los creditos de todas las asignatura obligatorias incrementandole 2 créditos a cada una
select * from asignatura where tipo = 'obligatoria';
start TRANSACTION;
update asignatura
set creditos=creditos+2
where tipo= 'obligatoria';
commit;

-- Borra a Elon musk y todos sus registros relacionados
delete from alumno_se_matricula_asignatura where id_asignatura=84;
delete from asignatura where id_profesor=25;
delete from profesor
where id_profesor=25;
delete from persona where id=25;
select* from persona;