--1.1
select nombre, presupuesto*1000 "presupuesto en euros" from departamentos
where nombre in ('PERSONAL','FINANZAS','ORGANIZACION');

-- 1.2
select nombre, salario from empleados
where salario BETWEEN 1250 and 1300
order by nombre;
-- la condición between implica que los valores comprendidos estén intrínsecos en el resultado. es lo mismo que poner >= o <=. Como en el ejercicio no especifica que estén incluídos dichos valores o no lo estén, uso between. En el caso en el que no estuviesen incluídos, hubiese escrito where salario >1250 and salario<1300

-- 1.3. No especifico campos a mostrar porque no lo pide en el enunciado.
select * from empleados
where year(fecha_ingreso)>=2016 and salario >1150;

-- 1.4 No especifico campos a mostrar porque no lo pide en el enunciado.
select * from empleados
where comision is null;

--1.5
select d.nombre, d.presupuesto,e.nombre, e.salario, e.fecha_ingreso
from empleados e 
join departamentos d on e.cod_empleado=d.cod_director;

-- 1.6
select d.nombre, sum(e.salario) 'total salarios'
from departamentos d 
join empleados e on e.cod_departamento=d.cod_departamento
GROUP BY d.cod_departamento;

-- 2.1
insert into departamentos
values (131, 10, 250, 'P', 7, 121, 'RRHH');

--2.2
insert into centros (cod_centro, nombre, direccion)
values (30, 'SEDE MONTILLA', 'Pol. Ind. Llanos de Jarata, Montilla');

-- 3
select salario from empleados;

start TRANSACTION;
update empleados
set salario = salario*1.1;
commit;

-- 4
select * from centros;
-- el codigo de centro sede montilla es el 30
select * from departamentos where cod_departamento=131; --dpto de rrhh es el 131
start TRANSACTION;
update departamentos
set cod_centro=30
where cod_departamento=131;
commit;