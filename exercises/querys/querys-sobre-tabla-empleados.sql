-- 1. Obtener los datos completos de los empleados.
select * FROM empleados;

-- 2. Obtener los datos completos de los departamentos.
select * from departamentos;

-- 3. Obtener los datos de los empleados con cargo ‘Secretaria’.
select * from empleados where cargoE="Secretaria";

-- 4. Obtener el nombre y salario de los empleados.
select `nomEmp`, `salEmp` from empleados;

-- 5. Obtener los datos de los empleados vendedores, ordenado por nombre.
select * from empleados where `cargoE`="Vendedor"
order by `nomEmp`asc;

-- 6. Listar el nombre de los departamentos.
select `nombreDpto` from departamentos;

-- 7. Obtener el nombre y cargo de todos los empleados, ordenado por salario.
select `nomEmp`, `cargoE` from empleados
ORDER By `salEmp`asc;

-- 8. Listar los salarios y comisiones de los empleados del departamento 2000, ordenado por comisión.
select `nomEmp`, `salEmp`, `comisionE` from empleados
where `codDepto`= 2000;

-- 9. Listar todas las comisiones.
SELECT `nomEmp`, `comisionE` from empleados;

-- 10. Obtener el valor total a pagar que resulta de sumar a los empleados del departamento 3000 una bonificación de 500.000, en orden alfabético del empleado
SELECT `nomEmp`, `salEmp`+500000 "total a pagar" from empleados
where `codDepto`=3000;

-- 11. Obtener la lista de los empleados que ganan una comisión superior a su sueldo.
select `nomEmp` from empleados
where `salEmp`<`comisionE`;

-- 12. Listar los empleados cuya comisión es menor o igual que el 30% de su sueldo.
select `nomEmp` from empleados
where `comisionE`<=(`salEmp`*0.3);

-- 13.Elabore un listado donde para cada fila, figure ‘Nombre’ y ‘Cargo’ antes del valor respectivo para cada empleado.
select `nomEmp`, `cargoE` from empleados;

-- 14. Hallar el salario y la comisión de aquellos empleados cuyo número de documento de identidad es superior al ‘19.709.802’.
select * from empleados
where cast (replace(`nDiemp`,'.','') as unsigned)>19709802;

--15. Muestra los empleados cuyo nombre empiece entre las letras J y Z (rango). Liste estos empleados y su cargo por orden alfabético.
select `nomEmp`, `cargoE` from empleados
where `nomEmp` BETWEEN "J%" and "z%"
order by `nomEmp` asc;

-- 16. Listar el salario, la comisión, el salario total (salario + comisión), documento de identidad del empleado y nombre, de aquellos empleados que tienen comisión superior a 1.000.000, ordenar el informe por el número del documento de identidad
select `salEmp`, `comisionE`, `salEmp`+`comisionE` "sal total", `nDIEmp`, `nomEmp` from empleados
where `comisionE`>1000000
ORDER by cast (replace(`nDiemp`,'.','') as unsigned);

-- 17. Obtener un listado similar al anterior, pero de aquellos empleados que NO tienen comisión
select `salEmp`, `comisionE`, `salEmp`+`comisionE` "sal total", `nDIEmp`, `nomEmp` from empleados
where `comisionE`=0
ORDER by cast (replace(`nDiemp`,'.','') as unsigned);

-- 18. Hallar los empleados cuyo nombre no contiene la cadena «MA»
select `nomEmp` from empleados
where Upper(`nomEmp`) not like "%MA%";

--19. Obtener los nombres de los departamentos que no sean “Ventas” ni “Investigación” NI ‘MANTENIMIENTO’.
select `nombreDpto` from departamentos
where lower(`nombreDpto`) not in ("ventas", "investigación","mantenimiento");

-- 20. Obtener el nombre y el departamento de los empleados con cargo ‘Secretaria’ o ‘Vendedor’, que no trabajan en el departamento de “PRODUCCION”, cuyo salario es superior a $1.000.000, ordenados por fecha de incorporación.
select `nomEmp`, `nombreDpto`, `cargoE`, `salEmp` from empleados e join departamentos d on e.`codDepto`=d.`codDepto`
where (`cargoE`='Secretaria' or `cargoE`='Vendedor') and lower(`nombreDpto`) not in ('producción') and `salEmp`>1000000;

-- 21. Obtener información de los empleados cuyo nombre tiene exactamente 11 caracteres
select * from empleados
-- where `nomEmp` like '___________';
where CHAR_LENGTH(nomEmp)=11;

-- 22. Obtener información de los empleados cuyo nombre tiene al menos 11 caracteres
select * from empleados
where CHAR_LENGTH(nomEmp)>=11;

-- 23. Listar los datos de los empleados cuyo nombre inicia por la letra ‘M’, su salario es mayor a $800.000 o reciben comisión y trabajan para el departamento de ‘VENTAS’
select e.* 
from empleados e join departamentos d on e.`codDepto`=d.`codDepto`
where `nomEmp` like 'M%' 
and (`salEmp`>800000 or `comisionE`is not null) 
and d.`nombreDpto`='VENTAS';

-- 24. Obtener los nombres, salarios y comisiones de los empleados que reciben un salario situado entre la mitad de la comisión y la propia comisión.
select `nomEmp`, `salEmp`, `comisionE`
from empleados
-- where `salEmp`<= `comisionE` and `comisionE`*0.5<= `salEmp`;
where salEmp BETWEEN comisionE*.5 and comisionE;

-- 25. Mostrar el salario más alto de la empresa.
select max(`salEmp`) from empleados;

-- 26. Mostrar cada una de las comisiones y el número de empleados que las reciben. Solo si tiene comisión.
select `comisionE`, count(`comisionE`) from empleados
GROUP BY `comisionE`
having `comisionE`>0
ORDER BY `comisionE` desc;

-- 27. Mostrar el nombre del último empleado de la lista por orden alfabético.
select `nomEmp` from empleados
order by `nomEmp` DESC
limit 1;

-- 28. Hallar el salario más alto, el más bajo y la diferencia entre ellos.
select max(`salEmp`) 'salario alto', min (`salEmp`) 'salario bajo', MAX(`salEmp`)-min(`salEmp`)'diferencia ambos' from empleados;

-- 29. Mostrar el número de empleados de sexo femenino y de sexo masculino, por departamento.
select e.`sexEmp` 'sexo' , count(e.`sexEmp`) 'numero', d.`nombreDpto`
from empleados e join departamentos d on e.`codDepto`=d.`codDepto`
GROUP BY d.`nombreDpto`, `sexEmp`;

-- 30. Hallar el salario promedio por departamento.
select round(avg(e.`salEmp`),2) 'salario medio', d.`nombreDpto`
from empleados e join departamentos d on e.`codDepto`=d.`codDepto`
GROUP BY d.`nombreDpto`;

-- 31. Mostrar la lista de los empleados cuyo salario es mayor o igual que el promedio de la empresa. Ordenarlo por departamento.
select e.`nomEmp` 'nombre empleado', e.`salEmp` 'salario', (select round(avg(`salEmp`),2) from empleados), d.`nombreDpto`
from empleados e join departamentos d on e.`codDepto`=d.`codDepto`
WHERE `salEmp`>= (select round(avg(`salEmp`),2) from empleados)
order by d.`nombreDpto`;

-- 32. Hallar los departamentos que tienen más de tres empleados. Mostrar el número de empleados de esos departamentos.
select d.`nombreDpto`, count(e.`nDIEmp`) from empleados e join departamentos d on e.`codDepto`=d.`codDepto`
GROUP BY d.`nombreDpto`
having count(e.`nDIEmp`)>3;

-- 33. Mostrar el código y nombre de cada jefe, junto al número de empleados que dirige. Solo los que tengan mas de dos empleados (2 incluido).
select j.`nDIEmp`, j.`nomEmp` 'nombre jefe', count(e.`nDIEmp`) 'num empleados' from empleados e join empleados j on j.`nDIEmp`=e.`jefeID`
GROUP BY j.`nDIEmp`
having count(j.`nDIEmp`)>1;

-- 34. Hallar los departamentos que no tienen empleados
select d.`codDepto` 'dpto sin empleados' from empleados e left outer join departamentos d on e.`codDepto`=d.`codDepto`
GROUP BY d.`codDepto`
having count(`nDIEmp`)=0;

-- 35. Mostrar el nombre del departamento cuya suma de salarios sea la más alta, indicando el valor de la suma.
select d.`nombreDpto`, sum(`salEmp`)
from empleados e join departamentos d on e.`codDepto`=d.`codDepto`
GROUP BY d.`nombreDpto` 
ORDER by sum(`salEmp`) desc
limit 1;