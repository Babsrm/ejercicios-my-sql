-- ver version con while abajo
drop procedure if exists prueba_cursor_productos;
delimiter &&
create procedure prueba_cursor_productos() not DETERMINISTIC
BEGIN
    --variable de control para el bucle
    declare v_hayDatos boolean default true;
    --variables para recoger los datos. tienen que tener las mismas propiedades que en la tabla
    declare v_nombre varchar(100);
    declare v_precio double;

    --declaracion del cursor
    declare c_productos cursor FOR
        select nombre, precio from producto;

    --declaracion del manejador de not found, para que no sea bucle infinito
    declare continue handler for not FOUND
        set v_hayDatos = false;
        --si no lo encuentra, la variable se vuelve false y para de ejecutar el while con el fetch.

    --se abre el cursor para gestionar los datos devueltos
    open c_productos;

    --primer FETCH
     fetch c_productos into v_nombre, v_precio;

    --se crea el bucle para iterar entre los resultados
    while v_hayDatos= true do -- se puede quitar el =true que es lo mismo
        -- operamos con los datos escribiéndolos en pantalla
        select concat('El producto ', v_nombre, ' vale ', v_precio, '.');
        
        --extraemos los datos de la fila activa a las variables
        fetch c_productos into v_nombre, v_precio;
        
    end while;
    
    --se cierra el cursos para liberar recursos
    close c_productos;
end;
//
delimiter;
call prueba_cursor_productos(); --solo sale un resultado por culpa de vscode. ver en workbench mejor


--------------------------
drop procedure if exists prueba_cursor_productos_while;
delimiter &&
create procedure prueba_cursor_productos_while() not DETERMINISTIC
BEGIN
    --variable de control para el bucle
    declare v_hayDatos boolean default true;
    --variables para recoger los datos. tienen que tener las mismas propiedades que en la tabla
    declare v_nombre varchar(100);
    declare v_precio double;

    --declaracion del cursor
    declare c_productos cursor FOR
        select nombre, precio from producto;

    --declaracion del manejador de not found, para que no sea bucle infinito
    declare continue handler for not FOUND
        set v_hayDatos = false;
        --si no lo encuentra, la variable se vuelve false y para de ejecutar el while con el fetch.

    --se abre el cursor para gestionar los datos devueltos
    open c_productos;

    --se crea el bucle para iterar entre los resultados
    while v_hayDatos= true do -- se puede quitar el =true que es lo mismo
        --extraemos los datos de la fila activa a las variables
        fetch c_productos into v_nombre, v_precio;
        if v_hayDatos = true then
        -- operamos con los datos escribiéndolos en pantalla
             select concat('El producto ', v_nombre, ' vale ', v_precio, '.');
        end if;
    end while;
    
    --se cierra el cursos para liberar recursos
    close c_productos;
end;
//
delimiter;
call prueba_cursor_productos_while(); --solo sale un resultado por culpa de vscode. ver en workbench mejor