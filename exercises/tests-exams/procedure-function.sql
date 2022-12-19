-- Active: 1667910552053@@127.0.0.1@3306@empresa
--Ejercicio 1, base de datos: empresa.
use empresa;
--1.
delimiter ;
drop procedure if exists salario_medio;
delimiter //
create procedure salario_medio ()
not DETERMINISTIC
begin
    declare v_sal_medio smallint default 0;

    select avg(salario) into v_sal_medio
    from empleados;

    select CONCAT_WS(' ', 'El salario medio es', v_sal_medio, '€.') solucion_salario_medio;
end;
//
DELIMITER ;
call salario_medio();

--2.
delimiter ;
drop function if exists texto_tipodir;
delimiter //
create Function texto_tipodir (p_tipo enum('P', 'F'))
returns varchar(50)
not deterministic reads sql data
begin
    if p_tipo='P' then
        return 'Propiedad';
    elseif p_tipo='F' then
        return 'En funciones';
    end if;
end;
//
delimiter ;
select nombre, tipo_dir, texto_tipodir(tipo_dir)
    from departamentos;

--3.
delimiter;
drop procedure if exists incrementa_sueldo;
delimiter //
create procedure incrementa_sueldo(p_cod_empleado smallint, p_comision smallint)
not DETERMINISTIC
begin
    declare v_comision smallint default 0;

    SELECT comision into v_comision
        from empleados 
        where cod_empleado=p_cod_empleado;
    
    if v_comision <> 0 then
        set v_comision= v_comision + p_comision;
    else
        set v_comision= p_comision;
    end if;

    update empleados
        set comision = v_comision
        where cod_empleado=p_cod_empleado;
end;
//
delimiter ;
call incrementa_sueldo(:p_cod_empleado, :p_comision);
select comision, cod_empleado from empleados;