-- Con la base de datos jardinería hacer los siguientes procedimientos y/o funciones:


-- 1.	 Crear una función a la que se le pasa como parámetro el código de una oficina y devuelve como cadena de caracteres la ciudad + el país de dicha oficina. En caso que no exista la oficina la función devuelve el valor “No existe oficina”.
delimiter ;
drop function if EXISTS ej1_localizacion_oficina;
delimiter &&
create function ej1_localizacion_oficina (p_cod_oficina varchar(10))
returns varchar(100)
not DETERMINISTIC reads sql data 
BEGIN
    declare v_ciudad varchar(30) default '';
    declare v_pais varchar(50) default '';
    select ciudad, pais into v_ciudad, v_pais from oficina
        where codigo_oficina=p_cod_oficina;
    case
        when p_cod_oficina  not in (select codigo_oficina from oficina) THEN
        return 'No existe oficina';
        else return concat('La oficina está en ', v_ciudad, ' de ', v_pais, '.');
    end case;
end;
&&
delimiter ;
select ej1_localizacion_oficina(:p_cod_oficina);


-- 2.	Crea un procedimiento al que le pases como parámetro el año. Deberá calcular la cantidad total de pagos que se han hecho en ese año y escribir en pantalla el mensaje: “En el año x se han cobrado en total y euros”.
delimiter ;
drop procedure if exists ej2_pagos_en_ano;
delimiter %%
create procedure ej2_pagos_en_ano (p_ano year)
not DETERMINISTIC
BEGIN
    declare v_total_pedidos int unsigned default 0;
    declare v_total_euros decimal default 0;

    select sum(total), count(id_transaccion) 
        into v_total_euros, v_total_pedidos 
        from pago
        where year(fecha_pago)=p_ano;
    CASE
        when v_total_pedidos is null or v_total_pedidos = 0 THEN
            select concat('No se han realizado pedidos en el año ', p_ano);
        else select concat ('En el año ', p_ano, ' se han realizado un total de ', v_total_pedidos, ' que suman un total de ', v_total_euros, ' euros.');
    end case;
end;
&&
delimiter ;
call ej2_pagos_en_ano(:p_ano);

-- 3.	Crea un procedimiento al que le pases el código_cliente deberá mostrar en pantalla el siguiente mensaje: “El cliente nombre_cliente es atendido por nombre(empleado), apellido1 (empleado) de la oficina de ciudad(oficina). 
delimiter ;
drop procedure if exists ej3_datos_cliente;
delimiter &&
create procedure ej3_datos_cliente(p_cod_cliente int)
not DETERMINISTIC
BEGIN
    declare v_nom_cliente varchar(50) default '';
    declare v_nom_empleado varchar(50) default '';
    declare v_apell_empleado varchar(50) default '';
    declare v_oficina varchar(30) default '';

    select c.nombre_cliente, e.nombre, e.apellido1, o.ciudad 
        into v_nom_cliente, v_nom_empleado, v_apell_empleado, v_oficina
        from cliente c 
        join empleado e on 
            c.codigo_empleado_rep_ventas=e.codigo_empleado
        join oficina o on 
            e.codigo_oficina=o.codigo_oficina
        where c.codigo_cliente=P_cod_cliente;
    
    case
        when p_cod_cliente  not in (select codigo_cliente from cliente) THEN
        select 'No existe el cliente.';
        else select concat('El cliente ', v_nom_cliente, ' es atendido por ', v_nom_empleado, ' ', v_apell_empleado, ' de la oficina de ', v_oficina, '.');
    end case;
end;
&&
delimiter ;
call ej3_datos_cliente(:p_cod_cliente);

-- 4.	Crear una función a la que se le pasa como parámetro el código de un cliente y devuelve un número que indica el tipo de cliente que es, atendiendo a la cantidad de límite de crédito que tenga ese cliente:

    -- •	1: Si tiene un límite de crédito menor a 10.000
    -- •	2: Si tiene un límite de crédito igual o mayor a 10.000 pero menor que 100.000
    -- •	3: Si tiene un límite de crédito igual o mayor a 100.000.
    -- En caso que el cliente no exista la función devuelve -1.
delimiter;
drop function if exists ej4_tipo_cliente_segun_credito;
delimiter //
create function ej4_tipo_cliente_segun_credito (p_cod_cliente int unsigned)
returns tinyint
not DETERMINISTIC reads sql DATA
begin 

-- 5.	Crea una función que dado un número de pedido calcule el total del importe del pedido.
delimiter ;
drop function if exists ej5_importe_total_pedido;
delimiter &&
create function ej5_importe_total_pedido (p_num_pedido int)
returns decimal
not DETERMINISTIC reads sql data
BEGIN
    DECLARE v_total decimal;

    select sum(precio_unidad*cantidad) into v_total
        from detalle_pedido
        where codigo_pedido=p_num_pedido;
    
    RETURN v_total;
end;
&&
delimiter ;
select ej5_importe_total_pedido(:p_num_pedido);

-- 6.	Crea un procedimiento al que le pases el código_producto y actualice el precio_venta según lo siguiente:

    -- •	Si el producto es de gama Aromática o Frutales se incrementará un 5%
    -- •	Si el producto es un herramienta se incrementará el precio en 2 euros
    -- •	Si es de tipo ornamentales se le hará un descuento del 10%.
delimiter ;
drop delimiter if exists ej6_actualiza_precio_venta;
delimiter %%
create PROCEDURE ej6_actualiza_precio_venta(p_cod_producto varchar(15))
not DETERMINISTIC
BEGIN
    declare v_precio_venta decimal (15,2) default 0;
    DECLARE v_gama varchar(50) default '';
    select precio_venta into v_precio_venta 
        from producto where codigo_producto=p_cod_producto;

    if v_gama in ('aromática', 'frutales')
        then set v_precio_venta = v_precio_venta*1.05;
        elseif v_gama= 'herramienta'
        then set v_precio_venta = v_precio_venta+2;
        elseif v_gama='ornamentales'
        then set v_precio_venta = v_precio_venta*0.9;
    end if;

    update producto
        set precio_venta = v_precio_venta
        where codigo_producto=p_cod_producto;
end;
delimiter ;
call ej6_actualiza_precio_venta(:p_cod_producto);
-- 7.	Crea un procedimiento que dado el código de un cliente muestre en pantalla el número de pedidos que ha realizado y el total que se ha gastado
delimiter ;
drop procedure if exists ej7_num_pedidos_y_total_gastado;
delimiter %%
create PROCEDURE ej7_num_pedidos_y_total_gastado (p_cod_cliente int)
not DETERMINISTIC
BEGIN
    declare v_num_pedidos int unsigned;
    declare v_total decimal (15,2);

    select sum(cantidad*precio_unidad) into v_total
        from pedido p join detalle_pedido dp on p.codigo_pedido=dp.codigo_pedido
        where p.codigo_cliente= p_cod_cliente;
    select count (*) into v_num_pedidos
        from pedido where codigo_cliente=p_cod_cliente;

    --o también estos dos select se pueden resumir en uno:
    -- select sum(cantidad*precio_unidad), COUNT(DISTINCT p.codigo_pedido)
    --     from pedido p join detalle_pedido dp on p.codigo_pedido=dp.codigo_pedido
    --     where p.codigo_cliente=p_cod_cliente;

        select CONCAT_WS(' ', 'El cliente', p_cod_cliente, 'ha realizado un total de', v_num_pedidos, 'pedidos por un total de', v_total);
    end;
    %%
    selimiter ;
    call ej7_num_pedidos_y_total_gastado(:p_cod_cliente);

