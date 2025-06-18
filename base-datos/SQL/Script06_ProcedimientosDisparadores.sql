USE curso_sql;

SHOW TABLES;

CREATE TABLE suscripciones (
  suscripcion_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  suscripcion VARCHAR(30) NOT NULL,
  costo DECIMAL(5,2) NOT NULL
);

INSERT INTO suscripciones VALUES
  (0, 'Bronce', 199.99),
  (0, 'Plata', 299.99),
  (0, 'Oro', 399.99);

CREATE TABLE clientes (
  cliente_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(30) NOT NULL,
  correo VARCHAR(50) UNIQUE
);

CREATE TABLE tarjetas (
  tarjeta_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  cliente INT UNSIGNED,
  tarjeta BLOB,
  FOREIGN KEY (cliente)
    REFERENCES clientes(cliente_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);

CREATE TABLE servicios(
  servicio_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  cliente INT UNSIGNED,
  tarjeta INT UNSIGNED,
  suscripcion INT UNSIGNED,
  FOREIGN KEY(cliente)
    REFERENCES clientes(cliente_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  FOREIGN KEY(tarjeta)
    REFERENCES tarjetas(tarjeta_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  FOREIGN KEY(suscripcion)
    REFERENCES suscripciones(suscripcion_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);

CREATE TABLE actividad_clientes(
  ac_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  cliente INT UNSIGNED,
  fecha DATETIME,
  FOREIGN KEY (cliente)
    REFERENCES clientes(cliente_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);

SELECT * FROM suscripciones;
SELECT * FROM clientes;
SELECT * FROM tarjetas;
SELECT * FROM servicios;
SELECT * FROM actividad_clientes;

-- definiendo el procedimiento almacenado

DELIMITER //

CREATE PROCEDURE sp_obtener_suscripciones()
  
  BEGIN
    
    SELECT * FROM suscripciones;
    
  END //
  
DELIMITER ;

-- llamando al procedimiento almacenado
CALL sp_obtener_suscripciones();

-- mostrando los procedimientos almacenados disponibles
SHOW PROCEDURE STATUS WHERE db = 'jon';

-- eliminando el procedimiento almacenado
DROP PROCEDURE sp_obtener_suscripciones; 




/* recalcar que la sintaxis para declarar procedimientos almacenados 
   varia dependiendo del sgbd
*/
DELIMITER //

-- aquí nuestro sp recibe parametros
CREATE PROCEDURE sp_asignar_servicio(
  /* la nomenclatura en mysql es la siguiente, primero va el tipo de
     parametro que será, si es de entrada o salida será IN o OUT respectivamente, seguido del nombre que tomara el parametro y finalmente
     el tipo de dato que tendra dicho parametro ya sea de entrada o salida.
     Recalcar qué si estos parametros sirven para manipular las tablas, seá 
     crear, editar, eliminar registros estos deben ser del mismo tipo que 
     su campo al que hagan alución. 
  */
  IN i_suscripcion INT UNSIGNED,
  IN i_nombre VARCHAR(30),
  IN i_correo VARCHAR(50),
  IN i_tarjeta VARCHAR(16),
  OUT o_respuesta VARCHAR(50)
)
  -- comienza la instrucción
  BEGIN
    -- creación de variables
    DECLARE existe_correo INT DEFAULT 0;
    DECLARE cliente_id INT DEFAULT 0;
    DECLARE tarjeta_id INT DEFAULT 0;
    -- aquí creamos una transacción
    START TRANSACTION;
      -- ASIGNAMOS VALOR A LA VARIABLE
        -- aquí lo que hacemos es traer el recuento de usuarios cuyo correo
        -- sea igual a el parametro i_correo para luego ese recuento 
        -- introducirlo en la variable existe_correo
      SELECT COUNT(*) INTO existe_correo
        FROM clientes
        WHERE correo = i_correo;

      -- CREAMOS CONDICIONAL
        -- si la variable existe_correo es distinto de 0 entonces
        -- introducimos en el parametro de salida o_respuesta un mensaje 
      IF existe_correo <> 0 THEN
        
        SELECT 'Tu correo ya ha sido registrado' INTO o_respuesta;
      
        -- en caso existe_correo seá 0 entonces ejecutamos las consultas
        -- siguientes
      ELSE 
        -- insertamos datos en la tabla de clientes, estos datos vendran
        -- de los parametros de entrada
        INSERT INTO clientes VALUES (0, i_nombre, i_correo);
        -- posteriormente obtenemos el ultimo id insertado y lo guardamos
        -- en la variable cliente_id
        SELECT LAST_INSERT_ID() INTO cliente_id; 
      
        INSERT INTO tarjetas
          VALUES (0, cliente_id, AES_ENCRYPT(i_tarjeta, cliente_id));
        SELECT LAST_INSERT_ID() INTO tarjeta_id;
      
        INSERT INTO servicios VALUES (0, cliente_id, tarjeta_id, i_suscripcion);
      
        -- cuando todo se haya realizado correctamente guardamos un mensaje 
        -- en la variable o_respuesta
        SELECT 'Servicio asignado con éxito' INTO o_respuesta;
      
      END IF;
    -- indicamos que la transacción fue correcta
    COMMIT;
    
  -- finaliza la instrucción 
  END //
  
DELIMITER ;

SELECT * FROM suscripciones;
SELECT * FROM clientes;
SELECT * FROM tarjetas;
SELECT * FROM servicios;
SELECT * FROM actividad_clientes;


-- llamamos al procedimiento almacenado y le pasamos los parametros de entrada y salida
CALL sp_asignar_servicio(4, 'krahuer', 'krahuer@gmail.com', '1234567890123490', @res);
SELECT @res;





-- EJEMPLO 1

-- lo primero que tenemos que hacer es indicar un delimitador para nuestro sp(que indicara donde empieza y donde acaba la instrucción)
-- ya que cómo sabemos cada linea de código sql termina con ";", por lo tanto
-- para indicarle a sql que nuestro sp tendra más de 1 linea de código no tome
-- como delimitador el ";", si no qué tome otro distinto


DELIMITER %%

  CREATE PROCEDURE sp_test(
    IN id_cl INT,
    OUT ou_message VARCHAR(60)
  )
    BEGIN
    -- recalcar tambien que dentro del BEGIN podemos declarar lógica cómo : 
    -- coindicionales, asignación de variables, etc
      SELECT * FROM clientes WHERE  cliente_id = id_cl;
      SELECT 'todo bien' INTO ou_message;
    END %%

  

DELIMITER ;

-- fuera de los procedimientos almacenados no podemos usar lógica imperativa cómo si
-- podemos hacerlo dentro de los mismos, pero si podemos crear variables
-- de esta forma => @nombre_variable, para nuestro ejemplo la variable @response será 
-- nuestro parametro de salida que obtendra su valor dentro de la ejecución del sp y 
-- finalmente la mostramos en consola
CALL sp_test(1, @response);
SELECT @response;
SHOW PROCEDURE STATUS WHERE db = 'jon';
DROP PROCEDURE sp_test; 




-- EJEMPLO 2

DELIMITER ??

  CREATE PROCEDURE sp_join(
    IN id_cliente INT,
    OUT ou_message VARCHAR(60)
  )
    BEGIN

      SELECT clientes.*, tarjetas.*, suscripciones.* 
        FROM servicios
        INNER JOIN clientes
        ON servicios.cliente = clientes.cliente_id
        INNER JOIN tarjetas
        ON servicios.tarjeta = tarjetas.tarjeta_id
        INNER JOIN suscripciones
        ON servicios.suscripcion = suscripciones.suscripcion_id
        WHERE clientes.cliente_id = id_cliente;

        SELECT 'todo fue bien' INTO ou_message;
    END ??


DELIMITER ;

CALL sp_join(1,@response);
SELECT @response;
SHOW PROCEDURE STATUS WHERE db = 'jon';
DROP PROCEDURE sp_join;







-- SINTAXIS TRIGGERS

/* 
  DELIMITER //
  CREATE TRIGGER nombre_disparador
    [BEFORE | AFTER] [INSERT | UPDATE | DELETE]
    ON nombre_tabla
    FOR EACH ROW
  BEGIN
  END //
  DELIMITER ;

*/

-- delimitamos el trigger
DELIMITER //

-- creamos el trigger y su nombre
CREATE TRIGGER tg_actividad_clientes
-- le indicamos el momento a ejecutar el trigger
  AFTER 
-- le indicamos la accion que hará que se desencadene el trigger  
  INSERT
-- lo vinculamos a una tabla para que la "mapee"  
  ON clientes
  FOR EACH ROW
-- bloque de código que ejecutara el trigger
  BEGIN
    -- Tambien recordemos qué la palabra reservada NEW hace referencía a
    -- la instancia(objeto) que se creo en base a la acción que hace 
    -- que se ejecute el trigger
   
    INSERT INTO actividad_clientes VALUES (0, NEW.cliente_id, NOW());
    
  END //

DELIMITER ;


SHOW TRIGGERS FROM jon;
DROP TRIGGER tg_actividad_clientes;


-- ejemplo 1

-- Creando la tabla de actualizaciones de suscripciones
CREATE TABLE update_suscripciones(
  id INTEGER  AUTO_INCREMENT PRIMARY KEY,
  suscripcion INTEGER UNSIGNED,
  costo_nuevo DECIMAL(5,2),
  costo_actual DECIMAL(5,2),

  CONSTRAINT suscripcion_fk 
  FOREIGN KEY (suscripcion) 
  REFERENCES suscripciones (suscripcion_id)
);

DROP TABLE iF EXISTS update_suscripciones;



-- Creando un trigger para la actualizacion

DELIMITER ??
  CREATE TRIGGER tg_log_update_data
    BEFORE 
    UPDATE
    ON suscripciones
    FOR EACH ROW
  BEGIN
      INSERT INTO 
      update_suscripciones (suscripcion, costo_nuevo, costo_actual)
      VALUES (OLD.suscripcion_id, NEW.costo, OLD.costo);
  END ??

DELIMITER ;

UPDATE  suscripciones SET costo = 250 WHERE suscripcion_id = 1;
UPDATE  suscripciones SET costo = 390 WHERE suscripcion_id = 2;









-- ejemplo 2

-- Creando una tabla que guarde un registro de todos los cambios de precios
-- de la tabla productos


CREATE TABLE prices_changes(
  id INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  producto_id INTEGER UNSIGNED,
  precio_nuevo   DECIMAL(7,2),
  precio_anterior   DECIMAL (7,2),

  CONSTRAINT producto_id_fk
  FOREIGN KEY (producto_id)
  REFERENCES productos (producto_id)

);
DROP TABLE IF EXISTS prices_changes ; 



-- creando el procedimiento almacenado para cambiar los precios de los productos

DELIMITER ??
  CREATE PROCEDURE sp_change_price_product(
    IN product_id INT,
    IN price DECIMAL(7,2),
    OUT message_out VARCHAR(60)
  )
    BEGIN
      UPDATE productos SET precio = price WHERE producto_id = product_id;
      SELECT 'se actualizo correctamente' INTO message_out;
    END ??


DELIMITER ; 

CALL sp_change_price_product(1, 7000, @response);
CALL sp_change_price_product(1, 6100, @response);
CALL sp_change_price_product(2, 5000, @response);
CALL sp_change_price_product(2, 9000, @response);
SELECT @response;
DROP PROCEDURE sp_change_price_product;




-- creando el trigger para  desencadenar un evento, este se ejecutara cuando suceda una actualización
-- en la tabla de productos

DELIMITER ??

    CREATE TRIGGER tg_log_change_prices
      AFTER UPDATE ON productos
      FOR EACH ROW
      BEGIN
        INSERT INTO prices_changes (producto_id, precio_nuevo, precio_anterior)
        VALUES (OLD.producto_id, NEW.precio, OLD.precio);
      END ??


DELIMITER ;
DROP TRIGGER tg_log_change_prices;



/* YA SE TERMINO  EL CURSO 100% */

