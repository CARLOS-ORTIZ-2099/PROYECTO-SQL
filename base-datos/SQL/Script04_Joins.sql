CREATE DATABASE curso_sql;

DROP DATABASE curso_sql;

USE curso_sql;

SHOW TABLES;

DROP TABLE caballeros;

TRUNCATE TABLE caballeros;

SELECT * FROM caballeros;


CREATE TABLE armaduras (
  armadura_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  armadura VARCHAR(30) NOT NULL
);

CREATE TABLE signos (
  signo_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  signo VARCHAR(30) NOT NULL
);

CREATE TABLE rangos (
  rango_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  rango VARCHAR(30) NOT NULL
);

CREATE TABLE ejercitos (
  ejercito_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  ejercito VARCHAR(30) NOT NULL
);

CREATE TABLE paises (
  pais_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  pais VARCHAR(30) NOT NULL
);

CREATE TABLE caballeros (
  caballero_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(30),
  armadura INT UNSIGNED,
  rango INT UNSIGNED,
  signo INT UNSIGNED,
  ejercito INT UNSIGNED,
  pais INT UNSIGNED,
  FOREIGN KEY(armadura) REFERENCES armaduras(armadura_id),
  FOREIGN KEY(rango) REFERENCES rangos(rango_id),
  FOREIGN KEY(signo) REFERENCES signos(signo_id),
  FOREIGN KEY(ejercito) REFERENCES ejercitos(ejercito_id),
  FOREIGN KEY(pais) REFERENCES paises(pais_id)
);

INSERT INTO armaduras VALUES
  (1, "Pegaso"),
  (2, "Dragón"),
  (3, "Cisne"),
  (4, "Andrómeda"),
  (5, "Fénix"),
  (6, "Géminis"),
  (7, "Acuario"),
  (8, "Wyvern"),
  (9, "Dragón Marino"),
  (10, "Bennu");

INSERT INTO rangos VALUES
  (1, "Bronce"),
  (2, "Oro"),
  (3, "Espectro"),
  (4, "Marino");

INSERT INTO signos VALUES
  (1, "Aries"),
  (2, "Tauro"),
  (3, "Géminis"),
  (4, "Cancer"),
  (5, "Leo"),
  (6, "Virgo"),
  (7, "Libra"),
  (8, "Escorpión"),
  (9, "Sagitario"),
  (10, "Capricornio"),
  (11, "Acuario"),
  (12, "Piscis");

INSERT INTO ejercitos VALUES
  (1, "Athena"),
  (2, "Hades"),
  (3, "Poseidón");

INSERT INTO paises VALUES
  (1, "Japón"),
  (2, "Rusia"),
  (3, "Grecia"),
  (4, "Francia"),
  (5, "Inglaterra");


INSERT INTO caballeros VALUES
  (1,"Seiya", 1, 1, 9, 1, 1),
  (2,"Shiryu", 2, 1, 7, 1, 1),
  (3,"Hyoga", 3, 1, 11, 1, 2),
  (4,"Shun", 4, 1, 6, 1, 1),
  (5,"Ikki", 5, 1, 5, 1, 1),
  (6,"Kanon", 6, 2, 3, 1, 3),
  (7,"Saga", 6, 2, 3, 1, 3),
  (8,"Camus", 7, 2, 11, 1, 4),
  (9,"Rhadamanthys", 8, 3, 8, 2, 5),
  (10,"Kanon", 9, 4, 3, 3, 3),
  (11,"Kagaho", 10, 3, 5, 2, 2);

SELECT * FROM armaduras;
SELECT * FROM rangos;
SELECT * FROM signos;
SELECT * FROM ejercitos;
SELECT * FROM paises;
SELECT * FROM caballeros;

-- left join trae los registros de varias tablas, pero priorizando la de la izquierda
-- si no hay coincidencias de la tabla derecha con la izquierda los campos de la izquierda se llenan con NULL
SELECT * FROM caballeros c
  LEFT JOIN signos s
  ON c.signo = s.signo_id;


-- right join trae los registros de varias tablas, pero priorizando la de la derecha
SELECT * FROM caballeros c
  RIGHT JOIN signos s
  ON c.signo = s.signo_id;

SELECT * FROM caballeros c
  INNER JOIN signos s
  ON c.signo = s.signo_id;

-- mysql no admite el outer join pero esto es una forma de simularlo
SELECT * FROM caballeros c
  LEFT JOIN signos s
  ON c.signo = s.signo_id
UNION
SELECT * FROM caballeros c
  RIGHT JOIN signos s
  ON c.signo = s.signo_id;

-- recalcar que cuando se usa el inner join el orden de las uniones no importa
-- si usamos left o right el orden si importa ya que la declaracion priorizara una u otra tabla

-- ejemplo 1
SELECT cb.caballero_id, cb.nombre,ar.armadura, sg.signo,
rg.rango, ej.ejercito, pa.pais
FROM caballeros cb
INNER JOIN armaduras ar ON cb.armadura = ar.armadura_id
INNER JOIN rangos rg ON cb.rango = rg.rango_id
INNER JOIN signos sg ON cb.signo = sg.signo_id
INNER JOIN ejercitos ej ON cb.ejercito = ej.ejercito_id
INNER JOIN paises pa ON cb.pais = pa.pais_id;

-- ejemplo 2
SELECT c.caballero_id, c.nombre, a.armadura,
  s.signo, r.rango, e.ejercito, p.pais
  FROM caballeros c
  INNER JOIN armaduras a ON c.armadura = a.armadura_id 
  INNER JOIN signos s ON c.signo = s.signo_id 
  INNER JOIN rangos r ON c.rango  = r.rango_id 
  INNER JOIN ejercitos e ON c.ejercito  = e.ejercito_id 
  INNER JOIN paises p ON c.pais  = p.pais_id; 


-- subconsultas



/* A continuación, la consulta externa compara el salario de cada empleado
   con el salario promedio de los empleados que pertenezcan al mismo 
   departamento del empleado actual e incluye sólo a los que ganan más.
   (subconsulta correlacionada qué devuelve un valor escalar) 
   Recordemos también qué una subconsulta correlacionada se puede interpretar
   cómo si fuera un bucle anidado en programación, es decir un for dentro de 
   otro for,  ya que para cada registro de la consulta externa se ejecutara 
   la subconsulta
*/


SELECT e1.employee_name  
FROM employees e1
WHERE e1.salary > ( 
  SELECT AVG(e2.salary) 
  FROM employees e2 
  WHERE e2.department_id = e1.department_id
); 




/* esto de aquí sería una subconsulta correlacionada, ya que 
   para cada registro que se itere de la tabla signos ejecutamos la
   subconsulta haciendo referencia a la tabla de la consulta exterior.
   Sabemos tambien que la clausula WHERE es lo que se ejecuta primero entonces lo primero que pasará será que filtra los registros por signo_id
   luego hace un recuento para esos datos filtrados
    
*/ 
SELECT signo,
  ( 
    -- devuelve un valor escalar
    SELECT COUNT(*) 
    FROM caballeros c 
    WHERE c.signo = s.signo_id
  ) AS total_caballeros
FROM signos s;

-- Esta es otra forma de hacerlo pero con joins
SELECT si.signo, COUNT(si.signo) 
FROM caballeros  ca
INNER JOIN signos si
ON ca.signo = si.signo_id
GROUP BY si.signo;




/* de igual manera esto es una subconsulta correlacionada ya que para cada 
   registro de la tabla externa(rangos) se evalua la subconsulta 
*/

SELECT rango,
  ( 
    -- devuelve un valor escalar
    SELECT COUNT(*) 
    FROM caballeros c 
    WHERE c.rango = r.rango_id
  )AS total_caballeros
FROM rangos r;



-- Esta es otra forma de hacerlo pero con joins
SELECT ra.rango, COUNT(ra.rango) 
FROM rangos  ra
INNER JOIN caballeros ca
ON ca.rango = ra.rango_id
GROUP BY ra.rango;





/* de igual manera esto es una subconsulta correlacionada ya que para cada 
   registro de la tabla externa(ejercitos) se evalua la subconsulta 
*/

SELECT ejercito,
  (
    -- devuelve un valor escalar
    SELECT COUNT(*) 
    FROM caballeros c 
    WHERE c.ejercito = e.ejercito_id
  )AS total_caballeros
FROM ejercitos e;



-- Esta es otra forma de hacerlo pero con joins
SELECT ej.ejercito, COUNT(ej.ejercito) 
FROM ejercitos  ej
INNER JOIN caballeros ca
ON ca.ejercito = ej.ejercito_id
GROUP BY ej.ejercito;





/* de igual manera esto es una subconsulta correlacionada ya que para cada 
   registro de la tabla externa(paises) se evalua la subconsulta 
*/
SELECT pais,
  ( 
    -- devuelve un valor escalar
    SELECT COUNT(*) 
    FROM caballeros c 
    WHERE c.pais = p.pais_id
  )AS total_caballeros
FROM paises p;


-- Esta es otra forma de hacerlo pero con joins
SELECT pa.pais, COUNT(pa.pais) 
FROM paises pa
INNER JOIN caballeros ca
ON ca.pais = pa.pais_id
GROUP BY pa.pais;


-- crear vista

CREATE VIEW vista_caballeros AS
  SELECT c.caballero_id, c.nombre, a.armadura,
    s.signo, r.rango, e.ejercito, p.pais
    FROM caballeros c
    INNER JOIN armaduras a ON c.armadura = a.armadura_id 
    INNER JOIN signos s ON c.signo = s.signo_id 
    INNER JOIN rangos r ON c.rango  = r.rango_id 
    INNER JOIN ejercitos e ON c.ejercito  = e.ejercito_id 
  INNER JOIN paises p ON c.pais  = p.pais_id;

CREATE VIEW vista_signos AS
  SELECT signo,
    (SELECT COUNT(*) FROM caballeros c WHERE c.signo = s.signo_id)
    AS total_caballeros
    FROM signos s;
  
-- seleccionar vista  
SELECT * FROM vista_caballeros;
SELECT * FROM vista_signos;

-- eliminar vista
DROP VIEW vista_caballeros;

-- mostrar las vistas disponibles
SHOW FULL TABLES IN jon WHERE TABLE_TYPE LIKE 'VIEW';



-- Más ejemplos de subconsultas

-- subconsultas escalares

select * from productos 
WHERE precio > (
  -- retorna un valor escalar
  select AVG(precio) as promedio from productos
);


-- subconsultas de 1 column y X cantidad de filas
select * from productos 
WHERE cantidad IN (
  select edad from usuarios
);


-- subconsulta de tablas
select nombre , promedio from (
  select nombre, AVG(precio) as  promedio 
  from productos
  group by  nombre
) as tempo
where  promedio > 10000;


-- subconsultas correlacionadas
  -- cuando algunos datos de la subconsulta dependen de la consulta externa
select productos.*, (
  select edad 
  from usuarios
  where edad = productos.cantidad

) as coincidencia
from productos 




-- subconsultas de registro



/* YA SE TERMINO */
