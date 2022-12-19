-- Active: 1667910674547@@127.0.0.1@3306@empresa

-- 1. Escribir un bloque PL/SQL que cuente el número de filas que hay en la 
-- tabla productos (tienda), deposita el resultado en la variable v_num, 
-- y visualiza su contenido

USE tienda;

DROP PROCEDURE ej1_num_productos;

DELIMITER //
CREATE PROCEDURE ej1_num_productos ()
NOT DETERMINISTIC
BEGIN
    DECLARE v_num int UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*) INTO v_num
    FROM producto;

    SELECT
        CONCAT('Hay ', v_num, ' productos.');
END;
//

DELIMITER ; 
CALL ej1_num_productos();


-- 2. Escribir un procedimiento que reciba dos números y visualice su división.
DELIMITER //
CREATE PROCEDURE ej2_division (p_num double, p_num2 double)
DETERMINISTIC
BEGIN
    DECLARE v_res double;

    SET v_res = p_num / p_num2;

    SELECT
        CONCAT(p_num, ' entre ', p_num2, ' es ', v_res);

END
//
DELIMITER ;
CALL ej2_division(8, 4);

-- 3. Escribir un procedimiento que tome un número y escriba un texto indicando si es negativo
DELIMITER //
CREATE PROCEDURE ej3_es_negativo (p_num double)
DETERMINISTIC
BEGIN
    IF p_num < 0 THEN
        SELECT
            'El número es negativo';
    END IF;
END
//
DELIMITER ;
CALL ej3_es_negativo(3);
CALL ej3_es_negativo(-8);

CALL ej3_es_negativo(:num);

-- 4. Escribir un procedimiento que tome un número y diga si es negativo o positivo.
DROP PROCEDURE ej4_pos_neg;
DELIMITER //
CREATE PROCEDURE ej4_pos_neg (p_num double)
DETERMINISTIC
BEGIN
    IF p_num < 0 THEN
        SELECT
            CONCAT('El número ', p_num, ' es negativo') mensaje;
    ELSE
        SELECT
            CONCAT('El número ', p_num, ' es positivo o cero') mensaje;
    END IF;
END;
//
DELIMITER ;
CALL ej4_pos_neg(7);
CALL ej4_pos_neg(0);
CALL ej4_pos_neg(-9);


-- 5. Escribir un procedimiento que tome un número y diga si es negativo, positivo o cero.

DROP PROCEDURE ej5_pos_neg_cero;
DELIMITER //
CREATE PROCEDURE ej4_pos_neg_cero (p_num double)
DETERMINISTIC
BEGIN
    IF p_num < 0 THEN
        SELECT
            CONCAT('El número ', p_num, ' es negativo') mensaje;
    ELSEIF p_num = 0 THEN
        SELECT
            CONCAT('El número ', p_num, ' es cero') mensaje;
    ELSE
        SELECT
            CONCAT('El número ', p_num, ' es positivo') mensaje;
    END IF;
END;
//
/*
drop procedure ej5_pos_neg_cero;
delimiter //
create procedure ej4_pos_neg_cero(p_num double)
deterministic
BEGIN
	if p_num<0 then 
		select CONCAT('El número ',p_num, ' es negativo') mensaje;
	else if p_num=0 THEN
			select CONCAT('El número ',p_num, ' es cero') mensaje;
		else
			select CONCAT('El número ',p_num, ' es positivo') mensaje;
		end if;
	end if;
end;
*/

DELIMITER ;
CALL ej4_pos_neg_cero(5);

CALL ej4_pos_neg_cero(0);
CALL ej4_pos_neg_cero(-9);


-- 6. Escribir un procedimiento que reciba un número e indique si es par o impar
DELIMITER ;
DROP PROCEDURE ej6_par_impar;
DELIMITER //
CREATE PROCEDURE ej6_par_impar (p_num int)
DETERMINISTIC
BEGIN
    IF (p_num % 2) = 0 THEN
        -- if mod(p_num,2) = 0 then
        SELECT
            ' El número es par o 0';
    ELSE
        SELECT
            'El número es impar';
    END IF;
END;
//

DELIMITER ;
CALL ej6_par_impar(8);

CALL ej6_par_impar(0);
CALL ej6_par_impar(7);

-- 7. Escribir un procedimiento que reciba un número e indique si está entre 1 y 10 o no
DELIMITER ;
DROP PROCEDURE ej7_entre_1y10;
DELIMITER //
CREATE PROCEDURE ej7_entre_1y10 (p_num double) DETERMINISTIC
BEGIN
    -- if p_num between 1 and 10 then 
    IF p_num >= 1
        AND p_num <= 10 THEN
        SELECT
            CONCAT(p_num, ' está entre 1 y 10');
    ELSE
        SELECT
            CONCAT(p_num, ' NO está entre 1 y 10');
    END IF;
END
//

DELIMITER ;
CALL ej7_entre_1y10(-8);

CALL ej7_entre_1y10(20);
CALL ej7_entre_1y10(7);
CALL ej7_entre_1y10(1);
CALL ej7_entre_1y10(10);


-- 8. Escribir un procedimiento que reciba un número e indique si es par o mayor que 10.
DELIMITER ; 
DROP PROCEDURE ej8_par_o_mayor10;
DELIMITER //
CREATE PROCEDURE ej8_par_o_mayor10 (p_num int) DETERMINISTIC
BEGIN
    IF (p_num % 2 = 0)
        OR p_num > 10 THEN
        SELECT
            CONCAT(' El numero ', p_num, ' es par o mayor que 10');
    ELSE
        SELECT
            CONCAT(' El numero ', p_num, ' es impar y menor que 10');
    END IF;
END
//
DELIMITER ;
CALL ej8_par_o_mayor10(6);
CALL ej8_par_o_mayor10(12);
CALL ej8_par_o_mayor10(7);
CALL ej8_par_o_mayor10(15);
CALL ej8_par_o_mayor10(10);

DELIMITER ; 
DROP PROCEDURE ej8_par_o_mayor10_v2;
DELIMITER //
CREATE PROCEDURE ej8_par_o_mayor10_v2 (p_num int) DETERMINISTIC
BEGIN
    IF p_num % 2 = 0 THEN
        IF p_num > 10 THEN
            SELECT
                CONCAT(' El numero ', p_num, ' es par y mayor que 10');
        ELSE
            SELECT
                CONCAT(' El numero ', p_num, ' es par y menor que 10');
        END IF;
    ELSE
        SELECT
            CONCAT(' El numero ', p_num, ' es impar y menor que 10');
    END IF;
END
//

DELIMITER ; 
DROP PROCEDURE ej8_par_o_mayor10_v3;
DELIMITER //
CREATE PROCEDURE ej8_par_o_mayor10_v3 (p_num int) DETERMINISTIC
BEGIN
    IF p_num % 2 = 0
        AND p_num > 10 THEN
        SELECT
            CONCAT(' El numero ', p_num, ' es par y mayor que 10');
    ELSEIF p_num % 2 = 0 THEN
        SELECT
            CONCAT(' El numero ', p_num, ' es par y menor que 10');
    ELSE
        SELECT
            CONCAT(' El numero ', p_num, ' es impar y menor que 10');
    END IF;
END
//

-- 9. Escribir un procedimiento que reciba un número e indique si es par y positivo o no.
DELIMITER ;
DROP PROCEDURE ej9_par_y_positivo;
DELIMITER //
CREATE PROCEDURE ej9_par_y_positivo (p_num int) DETERMINISTIC
BEGIN
    IF (p_num % 2 = 0)
        AND p_num > 0 THEN
        SELECT
            CONCAT(' El numero ', p_num, ' es par y positivo') Mensaje;
    ELSE
        SELECT
            CONCAT(' El numero ', p_num, ' es cero, impar o negativo') Mensaje;
    END IF;
END
//
DELIMITER ;

CALL ej9_par_y_positivo(8);

CALL ej9_par_y_positivo(9);
CALL ej9_par_y_positivo(-8);

CALL ej9_par_y_positivo(-9);

CALL ej9_par_y_positivo(0);

-- 10. Escribe un procedimiento que reciba un año e indique si es o no bisiesto
DELIMITER ;
DROP PROCEDURE ej10_bisiesto;
DELIMITER //
CREATE PROCEDURE ej10_bisiesto (p_anio smallint UNSIGNED) DETERMINISTIC
BEGIN
    IF p_anio % 4 != 0 THEN
        SELECT
            CONCAT('el año ', p_anio, ' NO es bisiesto');
    ELSE
        IF p_anio % 100 = 0
            AND p_anio % 400 <> 0 THEN
            SELECT
                CONCAT('el año ', p_anio, ' NO es bisiesto');
        ELSE
            SELECT
                CONCAT('el año ', p_anio, ' es bisiesto');
        END IF;
    END IF;
END;
DELIMITER ;
CALL ej10_bisiesto(2024);
CALL ej10_bisiesto(2022);
CALL ej10_bisiesto(2000);
CALL ej10_bisiesto(2100);

-- 11. Escribe un procedimiento que consulte el número de registros de la tabla productos(tienda) e indique si el número de filas es superior o inferior a 10.
DROP PROCEDURE ej11_numfila_mayor10;


SELECT
    COUNT(*)
FROM producto
WHERE nombre = 'iifdklsjfkldsklfjdkls';

DELIMITER //
CREATE PROCEDURE ej11_numfila_mayor10 () NOT DETERMINISTIC
BEGIN
    DECLARE v_cuenta int UNSIGNED;
    SELECT
        COUNT(*) INTO v_cuenta
    FROM producto;

    IF v_cuenta > 10 THEN
        SELECT
            CONCAT('Hay más de 10 articulos, cuenta: ', v_cuenta);
    ELSE
        SELECT
            CONCAT('Hay 10 o más artículos, cuenta: ', v_cuenta);
    END IF;
END//

DELIMITER ;

CALL ej11_numfila_mayor10();

SHOW COLUMNS FROM producto;
INSERT INTO producto (nombre, precio, codigo_fabricante)
    VALUES ('ffsdfsdf', 9999.99, 1);


DESCRIBE producto;

-- 12. Escribe un procedimiento que consulte el máximo precio de la tabla productos(tienda) y lo muestre por pantalla.
drop PROCEDURE ej12_max_precio;
DELIMITER //
CREATE PROCEDURE ej12_max_precio () NOT DETERMINISTIC
BEGIN
    DECLARE v_maxprecio double;
    SELECT
        MAX(precio) INTO v_maxprecio
    FROM producto;
    SELECT
        CONCAT('El peecio máximo es ', v_maxprecio);
END
//

DELIMITER ;

CALL ej12_max_precio();

DELETE
    FROM producto
WHERE precio = 9999.99;

drop PROCEDURE ej12_max_precio_v2;
DELIMITER //
CREATE PROCEDURE ej12_max_precio_v2 () NOT DETERMINISTIC
BEGIN
    DECLARE v_maxprecio double;
    DECLARE v_num_filas integer UNSIGNED;

    SELECT
        COUNT(*) INTO v_num_filas
    FROM producto;
    IF v_num_filas > 0 THEN
        SELECT
            MAX(precio) INTO v_maxprecio
        FROM producto;
        SELECT
            CONCAT('El peecio máximo es ', v_maxprecio);
    ELSE
        SELECT
            'No hay datos en la tabla';
    END IF;
END
//

DELIMITER ;

DESC producto;
-- 13. Escribe un procedimiento que escriba el precio de un producto pasado como parámetro (se pasará el nombre_producto).


DROP PROCEDURE ej13_precio_producto;
DELIMITER //
CREATE PROCEDURE ej13_precio_producto (p_nombre varchar(100)) NOT DETERMINISTIC
BEGIN
    DECLARE v_precio double;

    SELECT
        precio INTO v_precio
    FROM producto
    WHERE nombre = p_nombre;
    IF v_precio IS NULL THEN
        SELECT
            'Producto no encontrado';
    ELSE
        SELECT
            CONCAT_WS(' ', 'el precio del producto', p_nombre, 'es', v_precio);
    END IF;
END//

DELIMITER ;
CALL ej13_precio_producto('disco ssd 1 tb');

DROP PROCEDURE ej13_precio_producto_v2;
DELIMITER //
CREATE PROCEDURE ej13_precio_producto_v2 (p_nombre varchar(100)) NOT DETERMINISTIC
BEGIN
    DECLARE v_precio double;
    DECLARE v_nombre varchar(100);

    SELECT
        precio,
        nombre INTO v_precio, v_nombre
    FROM producto
    WHERE nombre LIKE CONCAT('%', p_nombre, '%')
    LIMIT 1;
    IF v_precio IS NULL THEN
        SELECT
            'Producto no encontrado';
    ELSE
        SELECT
            CONCAT_WS(' ', 'el precio del producto', v_nombre, 'es', v_precio);
    END IF;
END//

DELIMITER ;

CALL ej13_precio_producto_v2('ssd');

CALL ej13_precio_producto_v2('monitor');


-- 14. Crea un procedimiento que tome tres parámetros numéricos y escriba en pantalla si el primero de ellos se encuentra comprendido entre el segundo y el tercero.
DELIMITER ;
DROP PROCEDURE ej14_num_entre2num;
DELIMITER //
CREATE PROCEDURE ej14_num_entre2num (p_num double, p_num2 double, p_num3 double) DETERMINISTIC
BEGIN
    IF p_num BETWEEN p_num2 AND p_num3
        OR p_num BETWEEN p_num3 AND p_num2 THEN
        SELECT
            CONCAT(p_num, ' se encuentra entre num2 y num3 ');
    ELSE
        SELECT
            CONCAT(p_num, ' NO se encuentra entre num2 y num3 ');
    END IF;
END
//

DELIMITER ;
CALL ej14_num_entre2num(3, 4, 9);

CALL ej14_num_entre2num(6, 4, 9);

CALL ej14_num_entre2num(6, 9, 4);

-- 15. Crea una función que reciba tres parámetros numéricos y devuelva el menor de los tres.
DROP FUNCTION ej15;
DELIMITER //
CREATE FUNCTION ej15 (p_num1 double, p_num2 double, p_num3 double)
RETURNS double DETERMINISTIC
BEGIN
    IF p_num1 < p_num2
        AND p_num1 < p_num3 THEN
        RETURN p_num1;
    ELSEIF p_num2 < p_num1
        AND p_num2 < p_num3 THEN
        RETURN p_num2;
    ELSE
        RETURN p_num3;
    END IF;
END;
//
DELIMITER ;
SELECT
    ej15(10, 4, 2);
SELECT
    ej15(1, 4, 8);
SELECT
    ej15(5, 2, 9);

SELECT
    ej15(3, 3, 3);

DROP FUNCTION ej15_v2;
DELIMITER //
CREATE FUNCTION ej15_v2 (p_num1 double, p_num2 double, p_num3 double, p_num4 double, p_num5 double)
RETURNS double DETERMINISTIC
BEGIN
    DECLARE v_menor double DEFAULT p_num1;

    IF p_num2 < v_menor THEN
        SET v_menor = p_num2;
    END IF;

    IF p_num3 < v_menor THEN
        SET v_menor = p_num3;
    END IF;

    IF p_num4 < v_menor THEN
        SET v_menor = p_num4;
    END IF;
    IF p_num5 < v_menor THEN
        SET v_menor = p_num5;
    END IF;
    RETURN v_menor;
END;
//

DELIMITER ;
SELECT
    ej15_v2(3, 1, 8, 9, -4);

-- 16. Crea un procedimiento que tome tres parámetros, cod_centro, nombre y dirección. El procedimiento deberá insertar un nuevo centro en la base de datos empresa, en la tabla centros.
DROP PROCEDURE empresa.ej16;

DELIMITER ;
DESC empresa.centros;

DELIMITER //
CREATE PROCEDURE empresa.ej16 (p_cod_centro smallint UNSIGNED, p_nombre varchar(30), p_direccion varchar(50))
BEGIN
    INSERT INTO centros (cod_centro, nombre, direccion)
        VALUES (p_cod_centro, p_nombre, p_direccion);

    SELECT
        ' 1 fila insertada';
END
//

DELIMITER ;
CALL empresa.ej16(90, 'montilla', 'jarata');

-- 17. Crea un procedimiento al que se le pasen dos parámetros, el cod_empleado y el salario. Deberá actualizar el salario del empleado en la tabla empleados de la base de datos empresa.
DROP PROCEDURE empresa.ej17;

DESC empresa.empleados;
DELIMITER //
CREATE PROCEDURE empresa.ej17 (p_cod_empleado smallint UNSIGNED, p_salario smallint)
BEGIN
    UPDATE empleados
    SET salario = p_salario
    WHERE cod_empleado = p_cod_empleado;
    SELECT
        'empleado actaulizado';
END
//

DELIMITER ;
CALL empresa.ej17(100, 3000);


SELECT
    *
FROM empresa.empleados
WHERE cod_empleado = 100;

DROP PROCEDURE empresa.ej17_v2;

DESC empresa.empleados;
DELIMITER //
CREATE PROCEDURE empresa.ej17_v2 (p_cod_empleado smallint UNSIGNED, p_salario smallint)
BEGIN

    DECLARE v_nombre varchar(50);

    SELECT
        nombre INTO v_nombre
    FROM empresa.empleados
    WHERE cod_empleado = p_cod_empleado;

    IF v_nombre IS NULL THEN
        SELECT
            'Empleado no encontrado' mensaje;
    ELSE
        UPDATE empleados
        SET salario = p_salario
        WHERE cod_empleado = p_cod_empleado;
        SELECT
            CONCAT('empleado ', v_nombre, ' actualizado') mensaje;
    END IF;
END
//

DELIMITER ;
CALL empresa.ej17_v2(100, 4000);
DELIMITER ;
SELECT
    *
FROM empresa.departamentos;
-- 18. Crea un procedimiento (base de datos empresa) al que se le pase como parámetro el cod_departamento. El procedimiento deberá modificar el presupuesto en base a lo siguiente, si el tipo_dir es P se incrementará en un 5%, sino se disminuirá en un 3%.
DROP PROCEDURE empresa.ej18;

DELIMITER //
CREATE PROCEDURE empresa.ej18 (p_cod_departamento smallint UNSIGNED)
BEGIN
    DECLARE v_tipo_dir enum ('P', 'F');


    SELECT
        tipo_dir INTO v_tipo_dir
    FROM departamentos
    WHERE cod_departamento = p_cod_departamento;

    IF v_tipo_dir = 'p' THEN
        UPDATE departamentos
        SET presupuesto = presupuesto * 2
        WHERE cod_departamento = p_cod_departamento;
    ELSEIF v_tipo_dir = 'f' THEN
        UPDATE departamentos
        SET presupuesto = presupuesto * 0.5
        WHERE cod_departamento = p_cod_departamento;
    ELSE
        SELECT
            'Presupuesto no especificado';
    END IF;

END;
//

DELIMITER ;
SELECT
    *
FROM empresa.departamentos;

CALL empresa.ej18(111);

DROP PROCEDURE empresa.ej18_v2;

DELIMITER //
CREATE PROCEDURE empresa.ej18_v2 (p_cod_departamento smallint UNSIGNED)
BEGIN
    DECLARE v_tipo_dir enum ('P', 'F');
    DECLARE v_presupuesto smallint;


    SELECT
        tipo_dir,
        presupuesto INTO v_tipo_dir, v_presuesto
    FROM departamentos
    WHERE cod_departamento = p_cod_departamento;

    IF v_tipo_dir = 'p' THEN
        SET v_presupuesto = v_presupuesto * 2;
    ELSEIF v_tipo_dir = 'f' THEN
        SET v_presupuesto = v_presupuesto * 0.5;
    ELSE
        SELECT
            'Presupuesto no especificado';
    END IF;
    UPDATE departamentos
    SET presupuesto = v_presupuesto
    WHERE cod_departamento = p_cod_departamento;

END;
//

-- 19. Escribe una función a la que se le pase el cod_empleado de un empleado determinado. Deberás devolver el nombre del departamento al que pertenece.
DELIMITER ;

SELECT
    cod_departamento
FROM empleados
WHERE cod_empleado = 160;

SELECT
    nombre
FROM departamentos
WHERE cod_departamento = 111;





DROP FUNCTION ej19;
DELIMITER //
CREATE FUNCTION ej19 (p_cod_empleado smallint UNSIGNED)
RETURNS varchar(50)
NOT DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE v_cod_departamento smallint UNSIGNED;
    DECLARE v_nombre varchar(50);

    SELECT
        cod_departamento INTO v_cod_departamento
    FROM empleados
    WHERE cod_empleado = p_cod_empleado;

    SELECT
        nombre INTO v_nombre
    FROM departamentos
    WHERE cod_departamento = v_cod_departamento;

    RETURN v_nombre;
END;
//

DELIMITER ;
SELECT
    ej19(160);


SELECT
    cod_empleado,
    nombre,
    salario,
    ej19(cod_empleado)
FROM empleados;

DELIMITER ;

SELECT
    d.nombre
FROM empleados e
    JOIN departamentos d
        ON e.cod_departamento = d.cod_departamento
WHERE cod_empleado = 160;

DROP FUNCTION ej19_join;
DELIMITER //
CREATE FUNCTION ej19_join (p_cod_empleado smallint UNSIGNED)
RETURNS varchar(50)
NOT DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE v_nombre varchar(50);

    SELECT
        d.nombre INTO v_nombre
    FROM empleados e
        JOIN departamentos d
            ON e.cod_departamento = d.cod_departamento
    WHERE e.cod_empleado = p_cod_empleado;

    RETURN v_nombre;
END;
//

DELIMITER ;
SELECT
    ej19_join(160);



SELECT
    cod_empleado,
    nombre,
    salario,
    ej19_join(cod_empleado)
FROM empleados;

-- 20. Escribe una función a la que se le pase el cod_empleado de un empleado determinado. Deberás devolver el nombre del departamento al que pertenece su jefe.
DELIMITER ;

SELECT
    *
FROM empleados;

SELECT
    *
FROM departamentos;


SELECT
    e.nombre NombreEmp,
    jefe.nombre nombreJefe,
    de.nombre DeptEmpleado,
    de.cod_director,
    djefe.nombre DeptJefe
FROM empleados e
    JOIN departamentos de
        ON e.cod_departamento = de.cod_departamento
    JOIN empleados jefe
        ON jefe.cod_empleado = de.cod_director
    JOIN departamentos djefe
        ON djefe.cod_departamento = jefe.cod_departamento
WHERE e.cod_empleado = 160;


SELECT
    cod_departamento
FROM empleados
WHERE cod_empleado = 160; -- 111

SELECT
    cod_director
FROM departamentos
WHERE cod_departamento = 111; -- 180

SELECT
    cod_departamento
FROM empleados
WHERE cod_empleado = 180; -- 110

SELECT
    nombre
FROM departamentos
WHERE cod_departamento = 110;

DROP FUNCTION devuelveNombreDeptJefe;
DELIMITER //
CREATE FUNCTION devuelveNombreDeptJefe (p_cod_empleado smallint UNSIGNED)
RETURNS varchar(50) NOT DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE v_cod_director smallint UNSIGNED;
    DECLARE v_cod_departamento smallint UNSIGNED;
    DECLARE v_nombre varchar(50);
    DECLARE v_cod_departamento_jefe smallint UNSIGNED;

    SELECT
        cod_departamento INTO v_cod_departamento
    FROM empleados
    WHERE cod_empleado = p_cod_empleado;

    SELECT
        cod_director INTO v_cod_director
    FROM departamentos
    WHERE cod_departamento = v_cod_departamento;

    SELECT
        cod_departamento INTO v_cod_departamento_jefe
    FROM empleados
    WHERE cod_empleado = v_cod_director; -- 110

    SELECT
        nombre INTO v_nombre
    FROM departamentos
    WHERE cod_departamento = v_cod_departamento_jefe;

    RETURN v_nombre;
END
//
DELIMITER ;
SELECT
    devuelveNombreDeptJefe(110);


SELECT
    nombre,
    salario,
    devuelveNombreDeptJefe(cod_empleado) "Departamento de su jefe"
FROM empleados;

-- 21. Dada la siguiente tabla de rangos:
-- Presupuesto
-- Valor
-- Menos de 5
-- Bajo
-- Entre 5 y 10
-- Medio
-- Más de 10
-- Alto
-- Crear una función al que se le pasa un parámetro con el valor del presupuesto que devuelva el valor correspondiente a la cantidad (Bajo, Medio, Alto). Hazlo con IF.
DROP FUNCTION ej21_valor_presupuesto;
DELIMITER //
CREATE FUNCTION ej21_valor_presupuesto (p_presupuesto smallint)
RETURNS enum ('Bajo', 'Medio', 'Alto') DETERMINISTIC
BEGIN
    DECLARE v_res enum ('Bajo', 'Medio', 'Alto');
    IF p_presupuesto < 5 THEN
        SET v_res = 'Bajo';
    ELSEIF p_presupuesto BETWEEN 5 AND 10 THEN
        SET v_res = 'Medio';
    ELSEIF p_presupuesto > 10 THEN
        SET v_res = 'Alto';
    END IF;
    RETURN v_res;
END;
//
DELIMITER ;
SELECT
    ej21_valor_presupuesto(7);

SELECT
    nombre,
    cod_departamento,
    presupuesto,
    ej21_valor_presupuesto(presupuesto) valor
FROM departamentos;


DROP FUNCTION ej21_valor_presupuesto_v2;
DELIMITER //
CREATE FUNCTION ej21_valor_presupuesto_v2 (p_presupuesto smallint)
RETURNS enum ('Bajo', 'Medio', 'Alto') DETERMINISTIC
BEGIN
    IF p_presupuesto < 5 THEN
        RETURN 'Bajo';
    ELSEIF p_presupuesto BETWEEN 5 AND 10 THEN
        RETURN 'Medio';
    ELSEIF p_presupuesto > 10 THEN
        RETURN 'Alto';
    ELSE
        RETURN NULL;
    END IF;
END;
//




-- 22. Escribe una función igual al anterior apartado pero que utilice la sentencia CASE.
DROP FUNCTION ej22_valor_presupuesto;
DELIMITER //
CREATE FUNCTION ej22_valor_presupuesto (p_presupuesto smallint)
RETURNS enum ('Bajo', 'Medio', 'Alto') DETERMINISTIC
BEGIN
    DECLARE v_res enum ('Bajo', 'Medio', 'Alto');
    CASE
        WHEN p_presupuesto < 5 THEN SET v_res = 'Bajo';
        WHEN p_presupuesto BETWEEN 5 AND 10 THEN SET v_res = 'Medio';
        WHEN p_presupuesto > 10 THEN SET v_res = 'Alto';
    END CASE;
    RETURN v_res;
END;
//
DELIMITER ;
SELECT
    ej21_valor_presupuesto(7);


DROP FUNCTION ej22_valor_presupuesto_v2;
DELIMITER //
CREATE FUNCTION ej22_valor_presupuesto_v2 (p_presupuesto smallint)
RETURNS enum ('Bajo', 'Medio', 'Alto') DETERMINISTIC
BEGIN
    CASE
        WHEN p_presupuesto < 5 THEN RETURN 'Bajo';
        WHEN p_presupuesto BETWEEN 5 AND 10 THEN RETURN 'Medio';
        WHEN p_presupuesto > 10 THEN RETURN 'Alto';
        ELSE RETURN NULL;
    END CASE;
END;
//


-- 23. Crea una función que reciba como parámetro el número del día de la semana. 
-- Deberá devolver el nombre del día (1- Lunes, 2-Martes, 3-Miercoles…)
DELIMITER ;
DROP FUNCTION ej23_dia_semana;
DELIMITER //
CREATE FUNCTION ej23_dia_semana (p_dia tinyint UNSIGNED)
RETURNS varchar(9)
DETERMINISTIC
BEGIN
    IF p_dia = 1 THEN
        RETURN 'Lunes';
    ELSEIF p_dia = 2 THEN
        RETURN 'Martes';
    ELSEIF p_dia = 3 THEN
        RETURN 'Miércoles';
    ELSEIF p_dia = 4 THEN
        RETURN 'Jueves';
    ELSEIF p_dia = 5 THEN
        RETURN 'Viernes';
    ELSEIF p_dia = 6 THEN
        RETURN 'Sábado';
    ELSEIF p_dia = 7 THEN
        RETURN 'Domingo';
    ELSE
        RETURN 'Error';
    END IF;
END;
//
DELIMITER ;

SELECT ej23_dia_semana(1);
SELECT ej23_dia_semana(2);
SELECT ej23_dia_semana(3); 
SELECT ej23_dia_semana(4);
SELECT ej23_dia_semana(5);
SELECT ej23_dia_semana(6);
SELECT ej23_dia_semana(7);
SELECT ej23_dia_semana(9);
SELECT ej23_dia_semana(null); 

DROP FUNCTION ej23_dia_semana_case;
DELIMITER //
CREATE FUNCTION ej23_dia_semana_case (p_dia tinyint UNSIGNED)
RETURNS varchar(9)
DETERMINISTIC
BEGIN
    CASE p_dia 
    WHEN 1 THEN
        RETURN 'Lunes';
    when 2 THEN
        RETURN 'Martes';
    when 3 THEN
        RETURN 'Miércoles';
    WHEN 4 THEN
        RETURN 'Jueves';
    WHEN 5 THEN
        RETURN 'Viernes';
    WHEN 6 THEN
        RETURN 'Sábado';
    WHEN 7 THEN
        RETURN 'Domingo';
    ELSE
        RETURN 'Error';
    END CASE;
END;
//                                
DELIMITER ;


SELECT ej23_dia_semana_case(5);


-- 24. Escribir una función que tome como parámetro el salario de un empleado y calcule el tipo 
-- impositivo que se le debe aplicar según los tramos de salarios especificados en la siguiente tabla. 
-- Hazlo mediante la sentencia IF
DROP FUNCTION ej24_tipo_impositivo;
DELIMITER //
CREATE FUNCTION ej24_tipo_impositivo(p_salario smallint)
RETURNS double DETERMINISTIC
BEGIN
    DECLARE v_tipo double;

    IF p_salario < 1200 THEN
        SET v_tipo = 0.05;
    ELSEIF p_salario  BETWEEN 1200 AND 1300 THEN
        SET v_tipo =  0.08;
    ELSEIF p_salario BETWEEN 1301 AND 1400 THEN    
        SET v_tipo = 0.1;
    ELSEIF p_salario BETWEEN 1401 AND 1500 THEN 
        SET v_tipo = 0.12;
    ELSEIF p_salario>1500 then
        SET v_tipo = 0.15;
    END IF;
    RETURN v_tipo;
END;
//

DELIMITER ;

SELECT ej24_tipo_impositivo(800);
SELECT ej24_tipo_impositivo(1200);
SELECT ej24_tipo_impositivo(1250);
SELECT ej24_tipo_impositivo(1300);
SELECT ej24_tipo_impositivo(1370);
SELECT ej24_tipo_impositivo(1401);
SELECT ej24_tipo_impositivo(1500);
SELECT ej24_tipo_impositivo(2000);
SELECT ej24_tipo_impositivo(NULL);



SELECT nombre,salario, CONCAT(ej24_tipo_impositivo(salario)*100, ' % ') "tipo impositivo",
       salario*ej24_tipo_impositivo(salario) "retención",
       salario - salario*ej24_tipo_impositivo(salario) "salario neto"
FROM empleados;
      


 


-- Renta
-- Tipo impositivo
-- Menos de 1200€
-- 5%
-- Entre 1200€ y 1300€
-- 8%
-- Entre 1301€ y 1400€
-- 10%
-- Entre 1401€ y 1500€
-- 12%
-- Más de 1501
-- 15%

-- 25. Haz una función equivalente a la anterior utilizando la sentencia CASE.
DROP FUNCTION ej25_tipo_impositivo;
DELIMITER //
CREATE FUNCTION ej25_tipo_impositivo(p_salario smallint)
RETURNS double DETERMINISTIC
BEGIN
    DECLARE v_tipo double;

    
    CASE
    when p_salario < 1200 THEN
        SET v_tipo = 0.05;
    when p_salario  BETWEEN 1200 AND 1300 THEN
        SET v_tipo =  0.08;
    WHEN  p_salario BETWEEN 1301 AND 1400 THEN    
        SET v_tipo = 0.1;
    WHEN p_salario BETWEEN 1401 AND 1500 THEN 
        SET v_tipo = 0.12;
    WHEN p_salario>1500 then
        SET v_tipo = 0.15;
    END CASE;
    RETURN v_tipo;
END;
//


-- 26. Modifica la función anterior para que en lugar de tomar el salario del empleado se le pase 
-- el código del empleado. Deberás buscar el salario en la tabla empleados (base de datos empresa)
DROP FUNCTION ej26_tipo_impositivo;
DELIMITER //
CREATE FUNCTION ej26_tipo_impositivo(p_cod_empleado smallint UNSIGNED) RETURNS double
NOT DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE v_salario smallint UNSIGNED;
    DECLARE v_res double;

    SELECT salario INTO v_salario
    FROM empleados WHERE cod_empleado=p_cod_empleado;

    SET v_res=  ej24_tipo_impositivo(v_salario);
    RETURN v_res;
END;
//

DELIMITER ;

SELECT ej26_tipo_impositivo(110);

-- 27. Crea una función al que se le pase el cod_empleado y que calcule el salario neto después de
--  quitarle el tipo impositivo que le corresponde.
DROP FUNCTION ej27_salario_neto;
DELIMITER //
CREATE FUNCTION ej27_salario_neto(p_cod_empleado smallint UNSIGNED) RETURNS double
NOT DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE v_salario smallint UNSIGNED;
    DECLARE v_res double;
    DECLARE v_tipo double;
    
    SELECT salario INTO v_salario
    FROM empleados WHERE cod_empleado=p_cod_empleado;

    SET v_tipo = ej25_tipo_impositivo(v_salario);

    SET v_res = v_salario - v_salario*v_tipo;

    -- RETURN v_salario-v_salario* ej25_tipo_impositivo(v_salario);
    RETURN v_res;
END;
// 

DELIMITER ;

SELECT ej27_salario_neto(110);
    
    
SELECT nombre, salario, ej24_tipo_impositivo(salario),
       ej27_salario_neto(cod_empleado)
FROM empleados;    
     

-- 28. Escribe un procedimiento al que le pases un número como parámetro y 
-- escriba todos los números comprendidos entre 1 y número pasado como parámetro
DROP PROCEDURE ej28_numerosdel1aln;
DELIMITER //
CREATE PROCEDURE ej28_numerosdel1aln(p_num smallint UNSIGNED)
DETERMINISTIC
BEGIN
    DECLARE v_i smallint UNSIGNED DEFAULT 1;

    WHILE v_i<=p_num DO 
        SELECT v_i;
        set v_i=v_i+1;
    END WHILE;
END;
//
DELIMITER ;
CALL ej28_numerosdel1aln(9);

DROP PROCEDURE ej28_numerosdel1aln_concat;
DELIMITER //
CREATE PROCEDURE ej28_numerosdel1aln_concat(p_num smallint UNSIGNED)
DETERMINISTIC
BEGIN
    DECLARE v_i smallint UNSIGNED DEFAULT 1;
    DECLARE v_res varchar(100) DEFAULT '';

    WHILE v_i<=p_num DO 
        SET v_res = CONCAT(v_res, ' ', v_i);
        set v_i=v_i+1;
    END WHILE;
    SELECT v_res;                                  
END;
//
DELIMITER ;
CALL ej28_numerosdel1aln_concat(9);

DROP PROCEDURE ej28_numerosdel1aln_repeat;
DELIMITER //
CREATE PROCEDURE ej28_numerosdel1aln_repeat(p_num smallint UNSIGNED)
DETERMINISTIC
BEGIN
    DECLARE v_i smallint UNSIGNED DEFAULT 1;

    REPEAT
        SELECT v_i;
        set v_i=v_i+1;
    UNTIL v_i>p_num
    END REPEAT;

END;
//
DELIMITER ;
CALL ej28_numerosdel1aln_repeat(9);

-- 29. Haz lo mismo que el ejercicio anterior pero deberá ser una cuenta atrás.
DROP PROCEDURE ej29_cuentaatrasdesde;
DELIMITER //
CREATE PROCEDURE ej29_cuentaatrasdesde(p_num smallint UNSIGNED)
DETERMINISTIC
BEGIN
    DECLARE v_i smallint UNSIGNED DEFAULT p_num;

    WHILE v_i>0 DO 
        SELECT v_i "cuenta atras";
        set v_i=v_i-1;
    END WHILE;
    SELECT 0 "cuenta atras";
END;
//
DELIMITER ;
CALL ej29_cuentaatrasdesde(9);

DROP PROCEDURE ej29_cuentaatras_concat;
delimiter //
CREATE PROCEDURE ej29_cuentaatras_concat(p_num smallint UNSIGNED)
DETERMINISTIC
BEGIN
    DECLARE v_i smallint UNSIGNED DEFAULT 1;
    DECLARE v_res varchar(100) DEFAULT '';

    WHILE v_i<=p_num DO 
        SET v_res = CONCAT(v_i,' ' ,v_res);
        set v_i=v_i+1;
    END WHILE;
    SELECT v_res;
END;
//
DELIMITER ;
CALL ej29_cuentaatras_concat(9);

-- 30. Haz un procedimiento que tome dos parámetros el inicio y el fin. 
-- Deberá mostrar todos los números pares comprendidos entre los dos números.
DROP PROCEDURE ej30_pares_entre;
delimiter //
CREATE PROCEDURE ej30_pares_entre(p_inicio smallint, p_fin smallint ) 
BEGIN
    declare v_i smallint DEFAULT p_inicio;

    WHILE v_i <= p_fin DO
        IF v_i % 2 = 0 THEN 
            SELECT v_i;
        END IF;
        set v_i=v_i+1;
    END WHILE;
END;
//
DELIMITER ;

CALL ej30_pares_entre(3, 12);
CALL ej30_pares_entre(-2, 19);
CALL ej30_pares_entre(12, 3);

DROP PROCEDURE ej30_pares_entre_v2;
delimiter //
CREATE PROCEDURE ej30_pares_entre_v2(p_inicio smallint, p_fin smallint ) 
BEGIN
    declare v_i smallint DEFAULT LEAST(p_inicio,p_fin);

    WHILE v_i <= GREATEST(p_inicio, p_fin) DO
        IF v_i % 2 = 0 THEN 
            SELECT v_i;
        END IF;
        set v_i=v_i+1;
    END WHILE;
END;
//
DELIMITER ;

CALL ej30_pares_entre_v2(3, 12);
CALL ej30_pares_entre_v2(-2, 19);
CALL ej30_pares_entre_v2(12, 3);

DROP PROCEDURE ej30_pares_entre_v3;
delimiter //
CREATE PROCEDURE ej30_pares_entre_v3(p_inicio smallint, p_fin smallint ) 
BEGIN
    declare v_i smallint DEFAULT p_inicio;

    IF v_i%2 != 0 THEN
        set v_i=v_i+1;
    END IF;

    WHILE v_i <= p_fin DO
            SELECT v_i;
            set v_i=v_i+2;
    END WHILE;
END;
//
DELIMITER ;

CALL ej30_pares_entre_v3(3, 12);
CALL ej30_pares_entre_v3(-2, 19);
CALL ej30_pares_entre_v3(12, 3);

-- 31. Haz un procedimiento que tome tres parámetros, el valor incial, el final y 
-- el incremento. Deberá escribir en pantalla todos los números comprendidos entre
-- el inicial y final pero saltando según el incremento especificado.
DROP PROCEDURE ej31_numeros_entre_incremento;
DELIMITER //
CREATE  PROCEDURE ej31_numeros_entre_incremento(p_inicio double, p_fin double, 
              p_incremento double) deterministic
BEGIN
    DECLARE v_i double DEFAULT p_inicio;

    WHILE v_i <= p_fin DO
        SELECT v_i;
        set v_i=v_i+p_incremento;

    END WHILE;
END;
//
DELIMITER ;
CALL ej31_numeros_entre_incremento( 2, 15, 4);

CALL ej31_numeros_entre_incremento( 15, 2, -4);

-- el incremento. Deberá escribir en pantalla todos los números comprendidos entre
-- el inicial y final pero saltando según el incremento especificado.
DROP PROCEDURE ej31_numeros_entre_incremento_v2;
DELIMITER //
CREATE  PROCEDURE ej31_numeros_entre_incremento_v2(p_inicio double, p_fin double, 
              p_incremento double) deterministic
BEGIN
    DECLARE v_i double DEFAULT p_inicio;

    IF p_incremento <0 THEN
        WHILE v_i >= p_fin DO
            SELECT v_i;
            set v_i=v_i+p_incremento;
        END WHILE;
    ELSEIF p_incremento >0 THEN 
        WHILE v_i <= p_fin DO
            SELECT v_i;
            set v_i=v_i+p_incremento;
        END WHILE;
    ELSE
        SELECT 'Listo, el incremento no puede ser 0';
    END IF;
END;
//
DELIMITER ;
CALL ej31_numeros_entre_incremento_v2( 2, 15, 3);

CALL ej31_numeros_entre_incremento_v2( 15, 2, -4);

CALL ej31_numeros_entre_incremento_v2( 2, 15, 0);
-- 32. Crea un procedimiento que tome un valor entero como parámetro, 
-- deberá escribir en pantalla todos los divisores del número.
DROP PROCEDURE ej32_divisores;
DELIMITER //
CREATE PROCEDURE ej32_divisores(p_num int UNSIGNED) DETERMINISTIC
BEGIN
    DECLARE v_divisor int UNSIGNED DEFAULT 1;

    WHILE v_divisor <= p_num DO 
        IF p_num % v_divisor = 0 THEN   
            SELECT v_divisor;
        END IF;
        set v_divisor=v_divisor+1;
    END WHILE;
END;
//
DELIMITER ;
CALL ej32_divisores(12);
    

DROP PROCEDURE ej32_divisores_v2;
DELIMITER //
CREATE PROCEDURE ej32_divisores_v2(p_num int UNSIGNED) DETERMINISTIC
BEGIN
    DECLARE v_divisor int UNSIGNED DEFAULT 1;

    WHILE v_divisor <= (p_num/v_divisor) DO 
        IF p_num % v_divisor = 0 THEN   
            SELECT v_divisor;
            SELECT p_num div v_divisor;
        END IF;                    
        set v_divisor=v_divisor+1;
    END WHILE;
END;
//
DELIMITER ;
CALL ej32_divisores_v2(12);

DROP PROCEDURE ej32_divisores_v3;
DELIMITER //
CREATE PROCEDURE ej32_divisores_v3(p_num int UNSIGNED) DETERMINISTIC
BEGIN
    DECLARE v_divisor int UNSIGNED DEFAULT 1;
    DECLARE v_res varchar(1000) DEFAULT '';
    DECLARE v_res2 varchar(1000) DEFAULT '';

    WHILE v_divisor <= (p_num/v_divisor) DO 
        IF p_num % v_divisor = 0 THEN   
            set v_res= CONCAT(v_res, ' ', v_divisor);
            SET v_res2= CONCAT(p_num DIV v_divisor, ' ', v_res2);
        END IF;                    
        set v_divisor=v_divisor+1;
    END WHILE;
    SELECT CONCAT(v_res, ' ', v_res2 );
END;
//
DELIMITER ;
CALL ej32_divisores_v3(12);

-- función que devuelve el número de divisores
DROP function ej32_divisores;
DELIMITER //
CREATE function ej32_divisores(p_num int UNSIGNED) 
RETURNS int unsigned DETERMINISTIC
BEGIN
    DECLARE v_divisor int UNSIGNED DEFAULT 1;
    DECLARE v_numDivisores int UNSIGNED DEFAULT 0;

    WHILE v_divisor <= (p_num/v_divisor) DO 
        IF p_num % v_divisor = 0 THEN   
            SET v_numDivisores = v_numDivisores+2;
        END IF;                    
        set v_divisor=v_divisor+1;
    END WHILE;
    IF p_num = 1 THEN RETURN 1;
    END IF;
    RETURN v_numDivisores;
END;
//
DELIMITER ;

SELECT ej32_divisores(12);


-- 33. Crea una función que tome un parámetro entero, la función deberá 
-- sumar todos los números comprendidos entre 1 y el número. Por ejemplo, 
-- si el número es 7, se deberá sumar 1+2+3+4+5+6+7=28 y por tanto devolverá 28.
DROP FUNCTION ej33_suma_numeros;
DELIMITER //
CREATE FUNCTION ej33_suma_numeros(p_num int UNSIGNED) RETURNS int UNSIGNED
DETERMINISTIC
BEGIN
    DECLARE v_i smallint UNSIGNED DEFAULT 1;
    DECLARE v_suma smallint UNSIGNED DEFAULT 0;

    WHILE v_i <= p_num DO
        SET v_suma = v_suma + v_i;
        SET v_i = v_i+1;
    END WHILE;
    
    RETURN v_suma;
END;
//  
    
     
END;
//
delimiter ;
-- 34. Crea una función que calcule el factorial de un número
DROP FUNCTION ej34_factorial;
DELIMITER //
CREATE FUNCTION ej34_factorial(p_num smallint UNSIGNED) RETURNS double UNSIGNED
DETERMINISTIC
BEGIN
    DECLARE v_i smallint UNSIGNED DEFAULT p_num;
    DECLARE v_producto double UNSIGNED DEFAULT 1;
    
    WHILE v_i>1 DO
        SET v_producto = v_producto * v_i;
        SET v_i = v_i-1;
    END WHILE;
    RETURN v_producto;
END;
//
DELIMITER ;
SELECT ej34_factorial(5);
DELIMITER ;
SELECT ej34_factorial(150);

-- invent 
DROP FUNCTION variaciones;
DELIMITER //
CREATE FUNCTION variaciones(p_num1 smallint UNSIGNED, p_num2 smallint UNSIGNED)
RETURNS double DETERMINISTIC
BEGIN
    RETURN ej34_factorial(p_num2)/ej34_factorial(p_num2-p_num1);
END;
//
DELIMITER ;
SELECT variaciones(6,50);
 

-- 35. Crear una función que tome dos parámetros la base y el exponente, 
-- deberá devolver la potencia, baseexponente.
DROP FUNCTION ej35_potencia;
DELIMITER //
CREATE FUNCTION ej35_potencia(p_base smallint UNSIGNED, p_exponente smallint UNSIGNED)
RETURNS bigint unsigned DETERMINISTIC
BEGIN
    DECLARE v_i smallint UNSIGNED DEFAULT 1;
    DECLARE v_producto bigint unsigned DEFAULT 1;

    WHILE v_i <=p_exponente DO
        SET v_producto = v_producto * p_base;
        set v_i=v_i+1;
    END WHILE;
    RETURN v_producto;
END;
//
DELIMITER ;
SELECT ej35_potencia(2,8);

SELECT ej35_potencia(2,0);

SELECT ej35_potencia(2,-3);


DROP FUNCTION ej35_potencia_con_expo_negativos;
DELIMITER //
CREATE FUNCTION ej35_potencia_con_expo_negativos(p_base smallint UNSIGNED, 
               p_exponente smallint)
RETURNS double unsigned DETERMINISTIC
BEGIN
    DECLARE v_i smallint UNSIGNED DEFAULT 1;
    DECLARE v_producto double unsigned DEFAULT 1;

    WHILE v_i <=ABS(p_exponente) DO
        SET v_producto = v_producto * p_base;
        set v_i=v_i+1;
    END WHILE;
    IF p_exponente<0 THEN
        RETURN 1/v_producto;
    ELSE    
        RETURN v_producto;
    END IF;
END;
//
DELIMITER ;

SELECT ej35_potencia_con_expo_negativos(2,2);

SELECT ej35_potencia_con_expo_negativos(2,0);

SELECT ej35_potencia_con_expo_negativos(2,-2);



-- 36. Crea una función que diga si un número es o no primo.

SELECT ej32_divisores(7);
SELECT ej32_divisores(8);
SELECT ej32_divisores(1);

DROP FUNCTION ej36_esprimo;
DELIMITER //
CREATE FUNCTION ej36_esprimo(p_num int UNSIGNED) RETURNS boolean 
DETERMINISTIC
begin
   IF ej32_divisores(p_num) <=2 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
    -- RETURN ej32_divisores(p_num) <=2;
END;
//

DELIMITER ;
SELECT ej36_esprimo(7);

SELECT ej36_esprimo(8);


SELECT ej32_divisores(65532);

DROP FUNCTION ej36_es_primo_mejor;
DELIMITER //
CREATE FUNCTION ej36_es_primo_mejor(p_num smallint UNSIGNED) RETURNS boolean
DETERMINISTIC
BEGIN
      DECLARE v_i smallint UNSIGNED DEFAULT 2;
      DECLARE v_primo boolean DEFAULT TRUE;

      WHILE v_i < p_num AND v_primo DO 
        IF p_num % v_i = 0 THEN
            set v_primo = FALSE;
        END IF;
        set v_i=v_i+1;
      END WHILE;
      RETURN v_primo;
END;
//
DELIMITER ;

SELECT ej36_es_primo_mejor(7);
SELECT ej36_es_primo_mejor(8);

DROP FUNCTION ej36_es_primo_mejor_v2;
DELIMITER //
CREATE FUNCTION ej36_es_primo_mejor_v2(p_num int UNSIGNED) RETURNS boolean
DETERMINISTIC
BEGIN
      DECLARE v_i int UNSIGNED DEFAULT 2;
      DECLARE v_primo boolean DEFAULT TRUE;

      WHILE v_i <= SQRT( p_num) DO 
        IF p_num % v_i = 0 THEN
            return FALSE;
        END IF;
        set v_i=v_i+1;
      END WHILE;
      RETURN true;
END;
//
DELIMITER ;

SELECT ej36_es_primo_mejor_v2(7);
SELECT ej36_es_primo_mejor_v2(8);

SELECT ej36_esprimo(100000000);

SELECT ej36_es_primo_mejor_v2(100000000);


-- Crea un procedimiento que muestre en pantalla los numeros primos 
-- comprendidos entre dos numeros
DROP PROCEDURE muestra_primos;
DELIMITER //
CREATE PROCEDURE muestra_primos(p_inicio smallint UNSIGNED, p_fin smallint UNSIGNED)
DETERMINISTIC               
BEGIN
    DECLARE v_i smallint UNSIGNED DEFAULT p_inicio;

    WHILE v_i <= p_fin DO
        IF ej36_es_primo_mejor_v2(v_i) THEN
            SELECT v_i;
        END IF;
        set v_i=v_i+1;
    END WHILE;
END;
//

DELIMITER ;
CALL muestra_primos(5,57);


SELECT ej36_es_primo_mejor_v2(9);
    

-- numero perfecto
DROP FUNCTION es_perfecto;
DELIMITER //
CREATE FUNCTION es_perfecto(p_num int UNSIGNED) RETURNs boolean
DETERMINISTIC
BEGIN
      DECLARE v_i int UNSIGNED DEFAULT 1;
      DECLARE v_suma int UNSIGNED DEFAULT 0;

    WHILE v_i < p_num DO
        IF p_num % v_i =0 THEN
            SET v_suma = v_suma + v_i;
        END IF;

        set v_i=v_i+1;
    END WHILE;
    IF v_suma = p_num THEN 
        RETURN TRUE;
    ELSE 
        RETURN FALSE;
    END IF;

    -- RETURN v_suma = p_num;
END;
//
DELIMITER ;
SELECT es_perfecto(496);