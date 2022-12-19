-- 1. Escribir un bloque PL/SQL que cuente el número de filas que hay en la tabla productos (tienda), deposita el resultado en la variable v_num, y visualiza su contenido
use tienda;
drop procedure if exists num_productos;
delimiter //
create procedure num_productos()
not deterministic
begin
	declare v_num int unsigned default 0;

	select count(*) into v_num 
	from producto p;
	
select concat_ws(' ', 'Hay', v_num, 'productos.'); 
end;
//

delimiter ;
call num_productos();

-- 2. Escribir un procedimiento que reciba dos números y visualice su división.
drop procedure if exists division_dos_num;
DELIMITER //
create procedure division_dos_num(p_num1 double, p_num2 double)
DETERMINISTIC
BEGIN
declare v_num1, v_num2 double;
declare v_res double;
set v_num1=p_num1;
set v_num2=p_num2;
set v_res=v_num1/v_num2;
select concat('La división entre ', p_num1, ' y ', p_num2, ' es ', v_res,'.');
end;
//
delimiter ;
call division_dos_num(8,2);
-- 3. Escribir un procedimiento que tome un número y escriba un texto indicando si es negativo
drop procedure if EXISTS es_negativo;
delimiter //
create procedure es_negativo(p_num1 double)
DETERMINISTIC
BEGIN
if p_num1<0 then select concat('El número ', p_num1, ' es negativo.');
end if;
end;
//
delimiter ;
call es_negativo (2);

-- 4. Escribir un procedimiento que tome un número y diga si es negativo o positivo.
drop procedure if exists positivo_o_negativo;
delimiter //
create procedure positivo_o_negativo (p_num1 double)
deterministic
BEGIN
if p_num1<0 then select concat('El número ', p_num1, ' es negativo.');
else select concat('El número ', p_num1, ' es positivo.');
end if;
end;
//
delimiter ;
call positivo_o_negativo(:p_num1);

-- 5. Escribir un procedimiento que tome un número y diga si es negativo, positivo o cero.
delimiter ;
drop procedure if exists positivo_negativo_o_cero;
delimiter //
create procedure positivo_negativo_o_cero (p_num1 double)
DETERMINISTIC
BEGIN
	if p_num1<0 
		then select concat('El número ', p_num1, ' es negativo.');
	elseif p_num1>0 
		then select concat('El número ', p_num1, ' es positivo.');
	else select concat('El número es cero.');
	end if;
end;
//
delimiter ;
call positivo_negativo_o_cero(:p_num1);

-- 6. Escribir un procedimiento que reciba un número e indique si es par o impar
delimiter ;
drop procedure if exists par_o_impar;
delimiter //
create procedure par_o_impar(p_num1 double)
DETERMINISTIC
begin
if MOD(p_num1,2)=0 then select concat('El número ', p_num1, ' es par.');
elseif mod(p_num1,2)<>0 then select concat('El número ', p_num1, ' es impar.');
else select concat('El número es cero.');
end if;
end;
delimiter ;
call par_o_impar(:p_num1);
-- 7. Escribir un procedimiento que reciba un número e indique si está entre 1 y 10 o no
delimiter;
drop PROCEDURE if exists num_entre_1_y_10;
delimiter //
create procedure num_entre_1_y_10 (p_num1 double)
DETERMINISTIC
BEGIN
if p_num1 BETWEEN 1 and 10 then select concat('El número ', p_num1, ' está comprendido entre 1 y 10.') mensaje;
end if;
end;
//
delimiter ;
call num_entre_1_y_10(:p_num1);

-- 8. Escribir un procedimiento que reciba un número e indique si es par o mayor que 10.
delimiter;
drop PROCEDURE if exists par_o_mayor_que_10;
delimiter //
create procedure par_o_mayor_que_10 (p_num1 double)
DETERMINISTIC
BEGIN
if p_num1>10 or mod(p_num1,2)=0 then select 'El número introducido es par o mayor que 10' resultado;
end if;
end;
//
delimiter ;
call par_o_mayor_que_10 (:p_num1);

-- 9. Escribir un procedimiento que reciba un número e indique si es par y positivo o no.
delimiter ;
drop PROCEDURE if EXISTS par_positivo_o_no;
delimiter //
create PROCEDURE par_positivo_o_no (p_num1 float)
DETERMINISTIC
BEGIN
if p_num1>0 and mod(p_num1, 2)=0 then select 'El número indicado es par y positivo.';
else select 'El número indicado es cero, impar o negativo.';
end if;
end;
//
delimiter ;
call par_positivo_o_no(:p_num1);

-- 10. Escribe un procedimiento que reciba un año e indique si es o no bisiesto
delimiter ;
drop PROCEDURE if exists ano_bisiesto_o_no;
delimiter //
create procedure ano_bisiesto_o_no (p_num1 int unsigned)
DETERMINISTIC
BEGIN
    -- if p_num%4 <>0
	if mod(p_num1,4)<>0 then
		select 'Año no bisiesto.';
	elseif mod(p_num1,400)=0 or mod(p_num1,100)<>0 then
		select "Año bisiesto.";
	else 
		select 'Año NO bisiesto.';
	end if;
end;
//
delimiter ;
call ano_bisiesto_o_no (:p_num1);

-- 11. Escribe un procedimiento que consulte el número de registros de la tabla productos(tienda) e indique si el número de filas es superior o inferior a 10.
delimiter ;
drop procedure if exists num_filas_mayor_o_menor_10;
delimiter //
create procedure num_filas_mayor_o_menor_10()
not DETERMINISTIC
BEGIN
	declare v_contador int unsigned default 0;
	select count(*) into v_contador from producto;
	if v_contador>= 10 then select 'El número de filas es 10 o superior.';
	else select 'El número de filas es inferior a 10.';
	end if;
end;
//
delimiter ;
call num_filas_mayor_o_menor_10;

-- 12. Escribe un procedimiento que consulte el máximo precio de la tabla productos(tienda) e y lo muestre por pantalla.
delimiter ;
drop PROCEDURE if exists max_precio_en_la_tabla_producto;
delimiter //
create PROCEDURE max_precio_en_la_tabla_producto ()
not DETERMINISTIC
BEGIN
	declare v_resultado float default 0;
	select max(precio) into v_resultado from producto;
	select concat('El precio máximo es ', v_resultado);
end;
//
delimiter;
call max_precio_en_la_tabla_producto;

-- 13. Escribe un procedimiento que escriba el precio de un producto pasado como parámetro (se pasará el nombre_producto).
delimiter ;
drop procedure if exists precio_de_producto_introducido;
delimiter //
desc producto.nombre;
create PROCEDURE precio_de_producto_introducido(p_nombreprod varchar(100))
not DETERMINISTIC
BEGIN
	declare v_resultado double;
	select precio into v_resultado from producto
	where nombre like concat ('%',p_nombreprod,'%')
	limit 1;
	if v_resultado is null then select 'El producto no se existe en la DB.';
		else select concat('El precio de ', p_nombreprod, ' es ', v_resultado, ' euros.');
	end if;
end;
//
delimiter ;
call precio_de_producto_introducido(:p_nombreprod);
	
-- 14. Crea un procedimiento que tome tres parámetros numéricos y escriba en pantalla si el primero de ellos se encuentra comprendido entre el segundo y el tercero.
delimiter ;
drop PROCEDURE if EXISTS num1_comprendido_entre_otros;
delimiter //
create PROCEDURE num1_comprendido_entre_otros (p_num1 double, p_num2 double, p_num3 double)
DETERMINISTIC
BEGIN
	if p_num1>=p_num2 and p_num1<=p_num3 
		then select concat('El número ', p_num1, ' está comprendido entre ', p_num2, ' y ', p_num3);
		elseif p_num1>=p_num3 and p_num1<=p_num2 
			then select concat('El número ', p_num1, ' está BLABLAcomprendido entre ', p_num3, ' y ', p_num2);
		else select concat('El número ', p_num1, ' NO está comprendido entre ', p_num2, ' y ', p_num3);
	end if;
end;
//
delimiter ;
call num1_comprendido_entre_otros (:p_num1, :p_num2, :p_num3);

-- 15. Crea una función que reciba tres parámetros numéricos y devuelva el menor de los tres.
delimiter ;
drop function if exists menor_de_3_numeros;
delimiter //
create function menor_de_3_numeros(p_num1 double, p_num2 double, p_num3 double)
returns double 
DETERMINISTIC
BEGIN
	if p_num1>=p_num2 and p_num2<=p_num3 
		then return p_num2;
		elseif  p_num1>=p_num3 and p_num2>=p_num3 
		then return p_num3; 
		else return p_num1; 
	end if;
end;
//
delimiter ;
select menor_de_3_numeros(:p_num1, :p_num2, :p_num3);

--version 2, más valida para más opciones
create function ej15 (p_num1 double, p_num2 double, p_num3 double, p_num4 double, p_num5 double)
returns double DETERMINISTIC
BEGIN
	declare v_menor double default p_num1;
	
	if p_num2 < v_menor then
		set v_menor = p_num2;
	end if;
	if p_num3 < v_menor THEN
		set v_menor = p_num3;
	end if;
	if p_num4 < v_menor then
		set v_menor = p_num4;
	end if;
	if p_num5 < v_menor THEN
		set v_menor = p_num5;
	end if;
return v_menor;
end;

-- 16. Crea un procedimiento que tome tres parámetros, cod_centro, nombre y dirección. El procedimiento deberá insertar un nuevo centro en la base de datos empresa, en la tabla centros.
delimiter ;
use empresa;
drop PROCEDURE if exists insertar_nuevo_centro_empresa;
desc centros;
DELIMITER &&
create PROCEDURE insertar_nuevo_centro_empresa (p_cod_centro smallint unsigned, p_nombre varchar(30), p_direccion varchar(50))
not DETERMINISTIC
begin
	insert centros (cod_centro, nombre, direccion)
			values (p_cod_centro, p_nombre, p_direccion);
	select '1 fila insertada';
end;
&&
delimiter ;
call insertar_nuevo_centro_empresa (:p_cod_centro, :p_nombre, :p_direccion);

-- 17. Crea un procedimiento al que se le pasen dos parámetros, el cod_empleado y el salario. Deberá actualizar el salario del empleado en la tabla empleados de la base de datos empresa.
delimiter ;
use empresa;
drop PROCEDURE if EXISTS actualizar_salario_empleado;
desc empleados;
delimiter &&
create PROCEDURE actualizar_salario_empleado (p_cod_empleado smallint unsigned, p_salario SMALLINT)
not DETERMINISTIC
BEGIN
	update empleados  -- check la version 2 de las respuestas de david pq le mete una verificacion de que el cod-empleado existe
			set salario = p_salario
			where cod_empleado=p_cod_empleado;
			select 'empleado actualizado';
end;
&&
delimiter ;
call actualizar_salario_empleado (:p_cod_empleado, :p_salario);

-- 18. Crea un procedimiento (base de datos empresa) al que se le pase como parámetro el cod_departamento. El procedimiento deberá modificar el presupuesto en base a lo siguiente, si el tipo_dir es P se incrementará en un 5%, sino se disminuirá en un 3%.
delimiter ;
use empresa;
drop procedure if exists modificar_presupuesto_segun_cod_departamento;
delimiter //
create PROCEDURE modificar_presupuesto_segun_cod_departamento (p_cod_departamento smallint unsigned)
not DETERMINISTIC
begin 
	declare v_tipo_dir enum ('P', 'F');
	select tipo_dir into v_tipo_dir from departamentos
	where cod_departamento=p_cod_departamento;
	if v_tipo_dir = 'P' THEN
		update departamentos
		set presupuesto = presupuesto*2 --al ser tipo smallint, si lo multiplico por 1.05 no aprecia el resultado porque es con decimales. por eso he puesto que se doble el presupuesto o que se dismunuya a la mitad
		where cod_departamento=p_cod_departamento;
	elseif v_tipo_dir='F' THEN
		update departamentos
		SET presupuesto =  presupuesto*0.5
		where cod_departamento=p_cod_departamento;
	else select 'El presupuesto es null o no se encuentra.'; --check v2 de david
	end if;
end;
 //
delimiter ;
select * from departamentos;
start TRANSACTION;
call modificar_presupuesto_segun_cod_departamento(:p_cod_departamento);
ROLLBACK;
commit;
-- 19. Escribe una función a la que se le pase el cod_empleado de un empleado determinado. Deberás devolver el nombre del departamento al que pertenece.
delimiter ;
use empresa;
drop function if EXISTS nombre_dpto_segun_cod_empleado;
delimiter &&
create function nombre_dpto_segun_cod_empleado(p_cod_empleado SMALLINT unsigned)
returns varchar(50) 
not DETERMINISTIC reads sql data
begin 
	declare v_nombre_dpto varchar(50);
	declare v_cod_dpto smallint;
	select cod_departamento into v_cod_dpto from empleados
		where cod_empleado=p_cod_empleado;
	select nombre into v_nombre_dpto from departamentos
		where v_cod_dpto = cod_departamento;
	RETURN v_nombre_dpto;
end;
&&
delimiter ;
select nombre_dpto_segun_cod_empleado(:p_cod_empleado);
select cod_empleado, nombre, salario, nombre_dpto_segun_cod_empleado(cod_empleado) from empleados; -- saca toda la lista de empleados y le pone la columna que sea su dpto segun la funcion anterior

-- 20. Escribe una función a la que se le pase el cod_empleado de un empleado determinado. Deberás devolver el nombre del departamento al que pertenece su jefe.
delimiter ;
drop FUNCTION if exists dpto_del_jefe_segun_cod_empleado;
delimiter %%
create FUNCTION dpto_del_jefe_segun_cod_empleado(p_cod_empleado SMALLINT unsigned)
--mal, ver el de david
returns VARCHAR(50)
not DETERMINISTIC reads sql data
begin 
	declare v_cod_dpto SMALLINT;
	declare v_cod_director smallint;
	declare v_nombre_dpto varchar(50);
	DECLARE v_cod_dpto_jefe SMALLINT unsigned;
	select cod_departamento into v_cod_dpto from empleados
		where cod_empleado=p_cod_empleado;
	select cod_director into v_cod_director from departamentos
		where v_cod_dpto= cod_departamento;
	select cod_departamento into v_cod_dpto_jefe from empleados
		where cod_empleado=v_cod_director;
	select nombre into v_nombre_dpto from departamentos
		where v_cod_dpto_jefe = cod_departamento;

		--en cada select la he guardado en una variable y la uso en el siguiente select
	return v_nombre_dpto;
end;
%%
delimiter ;
select dpto_del_jefe_segun_cod_empleado(:p_cod_empleado);
select nombre, salario, dpto_del_jefe_segun_cod_empleado(cod_empleado) from empleados;

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
delimiter ;
drop function if EXISTS ej21_valor_presupuesto_if;
delimiter %%
create function ej21_valor_presupuesto_if (p_presupuesto smallint)
returns varchar(20)
DETERMINISTIC
BEGIN
	if p_presupuesto<5 then
		return 'Bajo.';
	elseif p_presupuesto between 5 and 10 then
		RETURN 'Medio.';
	elseif return 'Alto.'; --se pone elseif tambien porque si el valor es nulo, respondería esta tambien. de esta manera, el null no aparece por ningun lado ni hace nada
	else return null;
	end if;
end;
%%
delimiter ;
select ej21_valor_presupuesto_if (:p_presupuesto);

-- 22. Escribe una función igual al anterior apartado pero que utilice la sentencia CASE.
delimiter ;
drop function if EXISTS ej22_valor_presupuesto_case;
delimiter %%
create function ej22_valor_presupuesto_case (p_presupuesto smallint)
returns varchar(20)
DETERMINISTIC
BEGIN
	case
		when p_presupuesto<5 then
			return 'Bajo.';
		when p_presupuesto>=5 and p_presupuesto<10 then
			RETURN 'Medio.';
		when p_presupuesto >=10 THEN
			return 'Alto.';
		else 
			return null;
end;
%%
delimiter ;
select ej22_valor_presupuesto_case (:p_presupuesto);

-- 23. Crea una función que reciba como parámetro el número del día de la semana. Deberá devolver el nombre del día (1- Lunes, 2-Martes, 3-Miercoles…)
delimiter ;
drop FUNCTION if exists ej23_nombre_dia_semana;
delimiter &&
create function ej23_nombre_dia_semana (p_number smallint unsigned)
returns varchar(50)
DETERMINISTIC
BEGIN
	case p_number
		when 1 then return 'Lunes.';
		when 2 then return 'Martes.';
		when 3 then return 'Miércoles.';
		when 4 then return 'Jueves.';
		when 5 then return 'Viernes.';
		when 6 then return 'Sábado.';
		when 7 then return 'Domingo.';
		else return 'El número introducido no es válido.';
	end case;
End;
&&
delimiter ;
select ej23_nombre_dia_semana(:p_number);

-- 24. Escribir una función que tome como parámetro el salario de un empleado y calcule el tipo impositivo que se le debe aplicar según los tramos de salarios especificados en la siguiente tabla. Hazlo mediante la sentencia IF

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
delimiter ;
drop function if exists ej24_cual_tipo_impositivo_corresponde;
delimiter &&
create function ej24_cual_tipo_impositivo_corresponde (p_salario smallint unsigned)
RETURNS varchar (150)
DETERMINISTIC
BEGIN
	if p_salario <1200 
		then return 'Tipo impositivo aplicado 5%.';
	elseif p_salario<=1300 -- no hace falta poner que esté entre 1200 y 1300 porque si ya es menor que 1200 entra esa primera opcion.
		then return 'Tipo impositivo aplicado 8%.';
	ELSEIF p_salario>=1301 and p_salario<=1400  --en estas sí dejo las comparaciones entre dos números pero no hacen falta. las dejo porque las escribí así por primera vez y es como piensa mi lógica
		then return 'Tipo impositivo aplicado 10%.';
	elseif p_salario>=1401 and p_salario<=1500 
		then return 'Tipo impositivo aplicado 12%.';
	else 
		return 'Tipo impositivo aplicado 15%.';
	end if;
end;
&&
delimiter ;
select ej24_cual_tipo_impositivo_corresponde (:p_salario);
select nombre,  -- este select no me funciona porque no he calculado, como en el ej27, el tipo impositivo como un numero. esto está hecho así en las correcciones de david.
-- mi ejercicio está bien pero no devuelve un valor numérico, sino un varchar.
salario, 
concat (ej24_cual_tipo_impositivo_corresponde(salario)*100, ' %') "tipo impositivo", 
salario*ej24_cual_tipo_impositivo_corresponde(salario) "retencion", 
salario- salario*ej24_cual_tipo_impositivo_corresponde(salario) "salario neto"
from empleados;

-- 25. Haz una función equivalente a la anterior utilizando la sentencia CASE.
delimiter ;
drop function if exists ej25_cual_tipo_impositivo_corresponde;
delimiter &&
create function ej25_cual_tipo_impositivo_corresponde (p_salario smallint unsigned)
RETURNS varchar (150)
DETERMINISTIC
BEGIN
	case 
		when p_salario<1200 
			then return 'Tipo impositivo aplicado 5%.';
		when p_salario<=1300 
			then return 'Tipo impositivo aplicado 8%.';
		when p_salario<=1400 
			then return 'Tipo impositivo aplicado 10%.';
		when p_salario>=1401 and p_salario<=1500 
			then return 'Tipo impositivo aplicado 12%.';
		else 
			return 'Tipo impositivo aplicado 15%.';
	end case;
end;
&&
delimiter ;
select ej25_cual_tipo_impositivo_corresponde (:p_salario);

-- 26. Modifica la función anterior para que en lugar de tomar el salario del empleado se le pase el código del empleado. Deberás buscar el salario en la tabla empleados (base de datos empresa)
delimiter ;
drop function if exists ej26_cual_tipo_impositivo_corresponde_segun_cod_empleado;
delimiter &&
create function ej26_cual_tipo_impositivo_corresponde_segun_cod_empleado (p_cod_empleado smallint unsigned)
RETURNS varchar (150)
DETERMINISTIC
BEGIN -- ver ejercicio de david, que usa la funcion del ejercicio 24
	declare v_salario SMALLINT unsigned;
	select salario into v_salario from empleados
		where cod_empleado=p_cod_empleado;
	case 
		when v_salario<1200 
			then return 'Tipo impositivo aplicado 5%.';
		when v_salario<=1300 
			then return 'Tipo impositivo aplicado 8%.';
		when v_salario<=1400 
			then return 'Tipo impositivo aplicado 10%.';
		when v_salario>=1401 and v_salario<=1500 
			then return 'Tipo impositivo aplicado 12%.';
		else 
			return 'Tipo impositivo aplicado 15%.';
	end case;
end;
&&
delimiter ;
select ej26_cual_tipo_impositivo_corresponde_segun_cod_empleado (:p_cod_empleado);

-- 27. Crea una función al que se le pase el cod_empleado y que calcule el salario neto después de quitarle el tipo impositivo que le corresponde.
delimiter ;
drop function if exists ej27_salario_neto;
delimiter &&
create function ej27_salario_neto (p_cod_empleado smallint unsigned) 
RETURNS double
not DETERMINISTIC reads sql data
BEGIN  --mirar los ejercicios de david, que lo ha resuelto usando funciones anteriores
	declare v_salario double; --se declara como double para que acepte decimales
	select salario into v_salario from empleados
		where cod_empleado=p_cod_empleado;
	case 
		when v_salario<1200 
			then return v_salario*0.95;
		when v_salario<=1300 
			then return v_salario*0.92;
		when v_salario<=1400 
			then return v_salario*0.9;
		when v_salario>=1401 and v_salario<=1500 
			then return v_salario*0.88;
		else 
			return v_salario*0.85;
	end case;
end;
&&
delimiter ;
select ej27_salario_neto (:p_cod_empleado) 'El salario neto es' ;


-- 28. Escribe un procedimiento al que le pases un número como parámetro y escriba todos los números comprendidos entre 1 y número pasado
delimiter ;
drop PROCEDURE if exists ej28_escribir_numeros_mediantes;
delimiter &&
create PROCEDURE ej28_escribir_numeros_mediantes (p_num smallint unsigned)
DETERMINISTIC 
BEGIN
	declare v_num smallint unsigned default 0;
	declare v_resultado varchar(300) default ''; --hay que pòner esto sino devuelve todo el rato null porque es null desde el principio
	while v_num < p_num Do
		set v_num=v_num +1;
		set v_resultado = concat (v_resultado, ' ', v_num);
		
	end while;
	select v_resultado;
end;
&&
delimiter ;
call ej28_escribir_numeros_mediantes (:p_num);

-- 29. Haz lo mismo que el ejercicio anterior pero deberá ser una cuenta atrás.
delimiter ;
drop PROCEDURE if exists ej29_escribir_numeros_mediantes_delreves;
delimiter &&
create PROCEDURE ej29_escribir_numeros_mediantes_delreves (p_num smallint unsigned)
DETERMINISTIC 
BEGIN
	declare v_num smallint unsigned default 0;
	declare v_resultado varchar(300) default ''; --hay que pòner esto sino devuelve todo el rato null porque es null desde el principio
	while v_num < p_num Do
		set v_num=v_num +1;
		set v_resultado = concat (v_num, ' ', v_resultado);
		
	end while;
	select concat (v_resultado, '0'); --reverse no funciona porque a números>10 le da la vuelta tb
	--le meto el concat vresultado 0 para meterle un 0 al final aunque el ejercicio sea hasta el 1
end;
&&
delimiter ;
call ej29_escribir_numeros_mediantes_delreves (:p_num);

-- 30. Haz un procedimiento que tome dos parámetros el inicio y el fin. Deberá mostrar todos los números pares comprendidos entre los dos números.
delimiter ;
drop procedure if exists ej30_numeros_pares_comprendidos_version_mia;
delimiter &&
create PROCEDURE ej30_numeros_pares_comprendidos_version_mia(p_num1 smallint, p_num2 smallint) DETERMINISTIC
begin
	declare v_num1 smallint default p_num1;
	declare v_num2 smallint default p_num2;
	-- if v_num2 < v_num1 THEN	
	-- 	set v_num1= p_num2;
	-- 	set v_num= p_num1;
	-- end if;
	declare v_resultado varchar(300) default ''; --hay que pòner esto sino devuelve todo el rato null porque es null desde el principio
	while v_num1 <= v_num2 or v_num2 <= v_num1 Do
		if v_num1 <= v_num2 then
			set v_num1=v_num1 +1;
			if mod(v_num1,2)= 0 then
				set v_resultado = concat (v_resultado, ' ', v_num1);
			end if;
		else 
			set v_num2= v_num2 +1;
			if mod(v_num2,2)= 0 then
				set v_resultado = concat (v_resultado, ' ', v_num2);
			end if;
		end if;
	end while;
	select (v_resultado);
end;
&&
DELIMITER ;
call ej30_numeros_pares_comprendidos_version_mia(:p_num1, :p_num2);

--- otra version que no es la mia
delimiter ;
drop procedure if exists ej30_numeros_pares_comprendidos_version_otra;
delimiter &&
create PROCEDURE ej30_numeros_pares_comprendidos_version_otra(p_num1 smallint, p_num2 smallint) DETERMINISTIC
begin
	declare v_num1 smallint default p_num1;
	declare v_num2 smallint default p_num2;
	-- se puede poner esto tambien, sin usar el if de dos lineas más abajo:
		-- 	declare v_cont1 int default least(p_num1,p_num2);   --coge el número más pequeño
		-- declare v_cont2 int default greatest(p_num1,p_num2);    --coge el número más grande
	declare v_resultado varchar(300) default ''; --hay que pòner esto sino devuelve todo el rato null porque es null desde el principio
	if v_num2 < v_num1 THEN	
		set v_num1= p_num2;
		set v_num2= p_num1; -- metiendo este if ya le estoy dando la vuelta por si el numero segundo introducido es menor que el primero. 
	end if;
	
	while v_num1 <= v_num2 do
		if mod(v_num1, 2)=0 then 
			set v_resultado = concat (v_resultado, ' ', v_num1);
		end if; -- comprobamos que es par y lo escribe. si no es par, sigue con la funcion de abajo, contando, pero simplemente no lo escribe
		set v_num1= v_num1 + 1;
	end while;
	select (v_resultado);
end;
&&
DELIMITER ;
call ej30_numeros_pares_comprendidos_version_otra(:p_num1, :p_num2);


-- 31. Haz un procedimiento que tome tres parámetros, el valor incial, el final y el incremento. Deberá escribir en pantalla todos los números comprendidos entre el inicial y final pero saltando según el incremento especificado.
delimiter ;
drop PROCEDURE if exists ej31_tres_numeros_incremento;
delimiter $$
create procedure ej31_tres_numeros_incremento(p_num1 SMALLINT, p_num2 smallint, p_num3 SMALLINT) DETERMINISTIC
BEGIN
	declare v_num1 smallint default p_num1;
	declare v_num2 smallint default p_num2;
	declare v_num3 smallint default p_num3;
	declare v_resultado varchar(300) default '';
	if v_num2 < v_num1 THEN	
		set v_num1= p_num2;
		set v_num2= p_num1;
	end if; --para darle la vuelta por si el num2 es más pequeño que el primero
	while v_num1 <= v_num2 do	
		set v_resultado = concat (v_resultado, ' ', v_num1);
		set v_num1= v_num1 + v_num3;
	end while;
		
	select (v_resultado);
end;
%%
delimiter ;
call ej31_tres_numeros_incremento(:p_num1, :p_num2, :p_num3);


-- 32. Crea un procedimiento que tome un valor entero como parámetro, deberá escribir en pantalla todos los divisores del número.
delimiter ;
drop procedure if exists ej32_num_y_divisores;
delimiter %%
create PROCEDURE ej32_num_y_divisores (p_num1 smallint) DETERMINISTIC
begin 
	declare v_num1 SMALLINT default p_num1;
	declare v_resultado varchar(300) default '';
	
	repeat
		if mod(p_num1,v_num1)=0 then
			set v_resultado = concat (v_resultado, ' ', v_num1);
		end if;
		set v_num1= v_num1 - 1;
		until v_num1= 0
	end repeat;
	select (v_resultado);
end;
%%
delimiter ;
call ej32_num_y_divisores(:p_num1);

-- 33. Crea una función que tome un parámetro entero, la función deberá sumar todos los números comprendidos entre 1 y el número. Por ejemplo, si el número es 7, se deberá sumar 1+2+3+4+5+6+7=28 y por tanto devolverá 28.
DELIMITER ;
drop function if exists ej33_suma_numero_y_enteros;
delimiter &&
create FUNCTION ej33_suma_numero_y_enteros (p_num SMALLINT unsigned)
returns SMALLINT unsigned
DETERMINISTIC
BEGIN
	declare v_num SMALLINT unsigned default 0;
	declare v_resultado smallint unsigned default 0;

	repeat 
		set v_num = v_num+1;
		set v_resultado = v_resultado + v_num;
		until v_num=p_num
	end repeat;
	return v_resultado;
end;
&&
delimiter ;
select ej33_suma_numero_y_enteros(:p_num);


-- 34. Crea una función que calcule el factorial de un número
delimiter ;
drop function if exists ej34_factorial_de_numero;
delimiter %%
create function ej34_factorial_de_numero (p_num int unsigned)
returns bigint
DETERMINISTIC
begin
	declare v_num int unsigned default 0;
	declare v_resultado bigint unsigned default 1;
	if p_num = 0 then
		return 1;
	else REPEAT
		set v_num= v_num + 1;
		set v_resultado = v_resultado * (v_num);
		until v_num=p_num 
	end repeat;
	end if;
	return v_resultado;
end;
%%
delimiter ;
select ej34_factorial_de_numero(:p_num);
-- 35. Crear una función que tome dos parámetros la base y el exponente, deberá devolver la potencia, baseexponente.
delimiter ;
drop function if exists ej35_base_y_exponente;
delimiter &&
create function ej35_base_y_exponente (p_base smallint, p_exponente smallint)
returns bigint
DETERMINISTIC
BEGIN
	declare v_resultado bigint default 0;
	set v_resultado = power(p_base,p_exponente);
	return v_resultado;
end;
&&
delimiter ;
select ej35_base_y_exponente(:p_base, :p_exponente);

----------------------

delimiter ;
drop function if exists ej35_base_y_exponente_v2;
delimiter &&
create function ej35_base_y_exponente_v2 (p_base smallint, p_exponente smallint)
returns bigint
DETERMINISTIC
BEGIN
	declare v_exponente int unsigned default 0;
	declare v_resultado bigint unsigned default 1;
	REPEAT
		set v_exponente= v_exponente + 1;
		set v_resultado = v_resultado * (p_base);
		until v_exponente=p_exponente
	end repeat;
	return v_resultado;
	
end;
&&
delimiter ;
select ej35_base_y_exponente_v2(:p_base, :p_exponente);

-- 36. Crea una función que diga si un número es o no primo.
delimiter ;
drop function ej36_num_primo_o_no;
delimiter %%
create function ej36_num_primo_o_no (p_number int unsigned)
returns boolean
DETERMINISTIC
BEGIn
	declare v_number SMALLINT default 0;
	declare v_contador_divisores smallint default 0;
	
	repeat
		if mod(p_number,v_number)=0 then
			set v_contador_divisores = v_contador_divisores +1;
			if v_contador_divisores >1 then 
				return false;
			end if;
		end if;
		set v_number= v_number + 1;
		until v_number=p_number
	end repeat;
	return true;
end;
%%
delimiter;
select ej36_num_primo_o_no(:p_num);

--más ejercicios

-- Hacer los siguientes subprogramas en MySQL:

-- 1. Crea un procedimiento sin argumentos que muestre en pantalla el número de matrículas que tenemos en la base de datos.
delimiter ;
drop procedure if exists ej1_num_matriculas_en_DB;
delimiter %%
create procedure ej1_num_matriculas_en_DB ()
not DETERMINISTIC
BEGIN
    declare v_resultado int unsigned default 0;
    select count(id_alumno) into v_resultado from alumno_se_matricula_asignatura;
    select concat ('Hay un total de ', v_resultado, ' matrículas.');
end;
%%
delimiter ;
call ej1_num_matriculas_en_DB();

-- 3. Crea un procedimiento al que le pases el código de una asignatura y muestre en pantalla el texto ‘La asignatura tal es obligatoria’ o ‘La asignatura cual es optativa’ según corresponda. Utiliza la función anterior
delimiter ;
drop procedure if exists ej3_asignatura_obligatoria_u_optativa_segun_codigo;
delimiter $$
create procedure ej3_asignatura_obligatoria_u_optativa_segun_codigo (p_cod_asignatura int unsigned)
not DETERMINISTIC
BEGIN
    declare v_nombre_asignatura varchar(100) default '';
    declare v_tipo enum('básica', 'obligatoria', 'optativa');

    select nombre, tipo into v_nombre_asignatura, v_tipo 
        from asignatura where id=p_cod_asignatura;
    select concat('La asignatura ', v_nombre_asignatura, ' es ', ej2_de_enum_a_varchar(v_tipo));
END;
%%
delimiter ;
call ej3_asignatura_obligatoria_u_optativa_segun_codigo(:p_cod_asignatura);

-- 6. Crea un procedimiento que se le pase el código de la asignatura y que actualice el número de créditos según la siguiente tabla:
--     a. Si es obligatoria se le sumarán dos créditos
--     b. Si es optativa se dejará igual
--     c. Si es básica se incrementará en 3
delimiter ;
drop procedure if exists ej6_actualizar_creditos_segun_tipo;
delimiter %%
create procedure ej6_actualizar_creditos_segun_tipo (p_cod_asig int unsigned)
not DETERMINISTIC
BEGIN  
    declare v_creditos float default 0;
    declare v_nombre_asignatura varchar(100) default '';
    declare v_tipo enum('básica', 'obligatoria', 'optativa');

    select nombre, tipo, creditos into v_nombre_asignatura, v_tipo, v_creditos 
        from asignatura 
        where p_cod_asig=id;

    IF ej2_de_enum_a_varchar(v_tipo) collate utf8mb4_0900_ai_ci = 'obligatoria' collate utf8mb4_0900_ai_ci then
        set v_creditos = v_creditos +2;
        select 'Los créditos de la asignatura se han incrementado en 2';
    elseif ej2_de_enum_a_varchar(v_tipo) collate utf8mb4_0900_ai_ci= 'básica' collate utf8mb4_0900_ai_ci then
    --si no pongo lo del collate me da error. así que lo corregimos así. pero que si solo pongo elseif v_tipo = basica, funciona perfectamente el call de abajo 
        set v_creditos = v_creditos + 3;
        select 'Los créditos de la asignatura se han incrementado en 3.';
    else select 'Los créditos de la asignatura se mantienen igual.';
    end if;
    update asignatura set creditos = v_creditos
        where id=p_cod_asig;
end;
%%
delimiter ;
start transaction;
call ej6_actualizar_creditos_segun_tipo(:p_cod_asig);
rollback;


-- 7. Crea un procedimiento que inserte una asignatura nueva. Pásale como parámetros al procedimiento todos los valores necesarios para insertar un fila en la tabla
delimiter ;
drop procedure if exists ej7_añadir_nueva_asignatura;
delimiter $$
create procedure ej7_añadir_nueva_asignatura (
    p_nombre varchar(100),
    p_creditos float,
    p_tipo enum ('básica', 'optativa', 'obligatoria'),
    p_curso tinyint,
    p_cuatrimestre tinyint,
    p_id_prof int,
    p_id_grado int)
not deterministic
BEGIN
    insert asignatura 
        set
        nombre = p_nombre,
        creditos = p_creditos,
        tipo = p_tipo,
        curso = p_curso,
        cuatrimestre = p_cuatrimestre,
        id_profesor =p_id_prof,
        id_grado = p_id_grado;
end;
$$
delimiter ;
call ej7_añadir_nueva_asignatura(:p_nombre, :p_creditos, :p_tipo, :p_curso, :p_cuatrimestre, :p_id_prof, :p_id_grado);

-- Con la base de datos jardinería hacer los siguientes procedimientos y/o funciones:
--VER PROCEDIMIENTOS-JARDINERIA-BIS para ver otras formas de hacer estos subprogramas.

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

