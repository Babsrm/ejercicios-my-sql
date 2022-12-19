--  Subconsultas (En la cláusula WHERE)

-- Con operadores básicos de comparación

-- 1.	Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).
select * from producto
where codigo_fabricante = (select codigo from fabricante where nombre = 'Lenovo');

select p.* from producto p join fabricante f on p.codigo_fabricante=f.codigo
where f.nombre='Lenovo';

-- 2.	Devuelve todos los datos de los productos que tienen el mismo precio que el producto más caro del fabricante Lenovo. (Sin utilizar INNER JOIN).
select p.* from producto p
where precio = (select max(precio) from producto where codigo_fabricante = (select codigo from fabricante where nombre = 'Lenovo'));

-- 3.	Lista el nombre del producto más caro del fabricante Lenovo.
select * from producto p
where precio = (select max(p1.precio) from producto p1 join fabricante f1 on p1.codigo_fabricante=f1.codigo where f1.nombre='Lenovo')
and codigo_fabricante = (select codigo from fabricante where nombre='Lenovo');

select p.nombre from producto p join fabricante f on p.codigo_fabricante=f.codigo
where f.nombre='Lenovo'
and precio = (select max(precio) from producto p1 where p.codigo_fabricante=p1.codigo_fabricante);

-- 4.	Lista el nombre del producto más barato del fabricante Hewlett-Packard.

-- 5.	Devuelve todos los productos de la base de datos que tienen un precio mayor o igual al producto más caro del fabricante Lenovo.

-- 6.	Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de todos sus productos.


--  Subconsultas con ALL y ANY

-- 8.	Devuelve el producto más caro que existe en la tabla producto sin hacer uso de MAX, ORDER BY ni LIMIT.

-- 9.	Devuelve el producto más barato que existe en la tabla producto sin hacer uso de MIN, ORDER BY ni LIMIT.

-- 10.	Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando ALL o ANY).

-- 11.	Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando ALL o ANY).


-- Subconsultas con IN y NOT IN

-- 12.	Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o NOT IN).

-- 13.	Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando IN o NOT IN).


--  Subconsultas con EXISTS y NOT EXISTS

-- 14.	Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando EXISTS o NOT EXISTS).

-- 15.	Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando EXISTS o NOT EXISTS).


--  Subconsultas correlacionadas

-- 16.	Lista el nombre de cada fabricante con el nombre y el precio de su producto más caro.

-- 17.	Devuelve un listado de todos los productos que tienen un precio mayor o igual a la media de todos los productos de su mismo fabricante.

-- 18.	Lista el nombre del producto más caro del fabricante Lenovo.


-- Subconsultas (En la cláusula HAVING)

-- 7.	Devuelve un listado con todos los nombres de los fabricantes que tienen el mismo número de productos que el fabricante Lenovo.
