-- Consultas resumen

-- 1.	Calcula el número total de productos que hay en la tabla productos.
select count(codigo) from producto;

-- 2.	Calcula el número total de fabricantes que hay en la tabla fabricante.
select count(codigo) from fabricante;

-- 3.	Calcula el número de valores distintos de código de fabricante aparecen en la tabla productos.
select count(DISTINCT codigo_fabricante) from producto;

-- 4.	Calcula la media del precio de todos los productos.
select avg(precio) from producto;

-- 5.	Calcula el precio más barato de todos los productos.
select min(precio) from producto;

-- 6.	Calcula el precio más caro de todos los productos.
select max(precio) from producto;

-- 7.	Lista el nombre y el precio del producto más barato.
select nombre, precio from producto
where precio = (select min (precio) from producto);

-- 8.	Lista el nombre y el precio del producto más caro.
select nombre, precio from producto
where precio = (select max(precio) from producto);

-- 9.	Calcula la suma de los precios de todos los productos.
select sum(precio) from producto;

-- 10.	Calcula el número de productos que tiene el fabricante Asus.
select count(p.codigo) from producto p join fabricante f on f.codigo = p.codigo_fabricante
where f.nombre = "Asus";

-- 11.	Calcula la media del precio de todos los productos del fabricante Asus.
select AVG(p.precio) from producto p join fabricante f on f.codigo = p.codigo_fabricante
where f.nombre = "asus";

-- 12.	Calcula el precio más barato de todos los productos del fabricante Asus.
select min(p.precio) from producto p join fabricante f on f.codigo = p.codigo_fabricante
where f.nombre="asus";

-- 13.	Calcula el precio más caro de todos los productos del fabricante Asus.
select max(p.precio) from producto p join fabricante f on f.codigo = p.codigo_fabricante
where f.nombre = "asus";

-- 14.	Calcula la suma del precio de todos los productos del fabricante Asus.
select sum(p.precio) from producto p join fabricante f on f.codigo = p.codigo_fabricante
where f.nombre = "asus";

-- 15.	Muestra el precio máximo, precio mínimo, precio medio y el número total de productos que tiene el fabricante Crucial.
select max(p.precio) "precio max", min(p.precio) "precio min", AVG(p.precio) "precio medio", count(p.nombre) "num total prod" from producto p join fabricante f on p.codigo_fabricante = f.codigo
where f.nombre = "crucial";

-- 16.	Muestra el número total de productos que tiene cada uno de los fabricantes. El listado también debe incluir los fabricantes que no tienen ningún producto. El resultado mostrará dos columnas, una con el nombre del fabricante y otra con el número de productos que tiene. Ordene el resultado descendentemente por el número de productos.
select f.nombre, count(p.nombre) from producto p right join fabricante f on f.codigo = p.codigo_fabricante
group by f.nombre
order by count(p.nombre) desc;

-- 17.	Muestra el precio máximo, precio mínimo y precio medio de los productos de cada uno de los fabricantes. El resultado mostrará el nombre del fabricante junto con los datos que se solicitan.
select max(p.precio) "precio max", min(p.precio) "precio min", AVG(p.precio) "precio medio", f.nombre from producto p join fabricante f on p.codigo_fabricante = f.codigo
GROUP BY f.nombre;

-- 18.	Muestra el precio máximo, precio mínimo, precio medio y el número total de productos de los fabricantes que tienen un precio medio superior a 200€. No es necesario mostrar el nombre del fabricante, con el código del fabricante es suficiente.
select max(p.precio) "precio max", min(p.precio) "precio min", avg(p.precio) "precio medio", count(p.nombre) "num total prod", p.codigo_fabricante 
from producto p join fabricante f on p.codigo_fabricante = f.codigo
GROUP BY f.codigo
HAVING avg(precio)>200;

-- 19.	Muestra el nombre de cada fabricante, junto con el precio máximo, precio mínimo, precio medio y el número total de productos de los fabricantes que tienen un precio medio superior a 200€. Es necesario mostrar el nombre del fabricante.
select max(p.precio) "precio max", min(p.precio) "precio min", avg(p.precio) "precio medio", count(p.nombre) "num total prod", f.nombre 
from producto p join fabricante f on p.codigo_fabricante = f.codigo
GROUP BY f.codigo
HAVING avg(precio)>200;

-- 20.	Calcula el número de productos que tienen un precio mayor o igual a 180€.
select count(p.nombre) "total productos >=180"
from producto p 
where p.precio >= 180;

-- 21.	Calcula el número de productos que tiene cada fabricante con un precio mayor o igual a 180€.
select COUNT(p.nombre) "total prod >=180", f.nombre "nombre proveedor"
from producto p join fabricante f on p.codigo_fabricante=f.codigo
 where precio>=180 GROUP BY f.nombre;

-- 22.	Lista el precio medio los productos de cada fabricante, mostrando solamente el código del fabricante.
select AVG(p.precio) "precio medio", f.codigo
from producto p join fabricante f on p.codigo_fabricante=f.codigo
group by f.nombre;

-- 23.	Lista el precio medio los productos de cada fabricante, mostrando solamente el nombre del fabricante.
select AVG(p.precio) "precio medio", f.nombre
from producto p join fabricante f on p.codigo_fabricante=f.codigo
group by f.nombre;

-- 24.	Lista los nombres de los fabricantes cuyos productos tienen un precio medio mayor o igual a 150€.
select avg(p.precio), f.nombre from producto p join fabricante f on f.codigo=p.codigo_fabricante
GROUP BY f.codigo
having avg(p.precio)>=150;

-- 25.	Devuelve un listado con los nombres de los fabricantes que tienen 2 o más productos.
select f.nombre, count(p.nombre) from producto p join fabricante f on p.codigo_fabricante= f.codigo
GROUP BY f.codigo
having COUNT(p.nombre)>=2;

-- 26.	Devuelve un listado con los nombres de los fabricantes y el número de productos que tiene cada uno con un precio superior o igual a 220 €. No es necesario mostrar el nombre de los fabricantes que no tienen productos que cumplan la condición.
/*Ejemplo del resultado esperado:
nombre	total
Lenovo	2
Asus	1
Crucial	1*/
select f.nombre, count(precio)  from producto p join fabricante f on f.codigo=p.codigo_fabricante
where precio>=220
group by f.codigo;

-- 27.	Devuelve un listado con los nombres de los fabricantes y el número de productos que tiene cada uno con un precio superior o igual a 220 €. El listado debe mostrar el nombre de todos los fabricantes, es decir, si hay algún fabricante que no tiene productos con un precio superior o igual a 220€ deberá aparecer en el listado con un valor igual a 0 en el número de productos.
/*Ejemplo del resultado esperado:
nombre	total
Lenovo	2
Crucial	1
Asus	1
Huawei	0
Samsung	0
Gigabyte	0
Hewlett-Packard	0
Xiaomi	0
Seagate	0*/
select f.nombre, count(case when precio <220 then null else precio end) cuenta
from producto p right join fabricante f on f.codigo=p.codigo_fabricante
group by f.codigo
order by cuenta desc;

-- 28.	Devuelve un listado con los nombres de los fabricantes donde la suma del precio de todos sus productos es superior a 1000 €.
select f.nombre, sum(p.precio) "suma precios>1000" from producto p join fabricante f on f.codigo=p.codigo_fabricante
GROUP BY f.codigo
having sum(p.precio)>1000;

-- 29.	Devuelve un listado con el nombre del producto más caro que tiene cada fabricante. El resultado debe tener tres columnas: nombre del producto, precio y nombre del fabricante. El resultado tiene que estar ordenado alfabéticamente de menor a mayor por el nombre del fabricante.
select 
(select nombre from producto p2 where p2.codigo_fabricante=p.codigo_fabricante order by precio desc limit 1),
max(p.precio), f.nombre 
from producto p join fabricante f on f.codigo=p.codigo_fabricante
group by f.nombre
ORDER BY f.nombre;

