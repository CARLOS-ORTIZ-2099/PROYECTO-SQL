/* creando la base de datos */
CREATE DATABASE curso_sql;

DROP DATABASE curso_sql;

USE curso_sql;

SHOW TABLES;

/* creando tabla usuarios */
CREATE TABLE usuarios(
  usuario_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(30) NOT NULL,
  apellidos VARCHAR(30) NOT NULL,
  correo VARCHAR(50) UNIQUE,
  edad INT DEFAULT 0
);


/* insertando multiples valores  */

INSERT INTO usuarios (nombre, apellidos, correo, edad) VALUES 
  ("Jon","MirCha","jonmircha@gmail.com", 38),
  ("kEnAi","MirCha","kenai@gmail.com", 10),
  ("Irma","Campos","irma@outlook.com", 38),
  ("Pepito", "Perez", "pepito@hotmail.com", 28),
  ("Rosita", "Juárez", "rosita@yahoo.com", 19),
  ("Macario", "Guzman", "macario@outlook.com", 55);
  
CREATE TABLE productos (
  producto_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  descripcion VARCHAR(50),
  precio DECIMAL(7,2),
  cantidad INT UNSIGNED
);

INSERT INTO productos (nombre, descripcion, precio, cantidad) VALUES
  ("Computadora", "Macbook Air M2", 29999.99, 5),
  ("Celular", "Nothing Phone 1", 11999.99, 15),
  ("Cámara Web", "Logitech C920", 1500, 13),
  ("Micrófono", "Blue Yeti", 2500, 19),
  ("Audífonos", "Audífonos Bose", 6500, 10);

/* seleccionando tablas */
SELECT * FROM usuarios;
SELECT * FROM productos;

/* eliminando tablas */
DROP TABLE usuarios;
DROP TABLE productos;

/* eliminando todos los registros de una tabla pero conservando su estructura */
TRUNCATE TABLE usuarios; 
TRUNCATE TABLE productos;


# Cálculos Aritméticos
SELECT 6 + 5 AS calculo;
SELECT 6 - 5 AS calculo;
SELECT 6 * 5 AS calculo;
SELECT 6 / 5 AS calculo;


# Funciones Matemáticas
/* sacar el modulo */
SELECT MOD(4,2);
SELECT MOD(5,2);
/* redondear hacia arriba */
SELECT CEILING(7.1);
/* redondear hacia abajo */
SELECT FLOOR(7.9);
/* redondea arriba/abajo segun el decimal */
SELECT ROUND(7.5);
SELECT ROUND(7.4999);
/* saca la potencia de un numero */
SELECT POWER(2, 6);
/* saca la raiz cuadrada de un numero */
SELECT SQRT(81);


# Columnas Calculadas
SELECT nombre, precio, cantidad, (precio * cantidad) AS ganancia FROM productos;

/* funciones de agregacion devuelven un "resumen" de la tabla o grupos(si aplica GROUP BY) segun uno o mas criterios */ 

# Funciones de Agrupamiento - Agregacion
SELECT MAX(precio) AS precio_maximo FROM productos;
SELECT MIN(precio) AS precio_minimo FROM productos;
SELECT SUM(cantidad) AS existencias FROM productos;
SELECT AVG(precio) AS precio_promedio FROM productos;
SELECT COUNT(*) AS productos_total FROM productos;


SELECT nombre, precio, MAX(precio) AS precio_maximo FROM productos GROUP BY precio, nombre;



CREATE TABLE caballeros (
  caballero_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(30),
  armadura VARCHAR(30),
  rango VARCHAR(30),
  signo VARCHAR(30),
  ejercito VARCHAR(30),
  pais VARCHAR(30)
);


INSERT INTO caballeros VALUES
  (0,"Seiya","Pegaso","Bronce","Sagitario","Athena","Japón"),
  (0,"Shiryu","Dragón","Bronce","Libra","Athena","Japón"),
  (0,"Hyoga","Cisne","Bronce","Acuario","Athena","Rusia"),
  (0,"Shun","Andromeda","Bronce","Virgo","Athena","Japón"),
  (0,"Ikki","Fénix","Bronce","Leo","Athena","Japón"),
  (0,"Kanon","Géminis","Oro","Géminis","Athena","Grecia"),
  (0,"Saga","Géminis","Oro","Géminis","Athena","Grecia"),
  (0,"Camus","Acuario","Oro","Acuario","Athena","Francia"),
  (0,"Rhadamanthys","Wyvern","Espectro","Escorpión","Hades","Inglaterra"),
  (0,"Kanon","Dragón Marino","Marino","Géminis","Poseidón","Grecia"),
  (0,"Kagaho","Bennu","Espectro","Leo","Hades","Rusia");


SELECT * FROM caballeros;

/* se recomienda que los criterios(campos) por los cuales se valla a agrupar
   siempre sean los que tambien se vallan a visualizar
*/
-- primero se agrupa por signo, luego se ejecuta la función de agregación
-- en este caso COUNT(*) y lo que hara será el recuento por cada
-- grupo creado según el signo
SELECT signo, COUNT(*) AS total FROM caballeros GROUP BY signo; 
SELECT armadura, COUNT(*) AS total FROM caballeros GROUP BY armadura; 
SELECT rango, COUNT(*) AS total FROM caballeros GROUP BY rango; 
SELECT pais, COUNT(*) AS total FROM caballeros GROUP BY pais; 
SELECT ejercito, COUNT(*) AS total FROM caballeros GROUP BY ejercito; 


/* recalcar que si en la consulta existe un WHERE este se ejecutara antes
   que el agrupamiento  
*/
SELECT rango, COUNT(*) AS total FROM caballeros WHERE ejercito = "Athena" GROUP BY rango; 


-- la clausula HAVING sirve para filtrar aquellos campos que hallan sido afectados por funciones de agregacion
SELECT rango, COUNT(*) AS total FROM caballeros WHERE ejercito = "Athena" GROUP BY rango HAVING total >= 4; 


SELECT nombre, precio, MAX(precio) AS precio_maximo FROM productos GROUP BY precio, nombre HAVING precio_maximo >= 10000;

SELECT signo, COUNT(distinct signo) AS signo_recuento FROM caballeros GROUP BY signo;

-- con DISTINCT seleccionamos aquellos campos unicos, es decir no considera los duplicados
SELECT DISTINCT signo FROM caballeros;
SELECT DISTINCT armadura FROM caballeros;
SELECT DISTINCT ejercito FROM caballeros;
SELECT DISTINCT rango FROM caballeros;
SELECT DISTINCT pais FROM caballeros;

-- ordena de forma ascendente
SELECT * FROM caballeros ORDER BY nombre ASC;

-- ordena de forma descendente
SELECT * FROM caballeros ORDER BY nombre DESC;

SELECT * FROM caballeros ORDER BY nombre, signo DESC;

SELECT * FROM caballeros ORDER BY nombre, armadura;

SELECT * FROM caballeros WHERE ejercito = "Athena" ORDER BY nombre, armadura;

-- agrupando y ordenando

SELECT ejercito, COUNT(*) AS total FROM caballeros GROUP BY ejercito ORDER BY ejercito DESC; 

SELECT nombre, precio, MAX(precio) AS precio_maximo FROM productos GROUP BY precio, nombre HAVING precio_maximo >= 1000 ORDER BY nombre;

-- mas filtros

SELECT * FROM productos;

SELECT * FROM productos WHERE precio >= 5000 AND precio <= 15000;

SELECT * FROM productos WHERE precio BETWEEN 5000 AND 15000;

SELECT * FROM productos WHERE nombre REGEXP '[a-z]';

SELECT * FROM productos WHERE descripcion REGEXP '[0-9]';

-- mas funciones 

SELECT ('Hola Mundo');
SELECT LOWER('Hola Mundo');
SELECT LCASE('Hola Mundo');
SELECT UPPER('Hola Mundo');
SELECT UCASE('Hola Mundo');
SELECT LEFT('Hola Mundo', 6);
SELECT RIGHT('Hola Mundo', 6);
SELECT LENGTH('Hola Mundo');
SELECT REPEAT('Hola Mundo', 3);
SELECT REVERSE('Hola Mundo');
SELECT REPLACE('Hola Mundo', 'o', 'x');
SELECT LTRIM('    Hola Mundo    ');
SELECT RTRIM('    Hola Mundo    ');
SELECT TRIM('    Hola Mundo     ');
SELECT CONCAT('Hola Mundo',' desde ', 'SQL');
SELECT CONCAT_WS('-','Hola','Mundo','desde','SQL');

SELECT UPPER(nombre), LOWER(descripcion), precio  FROM productos;


/* YA SE TERMINO */