-- Active: 1667910552053@@127.0.0.1@3306@tienda

-- Consultas sobre una tabla

-- 1. Lista el nombre de todos los productos que hay en la tabla producto.
select nombre from producto;

-- 2. Lista los nombres y los precios de todos los productos de la tabla producto.
select nombre, precio from producto;

-- 3. Lista todas las columnas de la tabla producto.
select * from producto;

-- 4. Lista el nombre de los productos, el precio en euros y el precio en yenes japoneses.
select nombre, precio, round(precio*146.54,2) from producto;

-- 5. Lista el nombre de los productos, el precio en euros y el precio en yenes japoneses. Utiliza los siguientes alias para las columnas: nombre de producto, euros, yenes.
select nombre 'nombre de producto', precio euros, round(precio*146.54,2) yenes from producto;

-- 6. Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a mayúscula.
select upper(nombre), precio from producto;

-- 7. Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a minúscula.
select lower(nombre), precio from producto;

-- 8. Lista el nombre de todos los fabricantes en una columna, y en otra columna obtenga en mayúsculas los dos primeros caracteres del nombre del fabricante.
select nombre, substring(upper(nombre),1,2) from fabricante;

-- 9. Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio.
select nombre, round(precio) from producto;

-- 10. Lista los nombres y los precios de todos los productos de la tabla producto, truncando el valor del precio para mostrarlo sin ninguna cifra decimal.
select nombre, floor(precio) from producto;

-- 11. Lista el código de los fabricantes que tienen productos en la tabla producto.
select codigo_fabricante from producto;

-- 12. Lista el código de los fabricantes que tienen productos en la tabla producto, eliminando los códigos que aparecen repetidos.
select distinct codigo_fabricante from producto;

-- 13. Lista los nombres de los fabricantes ordenados de forma ascendente.
select nombre from fabricante
order by nombre asc ;

-- 14. Lista los nombres de los fabricantes ordenados de forma descendente.
select nombre from fabricante
order by nombre DESC;

-- 15. Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente y en segundo lugar por el precio de forma descendente.
select nombre, precio from producto
order by nombre asc, precio desc;

-- 16. Devuelve una lista con las 5 primeras filas de la tabla fabricante.
select * from fabricante
limit 5;

-- 17. Devuelve una lista con 2 filas a partir de la cuarta fila de la tabla fabricante. La cuarta fila también se debe incluir en la respuesta.
select * from fabricante
limit 2 offset 3;

-- 18. Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas ORDER BY y LIMIT)
select nombre, precio from producto
order by precio ASC
limit 1;

-- 19. Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT)
select nombre, precio from producto
order by precio desc
limit 1;

-- 20. Lista el nombre de todos los productos del fabricante cuyo código de fabricante es igual a 2.
select nombre, codigo_fabricante from producto
where codigo_fabricante=2;

-- 21. Lista el nombre de los productos que tienen un precio menor o igual a 120€.
select nombre, precio from producto
where precio<=120;

-- 22. Lista el nombre de los productos que tienen un precio mayor o igual a 400€.
select nombre, precio from producto
where precio>=400;

-- 23. Lista el nombre de los productos que no tienen un precio mayor o igual a 400€.
select nombre, precio from producto
where not precio>=400;

-- 24. Lista todos los productos que tengan un precio entre 80€ y 300€. Sin utilizar el operador BETWEEN.
select nombre, precio from producto
where precio>=80 and precio<=300;

-- 25. Lista todos los productos que tengan un precio entre 60€ y 200€. Utilizando el operador BETWEEN.
select nombre, precio from producto
where precio BETWEEN 60 and 200;

-- 26. Lista todos los productos que tengan un precio mayor que 200€ y que el código de fabricante sea igual a 6.
select nombre, precio, codigo_fabricante from producto
where precio>200 and codigo_fabricante=6;

-- 27. Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Sin utilizar el operador IN.
select nombre, codigo_fabricante from producto
where codigo_fabricante=1 or codigo_fabricante=3 or codigo_fabricante=5;

-- 28. Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Utilizando el operador IN.
select nombre, codigo_fabricante from producto
where codigo_fabricante in (1,3,5);

-- 29. Lista el nombre y el precio de los productos en céntimos (Habrá que multiplicar por 100 el valor del precio). Cree un alias para la columna que contiene el precio que se llame céntimos.
select nombre, precio, precio*100 centimos from producto;

-- 30. Lista los nombres de los fabricantes cuyo nombre empiece por la letra S.
select * from fabricante
where nombre like 's%';
-- se puede escribir así tambien
-- select nombre from fabricante where substring(nombre,1,1)='s';

-- 31. Lista los nombres de los fabricantes cuyo nombre termine por la vocal e.
select * from fabricante
where nombre like '%e';

-- 32. Lista los nombres de los fabricantes cuyo nombre contenga el carácter w.
select * from fabricante 
where nombre like '%w%';

-- 33. Lista los nombres de los fabricantes cuyo nombre sea de 4 caracteres.
select * from fabricante
where nombre like'____'; -- tiene 4 guiones bajos entre comillas
-- tambien se escribe asi: where char_length(nombre)=4;

-- 34. Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil en el nombre.
select * from producto
where nombre like '%portatil%';
-- también se puede hacer asi: where instr(nombre,'portatil')>0;

-- 35. Devuelve una lista con el nombre de todos los productos que contienen la cadena Monitor en el nombre y tienen un precio inferior a 215 €.
select * from producto
where nombre like '%monitor%' and precio<215;

-- 36. Lista el nombre y el precio de todos los productos que tengan un precio mayor o igual a 180€. Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente).
select nombre, precio from producto
where precio >= 180 
order by precio desc, nombre asc;