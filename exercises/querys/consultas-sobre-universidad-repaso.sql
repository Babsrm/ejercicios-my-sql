-- Averigua el nombre y los dos apellidos de los alumnos que no han dado de alta su número de teléfono en la base de datos.
select nombre, apellido1, apellido2 from persona
where tipo='alumno' and telefono is null;

-- Devuelve un listado con todas las asignaturas ofertadas en el Grado en Ingeniería Informática (Plan 2015).
select g.nombre, a.nombre from grado g join asignatura a on g.id=a.id_grado
where g.nombre like '%informatica%';

-- Devuelve un listado con el nombre de todos los departamentos que tienen profesores que imparten alguna asignatura en el Grado en Ingeniería Informática (Plan 2015).
SELECT DISTINCT d.nombre
from grado g 
join asignatura a on g.id=a.id_grado
join profesor p on a.id_profesor=p.id_profesor
join departamento d on d.id=p.id_departamento
where g.nombre like '%informatica%';

-- Devuelve un listado con los profesores que no imparten ninguna asignatura.
select pe.nombre, pe.apellido1, a.nombre
from persona pe 
join profesor p on pe.id=p.id_profesor
left join asignatura a on a.id_profesor=p.id_profesor
where a.id is null;

-- Devuelve un listado con todos los departamentos que tienen alguna asignatura que no se haya impartido en ningún curso escolar. El resultado debe mostrar el nombre del departamento y el nombre de la asignatura que no se haya impartido nunca.
select d.nombre, a.nombre, ce.id
from departamento d
join profesor p on d.id=p.id_departamento
JOIN asignatura a on p.id_profesor=a.id_profesor
left join alumno_se_matricula_asignatura asma on asma.id_asignatura=a.id
left join curso_escolar ce on ce.id=asma.id_curso_escolar
where ce.id is null;

-- Calcula cuántos profesores hay en cada departamento. El resultado sólo debe mostrar dos columnas, una con el nombre del departamento y otra con el número de profesores que hay en ese departamento. El resultado sólo debe incluir los departamentos que tienen profesores asociados y deberá estar ordenado de mayor a menor por el número de profesores.
select d.nombre, count(id_profesor) `num profesores`
from departamento d join profesor p on d.id=p.id_departamento
group by d.nombre
order by `num profesores` desc;

-- Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas que tiene cada uno. Tenga en cuenta que pueden existir grados que no tienen asignaturas asociadas. Estos grados también tienen que aparecer en el listado. El resultado deberá estar ordenado de mayor a menor por el número de asignaturas.
select g.nombre, count(a.id) numAsignaturas
from grado g left join asignatura a on a.id_grado=g.id
GROUP BY g.nombre
order by numAsignaturas desc;

-- Devuelve un listado que muestre cuántos alumnos se han matriculado de alguna asignatura en cada uno de los cursos escolares. El resultado deberá mostrar dos columnas, una columna con el año de inicio del curso escolar y otra con el número de alumnos matriculados.
select  ce.ano_inicio, count(asma.id_alumno)
from persona pe 
join alumno_se_matricula_asignatura asma on pe.id=asma.id_alumno
join curso_escolar ce on ce.id=asma.id_curso_escolar
GROUP BY ce.ano_inicio;

