CREATE DATABASE curso_sql;

DROP DATABASE curso_sql;

USE curso_sql;

SHOW TABLES;

DROP TABLE caballeros;

TRUNCATE TABLE caballeros;

-- creacion de indices
CREATE TABLE caballeros (
  caballero_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(30),
  armadura VARCHAR(30) UNIQUE,
  rango VARCHAR(30),
  signo VARCHAR(30),
  ejercito VARCHAR(30),
  pais VARCHAR(30),
  -- creacion de indices
  INDEX i_rango (rango),
  INDEX i_signo (signo),
  -- un indice que apunte a mas de 1 campo
  INDEX i_caballeros (ejercito, pais)
);

CREATE TABLE caballeros (
  caballero_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(30),
  armadura VARCHAR(30),
  rango VARCHAR(30),
  signo VARCHAR(30),
  ejercito VARCHAR(30),
  pais VARCHAR(30),
  /* este tipo de indice es algo peculiar ya que cualquier busqueda que     
     hagamos este nos traera todos los registros que coincidan o que
     contengan en sus campos dichos valores de criterio, aunque eso implica
     tambien mayor lentitud a la hora de hacer las querys   
  */
  -- FULLTEXT sirve para marcar todos aquellos campos que quiero "marcar" 
  -- como criterio de busqueda
  FULLTEXT INDEX fi_search (armadura, rango, signo, ejercito, pais)
);


CREATE TABLE caballeros (
  caballero_id INT UNSIGNED,
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
  (0,"Saga","Junini","Oro","Junini","Athena","Grecia"),
  (0,"Camus","Acuario","Oro","Acuario","Athena","Francia"),
  (0,"Rhadamanthys","Wyvern","Espectro","Escorpión Oro","Hades","Inglaterra"),
  (0,"Kanon","Dragón Marino","Marino","Géminis Oro","Poseidón","Grecia"),
  (0,"Kagaho","Bennu","Espectro","Leo","Hades","Rusia");

SELECT * FROM caballeros;

SELECT * FROM caballeros WHERE signo = "Leo";

-- buscando registros que coincidan con una determinada palabra 
-- recalcar que esta busqueda no solo se basara en un campo, si no que se 
-- basara en todos aquellos campos que hallan sido "marcados" por el indice 
-- del tipo FULLTEXT

SELECT * FROM caballeros
  WHERE MATCH(armadura, rango, signo, ejercito, pais)
  AGAINST('Oro' IN BOOLEAN MODE);


-- con esto podemos visualizar los indices que posee una tabla
SHOW INDEX FROM caballeros;


-- añadiendo y quitando restricciones

ALTER TABLE caballeros ADD CONSTRAINT pk_caballero_id PRIMARY KEY (caballero_id);

ALTER TABLE caballeros MODIFY COLUMN caballero_id INT AUTO_INCREMENT;

ALTER TABLE caballeros ADD CONSTRAINT uq_armadura UNIQUE (armadura);
ALTER TABLE caballeros DROP CONSTRAINT uq_armadura;


ALTER TABLE caballeros ADD INDEX i_rango (rango);
ALTER TABLE caballeros DROP INDEX i_rango;


ALTER TABLE caballeros ADD INDEX i_ejercito_pais (ejercito, pais);
ALTER TABLE caballeros DROP INDEX i_ejercito_pais;


ALTER TABLE caballeros ADD FULLTEXT INDEX fi_search (nombre, signo);
ALTER TABLE caballeros DROP INDEX fi_search;


/* YA SE TERMINO */