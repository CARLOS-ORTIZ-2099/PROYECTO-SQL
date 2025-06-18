# Encuestas

## Listado de Entidades

### encuestas **(ED)**

- encuesta_id **(PK)**
- nombre
- descripcion
- imagen
- fecha
- encuestados

### preguntas **(ED)**

- pregunta_id **(PK)**
- encuesta_id **(FK)**
- pregunta

### respuestas **(ED)**

- respuesta_id **(PK)**
- pregunta_id **(FK)**
- respuesta
- es_correcta

### encuestados **(ED)**

- encuestado_id **(PK)**
- nombre
- apellidos
- edad
- email **(UQ)**

### resultado **(ED|EP)**

- resultado_id **(PK)**
- encuesta_id **(FK)**
- encuestado_id **(FK)**
- preguntas
- correctas

## relaciones

hola profesor aqui mi solucion al reto, la cardinalidad es algo confusa y he visto que algunos tienen respuestas distintas, pero por lo que voy entendiendo
la cardinalidad que pueda tener un sistema va depender de la logica de negocio de que tendra la aplicacion y dependiendo de a que entidad le demos mas relevancia, la cardinalidad cambiara?

1. una **encuesta** _tiene_ **preguntas** (_1 a M_)('en caso que la encuesta tenga una sola pregunta podria cambiar')

1. una **pregunta** _tiene_ una **respuesta** (_1 a 1_)('si consideramos solo la que es correcta')

1. un **resultado** _pertenece_ a una sola **encuesta** (_1 a 1_)

1. un **resultado** _pertenece_ a un solo **encuestado** (_1 a 1_)

1. un **encuestado** _realiza_ varias **encuestas** (_1 a M_)('si tenemos un sistema que haga encuestas de manera periodica' )
