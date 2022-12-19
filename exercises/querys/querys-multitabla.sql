-- Consultas multitabla (Composición interna). Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2.

-- 1. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos.
select p.nombre, precio, f.nombre
from producto p join fabricante f on codigo_fabricante=f.codigo;

-- 2. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos. Ordene el resultado por el nombre del fabricante, por orden alfabético.
select p.nombre, precio, f.nombre
from producto p join fabricante f on codigo_fabricante=f.codigo
order by f.nombre ASC;

-- 3. Devuelve una lista con el código del producto, nombre del producto, código del fabricante y nombre del fabricante, de todos los productos de la base de datos.
select p.codigo, p.nombre, f.codigo, f.nombre
from fabricante f join producto p on codigo_fabricante=f.codigo;

-- 4. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.
select p.nombre, precio, f.nombre
from fabricante f join producto p on codigo_fabricante=f.codigo
order by precio ASC
limit 1;

-- 5. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más caro.
select p.nombre, precio, f.nombre
from fabricante f join producto p on codigo_fabricante=f.codigo
order by precio DESC
limit 1;

-- 6. Devuelve una lista de todos los productos del fabricante Lenovo.
select p.nombre, f.nombre
from producto p join fabricante f on codigo_fabricante=f.codigo
where f.nombre= "Lenovo";

-- 7. Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que 200€.
select p.nombre, f.nombre, precio
from producto p join fabricante f on codigo_fabricante=f.codigo
where f.nombre= "Crucial" and precio > 200;

-- 8. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard y Seagate. Sin utilizar el operador IN.
select p.nombre, f.nombre
from producto p join fabricante f on codigo_fabricante=f.codigo
where f.nombre="asus" or f.nombre like "hewl%" or f.nombre="seagate";

-- 9. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard y Seagate. Utilizando el operador IN.
select p.nombre, f.nombre
from producto p join fabricante f on codigo_fabricante=f.codigo
where codigo_fabricante in (1,3,5); -- o where f.nombre in ("asus", "hewlett-packard", "seagate")

-- 10. Devuelve un listado con el nombre y el precio de todos los productos de los fabricantes cuyo nombre termine por la vocal e.
select f.nombre, p.nombre, precio
from fabricante f join producto p on f.codigo=codigo_fabricante
where f.nombre like "%e";

-- 11. Devuelve un listado con el nombre y el precio de todos los productos cuyo nombre de fabricante contenga el carácter w en su nombre.
select f.nombre, p.nombre, precio
from fabricante f join producto p on f.codigo=codigo_fabricante
where f.nombre like "%w%";

-- 12. Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que tengan un precio mayor o igual a 180€. Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente)
select p.nombre, precio, f.nombre
from fabricante f join producto p on f.codigo=codigo_fabricante
where precio >= 180
order by precio desc, p.nombre ASC;

-- 13. Devuelve un listado con el código y el nombre de fabricante, solamente de aquellos fabricantes que tienen productos asociados en la base de datos
select distinct codigo_fabricante, f.nombre
from producto p join fabricante f on codigo_fabricante=f.codigo;

-- Consultas multitabla (Composición externa). Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.

-- 1. Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los productos que tiene cada uno de ellos. El listado deberá mostrar también aquellos fabricantes que no tienen productos asociados.
select p.nombre, f.nombre
FROM fabricante f left join producto p on codigo_fabricante=f.codigo;

-- 2. Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.
select p.nombre, f.nombre
FROM fabricante f left join producto p on codigo_fabricante=f.codigo
where p.nombre is null;

-- 3. ¿Pueden existir productos que no estén relacionados con un fabricante? Justifique su respuesta.
-- No, porque tendríamos un producto que no ha fabricado nadie por lo que no tiene sentido. Además, el campo "código fabricante" es clave foránea de código en producto por lo que no puede ser null (está marcado como not null).