-- Hacer los siguientes subprogramas en MySQL:
-- 2. Crea un función que tenga como argumento el tipo de la asignatura que es un tipo ENUM('básica', 'obligatoria', 'optativa') deberá devolver una cadena con el texto Básica, Obligatoria u Optativa según corresponda.
delimiter ;
drop function if exists ej2_de_enum_a_varchar;
delimiter %%
create function ej2_de_enum_a_varchar (p_valor enum('básica', 'obligatoria', 'optativa'))
returns varchar (15)
DETERMINISTIC
begin
    if p_valor='básica' then
        return 'Básica' COLLATE utf8mb4_0900_ai_ci;
    elseif p_valor= 'obligatoria' then
        return 'Obligatoria' collate utf8mb4_0900_ai_ci;
    else return 'Optativa' collate utf8mb4_0900_ai_ci;
    end if;
end;
&&
delimiter ;
select ej2_de_enum_a_varchar(:p_valor); --valor debe ir entre comillas para comprobarlo
select ej2_de_enum_a_varchar(tipo), nombre from asignatura;

-- 4. Crea una función que dado un id de profesor devuelva cuantos créditos imparte.
delimiter ;
drop function if exists ej4_creditos_imparte_prof_segun_id;
delimiter %%
create function ej4_creditos_imparte_prof_segun_id (p_id_prof int unsigned)
returns float
not DETERMINISTIC reads sql data
begin
    declare v_resultado int unsigned default 0;
    select sum(creditos) into v_resultado from asignatura
        where id_profesor=p_id_prof;
    return v_resultado;
end;
%%
delimiter ;
select ej4_creditos_imparte_prof_segun_id(:p_id_prof);
select nombre, apellido1, apellido2, ej4_creditos_imparte_prof_segun_id (pr.id_profesor)
    from persona p join profesor pr on p.id=pr.id_profesor;

-- 5. Crea una función que tenga como parámetro el código del grado y devuelva el número de créditos totales que contiene.
delimiter ;
drop function if exists ej5_cuantos_creditos_tiene_grado;
delimiter $$
create function ej5_cuantos_creditos_tiene_grado (p_cod_grado int unsigned)
returns float
not deterministic reads sql data
begin
    declare v_resultado float default 0;

    select sum(creditos) into v_resultado 
        from asignatura where p_cod_grado = id_grado;
    return v_resultado;
end;
$$
delimiter ;
select ej5_cuantos_creditos_tiene_grado (:p_cod_grado);
select nombre, ej5_cuantos_creditos_tiene_grado(id) from grado;

-- 8. Haz una función que se le pase un entero representando el número del mes. La función devolverá el número de días que tiene dicho mes.
delimiter ;
drop function if exists ej8_cuantos_dias_tiene_mes;
delimiter %%
create function ej8_cuantos_dias_tiene_mes (p_num tinyint unsigned)
returns varchar(50)
DETERMINISTIC
BEGIN  
    if p_num not BETWEEN 1 and 12 THEN
        return 'Introduce un número correcto de mes.';
    end if;
    if p_num in (1,3,5,7,8,10,12) THEN
        return 'El mes tiene 31 días';
    elseif p_num= 2 THEN
        return 'El mes tiene 28 días; 29 en año bisiesto';
    else
        return "El mes tiene 30 días.";
    end if;
end;
%%
delimiter ;
select ej8_cuantos_dias_tiene_mes (:p_num);
-------------------------- version 2 que devuelve numeros
create function ej8_cuantos_dias_tiene_mes_v2 (p_num tinyint unsigned)
returns tinyint unsigned
DETERMINISTIC
BEGIN  
    if p_num not BETWEEN 1 and 12 THEN
        return null;
    end if;
    if p_num in (1,3,5,7,8,10,12) THEN
        return 31;
    elseif p_num= 2 THEN
        return 28;
    else
        return 30;
    end if;
end;
%%
delimiter ;
select concat('El mes ', :p_num, ' tiene ',ej8_cuantos_dias_tiene_mes_v2(:p_num), ' días.' );

-- 9. Crea una función como la del anterior ejercicio pero que además tome como parámetro el año de la fecha, si el año es bisiesto devolverá 29 en el mes de febrero. Ayúdate de la función bisiesto que hicimos en clase
delimiter %%
create function ano_bisiesto_o_no (p_num1 int unsigned)
returns boolean
DETERMINISTIC
BEGIN
    -- if p_num%4 <>0
	if mod(p_num1,4)<>0 then
		return false;
	elseif mod(p_num1,400)=0 or mod(p_num1,100)<>0 then
		return true;
	else 
		return false;
	end if;
end;
%%
delimiter ;
drop function if exists ej9_cuantos_dias_tiene_mes_con_ano_bisiesto;
delimiter $$
create function ej9_cuantos_dias_tiene_mes_con_ano_bisiesto (p_mes tinyint unsigned, p_ano int unsigned)
returns varchar (100)
DETERMINISTIC
BEGIN
    if  p_mes not BETWEEN 1 and 12 THEN
        return 'Introduce un número correcto de mes.';
    end if;
    if p_mes in (1,3,5,7,8,10,12) THEN
        return 'El mes tiene 31 días';
    elseif p_mes= 2 THEN
        if ano_bisiesto_o_no(p_ano) = true THEN
        return 'El mes tiene 29 días por ser año bisiesto';
        else return 'El mes tiene 28 días.';
        end if;
    else
        return 'El mes tiene 30 días.';
    end if;
end;
$$
delimiter;
select ej9_cuantos_dias_tiene_mes_con_ano_bisiesto(:p_mes, :p_ano);
------- version 2, que devuelve numeros
create function ej9_cuantos_dias_tiene_mes_con_ano_bisiesto_v2 (p_mes tinyint unsigned, p_ano int unsigned)
returns tinyint unsigned
DETERMINISTIC
BEGIN
    if  p_mes not BETWEEN 1 and 12 THEN
        return null;
    end if;
    if p_mes in (1,3,5,7,8,10,12) THEN
        return 31;
    elseif p_mes= 2 THEN
        if ano_bisiesto_o_no(p_ano) = true THEN
        return 29;
        else return 28;
        end if;
    else
        return 30;
    end if;
end;
$$
delimiter;
select ej9_cuantos_dias_tiene_mes_con_ano_bisiesto_v2(:p_mes, :p_ano);

-- 10. Haz una función que se le pasen dos códigos de asignatura como parámetro p_asig_inicio y p_asig_fin y devuelva la suma de créditos de las asignaturas comprendidas entre los dos códigos. Deberás utilizar un bucle While para hacerlo.
delimiter ;
drop function if exists ej10_suma_creditos_entre_dos_cod_asignatura;
delimiter $$
create FUNCTION ej10_suma_creditos_entre_dos_cod_asignatura (p_id_asig_inicio int unsigned, p_id_asig_fin int unsigned)
returns float
not deterministic reads sql data
begin
    declare v_id_inicio int unsigned default p_id_asig_inicio;
    declare v_id_fin int unsigned default p_id_asig_fin;
    declare v_suma_creditos float default 0;
    declare v_creditos float default 0;

    if v_id_inicio > v_id_fin THEN
        set v_id_inicio = p_id_asig_fin;
        set v_id_fin = p_id_asig_inicio;
        --este if es para cambiar el orden de los códigos por si el segundo es menos que el primero
    end if;

    REPEAT
        select creditos into v_creditos from asignatura
            where id=v_id_inicio;
        set v_suma_creditos = v_suma_creditos + v_creditos;
        set v_id_inicio = v_id_inicio + 1;

        until v_id_inicio = v_id_fin
    end repeat;
    return v_suma_creditos;
end;
$$
delimiter ;
select ej10_suma_creditos_entre_dos_cod_asignatura (:p_id_asig_inicio, :p_id_asig_fin);


-- 11. Haz una función a la que se le pase un número, deberá devolver verdadero cuando en el número sea capicúa, es decir se lea igual de izquierda a derecha que de derecha a izquierda.
delimiter ;
drop function if exists ej11_v_o_f_segun_capicua;
delimiter %%
create function ej11_v_o_f_segun_capicua (p_num int unsigned)
returns boolean 
DETERMINISTIC
BEGIN 
    if reverse(p_num) = p_num THEN
        return true;
    else 
        return false;
    end if;
end;
%%
delimiter ;
select ej11_v_o_f_segun_capicua (:p_num);
-

-- 12. Crea una función que calcule el máximo común divisor de dos números pasados como parámetro mediante el algoritmo de Euclides. En este caso se dividen un número por otro; si sólo

-- son dos números el mayor por el menor y si son varios escogeremos primero los dos menores y dividiremos igualmente el mayor de ellos por el menor. Si la división no es exacta, se divide el divisor anterior por el resto obtenido, realizando esta misma operación hasta que obtengamos un resto igual a 0. EL mcd será el último divisor empleado
delimiter ;
drop function if exists ej12_max_comun_divisor;
delimiter &&
create function ej12_max_comun_divisor (p_num1 int unsigned, p_num2 int unsigned)
returns int unsigned
DETERMINISTIC
BEGIN
    declare v_dividendo int unsigned default greatest (p_num1, p_num2); -- elijo el más grande de los dos
    declare v_divisor int unsigned default least (p_num1, p_num2); --elijo el más pequeño de los dos
    declare v_resto int unsigned default 1; --es necesaio que el default sea distinto de  cero porque le estamos diciendo que en repeat se repita hasta 0 entonces así lo forzamos a que entre, de la otra manera no entraría en el bucle

    
    repeat 
        set v_resto = mod(v_dividendo, v_divisor);
        set v_dividendo = v_divisor;
        set v_divisor = v_resto;
    until v_resto = 0
    end repeat;
    return v_dividendo;
end;
&&
delimiter ;
select ej12_max_comun_divisor(:p_num1, :p_num2);

-- 13. Haz una función que calcule el mínimo común múltiplo de dos números mediante el algoritmo de Euclides. Se calcula de la siguiente manera: Mcm(a,b)=(a*b)/mcd(a,b);
delimiter ;
drop function if exists ej13_minimo_comun_multiplo;
delimiter &&
create function ej13_minimo_comun_multiplo(p_num1 int unsigned, p_num2 int unsigned)
returns bigint unsigned
deterministic
BEGIN
    declare v_resultado bigint unsigned;

    set v_resultado = (p_num1*p_num2) / ej12_max_comun_divisor(p_num1, p_num2);
    return v_resultado;
end;
&&
delimiter ;
select ej13_minimo_comun_multiplo (:p_num1, :p_num2);


