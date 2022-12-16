-- 1. Inserta un nuevo fabricante indicando su código y su nombre

INSERT into fabricante
values (10, 'Saphire');

-- 2. Inserta un nuevo fabricante indicando solamente el nombre.
insert into fabricante (nombre)
values ('Sony');

-- 3. Inserta un nuevo producto asociado a uno de los nuevo fabricantes.
insert into producto 
values (12, 'TV Bravia 60"', 3000, 11);

desc producto;

-- 4 Insertar nuevo producto asociado a fabricante sin indicar el código, porque es auto incrementable
insert into producto (nombre, precio, codigo_fabricante)
values ('TV Bravia 40"', 800, 11);

-- 6 El fabricante Asus no es posible eliminarlo porque tiene productos asociados a él. 
-- Se debe eliminar primero los productos asus y después ejecutar el delete del fabricante
delete from productos
where codigo_fabricante = 1;
delete from fabricante
where nombre = 'Asus';

-- 7 El fabricante Xiaomi se puede eliminar porque no tiene ningún producto asociado
delete from fabricante
where nombre = 'Xiaomi';

-- 8 El código de fabricante de Lenovo no es posible modificarlo porque tiene asignados productos. Se deberían de borrar primero
-- 9 
update fabricante
set codigo = 30
where codigo = 8;

-- 10 actualizar los precios sumándole 5€ al actual
update producto
set precio = precio + 5;

-- 11 eliminar todas las impresoras con precio menor que 200€
delete from producto
where nombre like 'Impresora%'
and precio < 200;

-- 12 añadir nueva columna a la tabla productos que se llame canon
alter table producto
ADD canon double;

--13 actualizar columna canon y añadir solamente a los discos duros un valor de 3.5
update producto
set canon = 3.5 
where nombre like 'Disco %';

-- 14 consulta donde se muestre el nombre producto, precio, precio canon y nombre del fabricante
select producto.nombre, producto.precio, producto.precio + ifnull(producto.canon,0), fabricante.nombre from producto, fabricante
where codigo_fabricante = fabricante.codigo;

-- 15 lo mismo de antes pero que solo muestre el canon
select producto.nombre, producto.precio, producto.precio + producto.canon, fabricante.nombre from producto, fabricante
where codigo_fabricante = fabricante.codigo
and canon is not null;
