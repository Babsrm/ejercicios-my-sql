-- corregidos de otra manera
-- Con la base de datos jardinería hacer los siguientes procedimientos y/o funciones:


-- 1.	 Crear una función a la que se le pasa como parámetro el código de una oficina y devuelve
--  como cadena de caracteres la ciudad + el país de dicha oficina. En caso que no exista la oficina 
-- la función devuelve el valor “No existe oficina”.
USE jardineria;
DESC oficina;
DROP FUNCTION ej1;
DELIMITER //
CREATE FUNCTION ej1(p_codigo_oficina varchar(10)) RETURNS varchar(100)
NOT deterministic READS SQL DATA           
BEGIN 
    DECLARE v_ciudad varchar(30);
    DECLARE v_pais varchar(50);
    DECLARE v_cod_oficina varchar(10);

    SELECT ciudad, pais, codigo_oficina INTO v_ciudad, v_pais, v_cod_oficina
    FROM oficina
    WHERE codigo_oficina = p_codigo_oficina;

    IF v_cod_oficina IS NULL THEN
        RETURN 'No existe oficina';
    else
        RETURN CONCAT(v_ciudad, ' - ', v_pais);
    END IF;
    
END;
//
delimiter ;

SELECT ej1('BCN-ES');    
SELECT ej1('MAD-ES');                      


-- 2.	Crea un procedimiento al que le pases como parámetro el año. Deberá calcular la cantidad
-- total de pagos que se han hecho en ese año y escribir en pantalla el mensaje: “En el año x se 
-- han realizado y pedidos y se han cobrado en total z euros”.
DROP procedure ej2;
DELIMITER //
CREATE PROCEDURE ej2(p_anio smallint UNSIGNED)
NOT DETERMINISTIC reads sql data
BEGIN
    DECLARE v_cuenta int UNSIGNED;
    DECLARE v_suma decimal;

    SELECT COUNT(*), SUM(total) INTO v_cuenta, v_suma
    FROM pago WHERE year(fecha_pago)= p_anio;

    IF v_cuenta=0 THEN  
        SELECT CONCAT(' No hay pedidos en el año ', p_anio);
    ELSE
        SELECT CONCAT('En el año ', p_anio, ' se han realizado ',
                        v_cuenta,' pedidos y se han cobrado en total ',v_suma,' euros');
    END IF;
END;
//
DELIMITER ;
CALL ej2(2008);
CALL ej2(2009);


-- 3.	Crea un procedimiento al que le pases el código_cliente deberá mostrar en pantalla el 
-- siguiente mensaje: “El cliente nombre_cliente es atendido por nombre(empleado), apellido1 
-- (empleado) de la oficina de ciudad(oficina).
DROP PROCEDURE ej3;
DELIMITER //
CREATE PROCEDURE ej3(p_codigo_cliente int)
BEGIN
     DECLARE v_nombre_cliente varchar(50);
     DECLARE v_nombre_empleado varchar(50);
     DECLARE v_ape_empleado varchar(50);
     DECLARE v_ciudad varchar(30);
     /*DECLARE v_cod_rep int;
     DECLARE v_cod_oficina varchar(10);   */

     SELECT c.nombre_cliente, e.nombre,e.apellido1, o.ciudad
     INTO v_nombre_cliente, v_nombre_empleado, v_ape_empleado, v_ciudad
     FROM cliente c JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
                    JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
     WHERE c.codigo_cliente=p_codigo_cliente;

  /*
    SELECT nombre_cliente, codigo_empleado_rep_ventas 
    INTO v_nombre_cliente, v_cod_rep
    FROM cliente 
    WHERE codigo_cliente=p_codigo_cliente;

    SELECT e.nombre, e.apellido1, e.codigo_oficina 
    INTO v_nombre_cliente, v_ape_empleado, v_cod_oficina
    FROM empleado e WHERE e.codigo_empleado=v_cod_rep;

    SELECT ciudad 
    into v_ciudad
    FROM oficina o
    WHERE o.codigo_oficina = v_cod_oficina;  */

    SELECT CONCAT('El cliente ',v_nombre_cliente, ' es atendido por ', v_nombre_empleado,' ',
              v_ape_empleado, ' de la oficina de ', v_ciudad);
END;
//
 DELIMITER ;
 CALL ej3(7);




-- 4.	Crear una función a la que se le pasa como parámetro el código de un cliente y devuelve un
-- número que indica el tipo de cliente que es, atendiendo a la cantidad de límite de crédito que
--  tenga ese cliente:
    -- •	1: Si tiene un límite de crédito menor a 10.000
    -- •	2: Si tiene un límite de crédito igual o mayor a 10.000 pero menor que 100.000
    -- •	3: Si tiene un límite de crédito igual o mayor a 100.000.
    -- En caso que el cliente no exista la función devuelve -1.
DROP FUNCTION ej4;
DELIMITER //
CREATE FUNCTION ej4(p_cod_cliente int) RETURNS tinyint
NOT DETERMINISTIC READS SQL DATA
BEGIN
     DECLARE v_credito decimal;

    SELECT limite_credito INTO v_credito
    FROM cliente WHERE codigo_cliente=p_cod_cliente;

    CASE
        WHEN  v_credito <10000 THEN
            RETURN 1;
        WHEN v_credito >= 10000 AND v_credito <100000 then
            RETURN 2;
        WHEN v_credito >= 100000 THEN  
            RETURN 3;
        ELSE
            RETURN -1;
    END CASE;  
END;
//
DELIMITER ;
SELECT ej4(10);
SELECT ej4(5);
SELECT ej4(17);

 SELECT ej4(1000);


SELECT codigo_cliente,limite_credito FROM cliente;

-- 5.	Crea una función que dado un número de pedido calcule el total del importe del pedido.
DROP FUNCTION ej5;
DELIMITER //
CREATE FUNCTION ej5(p_num_pedido int) RETURNS decimal
NOT DETERMINISTIC READS SQL DATA
BEGIN
     DECLARE v_total decimal;

     SELECT SUM(precio_unidad*cantidad) INTO v_total
     FROM detalle_pedido 
     WHERE codigo_pedido=p_num_pedido;

    RETURN v_total;
END;
//
DELIMITER ;
SELECT ej5(10);

SELECT *, dp.precio_unidad*dp.cantidad FROM detalle_pedido dp WHERE dp.codigo_pedido=10;

-- 6.	Crea un procedimiento al que le pases el código_producto y actualice el precio_venta 
-- según lo siguiente:
    -- •	Si el producto es de gama Aromática o Frutales se incrementará un 5%
    -- •	Si el producto es un herramienta se incrementará el precio en 2 euros
    -- •	Si es de tipo ornamentales se le hará un descuento del 10%.
DROP PROCEDURE ej6;
DELIMITER //
CREATE PROCEDURE ej6(p_Codigo_producto varchar(15))
-- NOT DETERMINISTIC MODIFIES SQL DATA
BEGIN
     DECLARE v_precio_venta decimal(15,2);
     DECLARE v_gama varchar(50);

    SELECT precio_venta, gama INTO v_precio_venta, v_gama
    FROM producto WHERE Codigo_producto=p_Codigo_producto;

    IF v_gama IN ('aromáticas', 'frutales') THEN
        SET v_precio_venta= v_precio_venta+v_precio_venta*0.05;
    ELSEIF v_gama = 'herramientas' THEN  
        set v_precio_venta=v_precio_venta+2;
    ELSEIF v_gama = 'ornamentales' THEN
        set v_precio_venta=v_precio_venta-v_precio_venta*0.1;
    END IF;

    IF v_gama IS NOT NULL 
       AND v_gama IN ('aromaticas', 'frutales', 'herramientas', 'ornamentales') THEN  
         UPDATE producto set precio_venta=v_precio_venta
        WHERE codigo_producto=p_Codigo_producto;
    END IF;
END;
//
DELIMITER ;
SELECT * FROM producto p;
CALL ej6('OR-99');
SELECT DISTINCT gama FROM gama_producto gp;
    
-- 7.	Crea un procedimiento que dado el código de un cliente muestre en pantalla el número de pedidos 
-- que ha realizado y el total que se ha gastado
DROP PROCEDURE ej7;
DELIMITER //
CREATE PROCEDURE ej7(p_cod_cliente int)
BEGIN
    DECLARE v_num_pedidos int UNSIGNED;
    DECLARE v_total decimal(15,2);

    /*SELECT SUM(cantidad*precio_unidad) INTO v_total 
    FROM pedido p JOIN detalle_pedido dp ON p.codigo_pedido = dp.codigo_pedido
    WHERE p.codigo_cliente=p_cod_cliente;
    
    SELECT COUNT(*) INTO v_num_pedidos
    FROM pedido WHERE codigo_cliente=p_cod_cliente;  */
     
    SELECT SUM(cantidad*precio_unidad), COUNT(DISTINCT p.codigo_pedido)
    INTO v_total, v_num_pedidos 
    FROM pedido p JOIN detalle_pedido dp ON p.codigo_pedido = dp.codigo_pedido
    WHERE p.codigo_cliente=p_cod_cliente;  

    SELECT CONCAT('El cliente ',p_cod_cliente, ' ha realizado un total de ',v_num_pedidos,
                  ' pedidos por un total de ', v_total);
  END;
  //

    DELIMITER ;

CALL ej7(3);

    SELECT p.codigo_pedido, dp.numero_linea, cantidad*precio_unidad,  p.codigo_pedido     
    FROM pedido p JOIN detalle_pedido dp ON p.codigo_pedido = dp.codigo_pedido
    ORDER by p.codigo_cliente
    ;