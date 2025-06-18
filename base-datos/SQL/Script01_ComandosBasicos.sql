-- Comentario en una línea en SQL

/*
  Este es un comentario
  de varias
  líneas
  
SQL, NO distingue entre MÁYUSCULAS y minúsculas pero:

  - Comandos y palabras reservadas de SQL van en MÁYUSCULAS.
  - Nombres de objetos y datos van en minúsculas con _snake_case_.
  - Para strings usar comillas simples ( `''` ).
  - Todas las sentencias terminan con punto y coma ( `;` ).
*/

SHOW DATABASES;

CREATE DATABASE curso_sql;

/* si no existe la base de datos lo crea */
CREATE DATABASE IF NOT EXISTS curso_sql;

DROP DATABASE curso_sql;

/* si existe la base de datos lo elimina  */
DROP DATABASE IF EXISTS curso_sql;

/* crear base de datos */
CREATE DATABASE para_jonmircha;

/* crear usuario, recalcar que no todos los usuarios tendran acceso a todas las tablas*/
CREATE USER 'jonmircha'@'localhost' IDENTIFIED BY 'qwerty';

/* asignando privilegios para un usuario */
GRANT ALL PRIVILEGES ON para_jonmircha TO 'jonmircha'@'localhost';

/* actualiza automaticamente los privilegios */
FLUSH PRIVILEGES;

/* ver los privilegios de un usuario */
SHOW GRANTS FOR 'jonmircha'@'localhost';

/* eliminra todos los permisos para un usuario */
REVOKE ALL, GRANT OPTION FROM 'jonmircha'@'localhost';

/* eliminar un usuario */
DROP USER 'jonmircha'@'localhost';

/* seleccionando una base de datos  */
USE curso_sql;

/* mostrar las tablas disponibles de una determinada db*/
SHOW TABLES;

/* muestra la informacion(como fks, pks, etc) de la tabla usuarios */
DESCRIBE usuarios;


/* crear tabla */
CREATE TABLE usuarios(
  nombre VARCHAR(50),
  correo VARCHAR(50)
);

/* añadir un nuevo campo */
ALTER TABLE usuarios ADD COLUMN cumpleanios VARCHAR(15);
/* cambiando el tipo de dato que tendra un campo */
ALTER TABLE usuarios MODIFY cumpleanios DATE;
/* eliminar columna */
ALTER TABLE usuarios DROP COLUMN cumpleanios;


/* renombrando el campo de una tabla */
/* no disponible en ciertas versiones */
ALTER TABLE usuarios RENAME COLUMN cumpleanios TO nacimiento;
ALTER TABLE usuarios CHANGE cumpleanios nacimiento Date;



/* crear tabla y restriciones */
/* UNSIGNED : quiere decir que no permite que el numero tenga signos, por 
   ejemplo si se intentase poner un numero negativo al tener esta 
   restriccion no se podria hacer
 */
CREATE TABLE usuarios(
  usuario_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(30) NOT NULL,
  apellidos VARCHAR(30) NOT NULL,
  correo VARCHAR(50) UNIQUE,
  direccion VARCHAR(100) DEFAULT 'Sin direccion',
  edad INT DEFAULT 0
);
/* eliminar tabla */
DROP TABLE usuarios;

/* insertar registros */

/* forma no recomendada */
INSERT INTO usuarios VALUES (0,"Jon","MirCha","jonmircha@gmail.com","dirección de mircha", 38);

/* forma recomendada */
INSERT INTO usuarios (apellidos, edad, nombre) VALUES ("MirCha", 10, "kEnAi");

/* otras formas de crear registros */
INSERT INTO usuarios SET nombre = "Irma", apellidos = "Campos", edad = 38;

/* creando multiples registros */
INSERT INTO usuarios (nombre, apellidos, correo, edad) VALUES
  ("Pepito", "Perez", "pepito@gmail.com", 28),
  ("Rosita", "Juárez", "rosita@gmail.com", 19),
  ("Macario", "Guzman", "macario@gmail.com", 55);



/* leer registros de una tabla */

SELECT * FROM usuarios;

/* seleccionando ciertos campos de una tabla */
SELECT nombre, edad, usuario_id FROM usuarios;

/* sacar el recuento de una tabla */
SELECT COUNT(*) FROM usuarios;

/* colocando un alias a un campo(calculado) */
SELECT COUNT(*) AS total_usuarios FROM usuarios;

/* seleccionando con condiciones */
SELECT * FROM usuarios WHERE nombre = "Jon";

/* buscando solo aquellos que cuyo campo nombre este incluido en un listado
   de opciones
 */
SELECT * FROM usuarios WHERE nombre IN ("Jon", "kEnAi", "Irma");

 /* buscar aquellos que empiezen con cierto caracter */
SELECT * FROM usuarios WHERE apellidos LIKE 'M%';

 /* buscar aquellos que terminen con cierto caracter */
SELECT * FROM usuarios WHERE correo LIKE '%@gmail.com';

 /* buscar aquellos que contengan cierto caracter */
SELECT * FROM usuarios WHERE nombre LIKE '%it%';

 /* buscar aquellos que no empiezen con cierto caracter */
SELECT * FROM usuarios WHERE apellidos NOT LIKE 'M%';

 /* buscar aquellos que no terminen con cierto caracter */
SELECT * FROM usuarios WHERE correo NOT LIKE '%@gmail.com';

 /* buscar aquellos que no contengan cierto caracter */
SELECT * FROM usuarios WHERE nombre NOT LIKE '%it%';


SELECT * FROM usuarios WHERE edad != 38;
SELECT * FROM usuarios WHERE edad <> 38;

SELECT * FROM usuarios WHERE edad = 38;

SELECT * FROM usuarios WHERE edad > 38;

SELECT * FROM usuarios WHERE edad >= 38;

SELECT * FROM usuarios WHERE edad < 38;

SELECT * FROM usuarios WHERE edad <= 38;

 /* buscar aquellos cuya direccion no sea Sin dirección */
SELECT * FROM usuarios WHERE NOT direccion = 'Sin dirección'; 

SELECT * FROM usuarios WHERE direccion != 'Sin dirección' AND edad >= 38;

SELECT * FROM usuarios WHERE direccion != 'Sin dirección' AND edad >= 38 AND nombre = "Jon";

SELECT * FROM usuarios WHERE direccion != 'Sin dirección' AND edad >= 38;

/* actualizar registro/s de una tabla */

UPDATE usuarios SET correo = "irma@gmail.com", direccion = "Dirección de Irma" WHERE usuario_id = 3;

-- CUIDADO toda sentencia UPDATE debe llevar su claúsula WHERE 
UPDATE usuarios SET direccion = "nueva dirección";

/* eliminar registro/s de una tabla */

DELETE FROM usuarios WHERE usuario_id = 6;

-- CUIDADO toda sentencia DELETE debe llevar su claúsula WHERE
-- NO TE OLVIDES DEL WHERE EN EL DELETE FROM
-- https://www.youtube.com/watch?v=i_cVJgIz_Cs

/* elimina todos los registros de una tabla, pero conserva la memoria cache o 
   la referencia del numero del id   
*/
DELETE FROM usuarios;

/* este tambien elimina todos los registros de una tabla, pero resetea toda   
   la memoria cache 
*/

TRUNCATE TABLE usuarios;

/* YA SE TERMINO */