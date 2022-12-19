-- Consultas sobre una tabla
-- 1.	Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.
select codigo_oficina, ciudad 
from oficina;

-- 2.	Devuelve un listado con la ciudad y el teléfono de las oficinas de España.
select ciudad, telefono
from oficina where pais='espana';

-- 3.	Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.
select nombre, apellido1, apellido2, email
from empleado
where codigo_jefe=7;

-- 4.	Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.
select puesto, nombre, apellido1, apellido2, email from empleado
where puesto='director general';
-- where codigo_jefe is null

-- 5.	Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.
select nombre, apellido1, apellido2, puesto from empleado
where not puesto='representante ventas';

-- 6.	Devuelve un listado con el nombre de los todos los clientes españoles.
select nombre_cliente from cliente
where pais='Spain';

-- 7.	Devuelve un listado con los distintos estados por los que puede pasar un pedido.
SELECT DISTINCT estado from pedido;

-- 8.	Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:
-- •	Utilizando la función YEAR de MySQL.
SELECT DISTINCT codigo_cliente from pago
where year(fecha_pago)=2008;

-- •	Utilizando la función DATE_FORMAT de MySQL.
SELECT DISTINCT codigo_cliente from pago
where (DATE_FORMAT(fecha_pago,'%Y')) = 2008;

-- •	Sin utilizar ninguna de las funciones anteriores.
SELECT DISTINCT codigo_cliente from pago
where fecha_pago BETWEEN '2008-01-01' and '2008-12-31';
-- where fecha_pago like '2008%'

-- 9.	Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos que no han sido entregados a tiempo.
select codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega from pedido
where fecha_entrega>fecha_esperada;

-- 10.	Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha esperada.
-- •	Utilizando la función ADDDATE de MySQL.
select codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega from pedido
where DATE_ADD(fecha_esperada, INTERVAL -2 DAY)>=fecha_entrega;

-- •	Utilizando la función DATEDIFF de MySQL.
select codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega from pedido
where datediff(fecha_esperada,fecha_entrega)>=2;

-- •	¿Sería posible resolver esta consulta utilizando el operador de suma + o resta -?
select codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega from pedido
where (fecha_esperada-fecha_entrega)>=2;

-- 11.	Devuelve un listado de todos los pedidos que fueron rechazados en 2009.
select * from pedido
where estado="rechazado" and year(fecha_pedido)=2009;

-- 12.	Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de cualquier año.
select * from pedido
where estado='entregado' and month(fecha_entrega)=01;

-- 13.	Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal. Ordene el resultado de mayor a menor.
select * from pago
where forma_pago='paypal' and year(fecha_pago)=2008
order by fecha_pago desc;

-- 14.	Devuelve un listado con todas las formas de pago que aparecen en la tabla pago. Tenga en cuenta que no deben aparecer formas de pago repetidas.
select  distinct forma_pago from pago;

-- 15.	Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que tienen más de 100 unidades en stock. El listado deberá estar ordenado por su precio de venta, mostrando en primer lugar los de mayor precio.
select codigo_producto, nombre, gama, cantidad_en_stock from producto
where gama='ornamentales' and cantidad_en_stock>100
order by precio_venta desc;

-- 16.	Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo representante de ventas tenga el código de empleado 11 o 30.
select codigo_cliente, nombre_cliente, ciudad, codigo_empleado_rep_ventas from cliente
where ciudad='madrid' and codigo_empleado_rep_ventas in (11,30);

-- Consultas multitabla (Composición interna)
-- Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2. Las consultas con sintaxis de SQL2 se deben resolver con INNER JOIN y NATURAL JOIN.
-- 1.	Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.
select nombre_cliente, e.nombre, e.apellido1, e.apellido2 from cliente c join empleado e on c.codigo_empleado_rep_ventas= e.codigo_empleado;

-- 2.	Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.
SELECT DISTINCT nombre_cliente, e.nombre, e.apellido1, e.apellido2 from cliente c 
join empleado e on c.codigo_empleado_rep_ventas= e.codigo_empleado
join pago p on p.codigo_cliente=c.codigo_cliente;

SELECT DISTINCT c.nombre_cliente 
from cliente c 
join empleado e on e.codigo_empleado=c.codigo_empleado_rep_ventas
where codigo_cliente in (SELECT DISTINCT codigo_cliente from pago);

-- 3.	Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas.
SELECT DISTINCT nombre_cliente, e.nombre, e.apellido1, e.apellido2 from cliente c 
join empleado e on c.codigo_empleado_rep_ventas= e.codigo_empleado
left join pago p on p.codigo_cliente=c.codigo_cliente
where id_transaccion is null;

SELECT DISTINCT c.nombre_cliente, e.nombre, e.apellido1, e.apellido2
from cliente c 
join empleado e on e.codigo_empleado=c.codigo_empleado_rep_ventas
where codigo_cliente not in (SELECT DISTINCT codigo_cliente from pago);

-- 4.	Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
SELECT DISTINCT nombre_cliente, e.nombre, e.apellido1, e.apellido2, o.ciudad from cliente c 
join empleado e on c.codigo_empleado_rep_ventas= e.codigo_empleado
join pago p on p.codigo_cliente=c.codigo_cliente
join oficina o on o.codigo_oficina=e.codigo_oficina;

-- 5.	Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
SELECT DISTINCT nombre_cliente, e.nombre, e.apellido1, e.apellido2, o.ciudad from cliente c 
join empleado e on c.codigo_empleado_rep_ventas= e.codigo_empleado
left join pago p on p.codigo_cliente=c.codigo_cliente
join oficina o on o.codigo_oficina=e.codigo_oficina
where id_transaccion is null;

-- 6.	Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.
SELECT c.nombre_cliente, o.linea_direccion1, c.ciudad from cliente c 
join empleado e on c.codigo_empleado_rep_ventas= e.codigo_empleado
join oficina o on o.codigo_oficina=e.codigo_oficina
where c.ciudad='fuenlabrada';

-- 7.	Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
SELECT c.nombre_cliente, e.nombre, e.apellido1, o.ciudad from cliente c 
join empleado e on c.codigo_empleado_rep_ventas= e.codigo_empleado
join oficina o on o.codigo_oficina=e.codigo_oficina;

-- 8.	Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.
select e.nombre, e.apellido1, esJefe.nombre 'nombre jefe' from empleado esJefe right join empleado e on e.codigo_jefe = esJefe.codigo_empleado;

-- 9.	Devuelve un listado que muestre el nombre de cada empleado, el nombre de su jefe y el nombre del jefe de sus jefe.
select e.nombre, e.apellido1, esJefe.nombre 'nombre jefe', jefeDeJefe.nombre 'jefe de jefe' 
from empleado esJefe right join empleado e on e.codigo_jefe = esJefe.codigo_empleado
left join empleado jefeDeJefe on jefeDeJefe.codigo_empleado= esJefe.codigo_jefe;

-- 10.	Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.
select c.nombre_cliente, p.fecha_esperada 'fecha esperada', p.fecha_entrega 'fecha entrega' 
from cliente c join pedido p on c.codigo_cliente=p.codigo_cliente
where fecha_entrega>fecha_esperada;

-- 11.	Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.
select distinct pro.gama, cli.nombre_cliente  from cliente cli 
join pedido ped on cli.codigo_cliente = ped.codigo_cliente
join detalle_pedido dped on ped.codigo_pedido= dped.codigo_pedido
join producto pro on dped.codigo_producto= pro.codigo_producto;


-- Consultas multitabla (Composición externa)
-- Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, NATURAL LEFT JOIN y NATURAL RIGHT JOIN.
-- 1.	Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
SELECT DISTINCT c.nombre_cliente, p.forma_pago
from cliente c left join pago p on c.codigo_cliente=p.codigo_cliente
where p.forma_pago is null;

-- 2.	Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido.
SELECT DISTINCT c.nombre_cliente, p.codigo_pedido
from cliente c left join pedido p on c.codigo_cliente=p.codigo_cliente
where p.codigo_pedido is null;

-- 3.	Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que no han realizado ningún pedido.
SELECT DISTINCT c.nombre_cliente
from cliente c 
left join pago pa on c.codigo_cliente=pa.codigo_cliente
left join pedido pe on pe.codigo_cliente=c.codigo_cliente
where pe.codigo_pedido is null and pa.forma_pago is null;

SELECT DISTINCT c.nombre_cliente, p.forma_pago
from cliente c left join pago p on c.codigo_cliente=p.codigo_cliente
where p.forma_pago is null 
-- union es juntarlas como un 'OR'
intersect
-- intersect es juntarlas con un 'AND'
SELECT DISTINCT c.nombre_cliente, p.codigo_pedido
from cliente c left join pedido p on c.codigo_cliente=p.codigo_cliente
where p.codigo_pedido is null;
-- 4.	Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.
select * from empleado e left join oficina o on e.codigo_oficina=o.codigo_oficina
where e.codigo_oficina is null;

-- 5.	Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.
select * from empleado e left join cliente c on e.codigo_empleado=c.codigo_empleado_rep_ventas
where c.codigo_empleado_rep_ventas is null;

-- 6.	Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado junto con los datos de la oficina donde trabajan.
select e.nombre, e.apellido1, e.apellido1, o.codigo_oficina 'nombre oficina'
from empleado e 
left join cliente c on e.codigo_empleado=c.codigo_empleado_rep_ventas
left join oficina o on o.codigo_oficina=e.codigo_oficina
where c.codigo_empleado_rep_ventas is null;
-- 7.	Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no tienen un cliente asociado.
select e.nombre, e.apellido1, e.apellido1, o.codigo_oficina 'nombre oficina'
from empleado e 
left join cliente c on e.codigo_empleado=c.codigo_empleado_rep_ventas
left join oficina o on o.codigo_oficina=e.codigo_oficina
where c.codigo_empleado_rep_ventas is null 
OR
o.codigo_oficina is null;

-- 8.	Devuelve un listado de los productos que nunca han aparecido en un pedido.
select p.nombre 'nombre producto', p.codigo_producto, dped.codigo_pedido 'cod pedido' from producto p
left join detalle_pedido dped on dped.codigo_producto=p.codigo_producto
where dped.codigo_pedido is null;

-- 9.	Devuelve un listado de los productos que nunca han aparecido en un pedido. El resultado debe mostrar el nombre, la descripción y la imagen del producto.
select p.nombre 'nombre producto', ga.descripcion_texto ' descripción', ga.imagen 'imagen' from producto p
left join detalle_pedido dped on dped.codigo_producto=p.codigo_producto
join gama_producto ga on ga.gama=p.gama
where dped.codigo_pedido is null;

-- 10.	Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales.
-- cliente que haya realizado la compra de algún producto de la gama Frutales
SELECT DISTINCT c.codigo_empleado_rep_ventas
from cliente c 
join pedido ped on ped.codigo_cliente=c.codigo_cliente
join detalle_pedido dped on dped.codigo_pedido=ped.codigo_pedido
join producto p on p.codigo_producto=dped.codigo_producto
where p.gama='frutales';

-- Sergio lo ha resuelto bien con subconsultas de la siguiente manera:
select codigo_oficina
from oficina
where codigo_oficina not in (
            SELECT distinct e.codigo_oficina
            from cliente c join pedido USING (codigo_cliente)
                join detalle_pedido USING (codigo_pedido)
                join producto USING (codigo_producto)
                join empleado e on c.codigo_empleado_rep_ventas=e.codigo_empleado
            where gama='frutales');


-- 11.	Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.
select distinct c.*
from cliente c join pedido p on c.codigo_cliente=p.codigo_cliente
                left join pago pa on pa.codigo_cliente=c.codigo_cliente
where pa.id_transaccion is null;

-- 12.	Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el nombre de su jefe asociado.
select  e.* , jefe.nombre 'nombre jefe'
from empleado e left join cliente c on e.codigo_empleado=c.codigo_empleado_rep_ventas
                left join empleado jefe on e.codigo_jefe=jefe.codigo_empleado
where c.codigo_empleado_rep_ventas is null;

select e.*, jefe.nombre 'nombre jefe'
from empleado e left join empleado jefe on e.codigo_jefe=jefe.codigo_empleado
where e.codigo_empleado not in (select distinct codigo_empleado_rep_ventas from cliente);

-- Consultas resumen
-- 1.	¿Cuántos empleados hay en la compañía?
select Count(nombre) 'numero de empleados' from empleado;
-- 2.	¿Cuántos clientes tiene cada país?
select count(nombre_cliente) 'numero de clientes', pais from cliente
GROUP BY pais;
-- 3.	¿Cuál fue el pago medio en 2009?
select round(AVG(total),2) 'pago medio' from pago
where year(fecha_pago)=2009;

-- 4.	¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el número de pedidos.
select estado, count(estado) 'contador' from pedido
group by estado;

-- 5.	Calcula el precio de venta del producto más caro y más barato en una misma consulta.
select min(precio_venta) 'precio menor valor', max(precio_venta) 'precio mayor valor' from producto;

-- 6.	Calcula el número de clientes que tiene la empresa.
select count(nombre_cliente) 'num clientes' from cliente;

-- 7.	¿Cuántos clientes existen con domicilio en la ciudad de Madrid?
select count (nombre_cliente) 'num clientes' from cliente
where ciudad='madrid';

-- 8.	¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M?
select count (nombre_cliente) 'num clientes', ciudad from cliente
where ciudad like 'm%'
group by ciudad;

-- 9.	Devuelve el nombre de los representantes de ventas y el número de clientes al que atiende cada uno.
select e.nombre, count(c.nombre_cliente) from cliente c
join empleado e on e.codigo_empleado=c.codigo_empleado_rep_ventas
GROUP BY c.codigo_empleado_rep_ventas
order by e.nombre;

-- 10.	Calcula el número de clientes que no tiene asignado representante de ventas.
select count(codigo_cliente) from cliente c
left join empleado e on e.codigo_empleado=c.codigo_empleado_rep_ventas
where c.codigo_empleado_rep_ventas is null;

-- 11.	Calcula la fecha del primer y último pago realizado por cada uno de los clientes. El listado deberá mostrar el nombre y los apellidos de cada cliente.
select c.nombre_cliente, c.apellido_contacto, max(p.fecha_pago), min(p.fecha_pago)
from cliente c join pago p on c.codigo_cliente=p.codigo_cliente
grouP BY c.nombre_cliente;

-- 12.	Calcula el número de productos diferentes que hay en cada uno de los pedidos.
select pe.codigo_pedido 'cod pedido', count(p.nombre) 'num de prods'
from pedido pe join detalle_pedido dp on dp.codigo_pedido=pe.codigo_pedido
JOIN producto p on p.codigo_producto=dp.codigo_producto
group by pe.codigo_pedido;

select codigo_pedido 'cod pedido', count(codigo_producto) 'num de prods'
from  detalle_pedido
group by codigo_pedido;

-- 13.	Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos.
select codigo_pedido 'cod pedido', sum(cantidad) 'num de prods' from detalle_pedido
group by codigo_pedido;

-- 14.	Devuelve un listado de los 20 productos más vendidos y el número total de unidades que se han vendido de cada uno. El listado deberá estar ordenado por el número total de unidades vendidas.
select sum(cantidad), codigo_producto 'num de prods' from detalle_pedido
group by codigo_producto
order by sum(cantidad) desc
limit 20;

-- 15.	La facturación que ha tenido la empresa en toda la historia, indicando la base imponible, el IVA y el total facturado. La base imponible se calcula sumando el coste del producto por el número de unidades vendidas de la tabla detalle_pedido. El IVA es el 21 % de la base imponible, y el total la suma de los dos campos anteriores.
select 
round(sum(precio_unidad*cantidad),2) 'base imponible', 
round(sum(precio_unidad*cantidad)*0.21,2)'IVA', 
round(sum(precio_unidad*cantidad)*1.21,2) 'total facturado'
from detalle_pedido;

-- 16.	La misma información que en la pregunta anterior, pero agrupada por código de producto.
select
codigo_producto, 
round(sum(precio_unidad*cantidad),2) 'base imponible', 
round(sum(precio_unidad*cantidad)*0.21,2)'IVA', 
round(sum(precio_unidad*cantidad)*1.21,2) 'total facturado'
from detalle_pedido
GROUP BY codigo_producto;

-- 17.	La misma información que en la pregunta anterior, pero agrupada por código de producto filtrada por los códigos que empiecen por OR.
select
codigo_producto, 
round(sum(precio_unidad*cantidad),2) 'base imponible', 
round(sum(precio_unidad*cantidad)*0.21,2)'IVA', 
round(sum(precio_unidad*cantidad)*1.21,2) 'total facturado'
from detalle_pedido
-- where codigo_producto like 'or%'   esta o la having de abajo
GROUP BY codigo_producto
HAVING codigo_producto like 'or%';

-- 18.	Lista las ventas totales de los productos que hayan facturado más de 3000 euros. Se mostrará el nombre, unidades vendidas, total facturado y total facturado con impuestos (21% IVA).
select
p.nombre,
sum(dp.cantidad) 'cantidades vendidas',
round(sum(dp.precio_unidad*dp.cantidad),2) 'base imponible', 
round(sum(dp.precio_unidad*dp.cantidad)*0.21,2)'IVA', 
round(sum(dp.precio_unidad*dp.cantidad)*1.21,2) 'total facturado'
from detalle_pedido dp join producto p on dp.codigo_producto=p.codigo_producto
GROUP BY p.codigo_producto
having round(sum(dp.precio_unidad*dp.cantidad),2)>3000;

-- 19.	Muestre la suma total de todos los pagos que se realizaron para cada uno de los años que aparecen en la tabla pagos.
select sum(total) 'total pagado', year(fecha_pago) from pago
group by year(fecha_pago);

select total from pago where year(fecha_pago)=2006;