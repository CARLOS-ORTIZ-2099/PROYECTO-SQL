# requisitos del sistema

- Registrar participantes para el evento Entrena tu _glamour_ .
- El evento tendra 4 disciplinas : _kickboxing_, pilates, yoga y zumba.
- Cada disciplina tendra 3 bloques de horarios :
  - Bloque 1 de 9:00 a 12:00
  - Bloque 2 de 14:00 a 17:00
  - Bloque 3 de 18:00 a 21:00
- Cada actividad tendra un maximo de 10 participantes, excepto yoga que tendra 20.
- Cada participante solo se podra registrar a una sola actividad.

## listado de entidades

### usuarios **(ED)**

- usuario_id **(PK)**
- nombre
- apellido
- fecha
- disciplina **(FK)**

<!-- ### disciplina **(EC)**

- disciplina_id **(PK)**
- nombre
- descripcion
- horario **(FK)**

### horarios **(EC)**

- horarios_id **(PK)**
- horario -->

### disciplina **(EC)**

- disciplina_id **(PK)**
- nombre
- descripcion

### horarios **(EC)**

- horarios_id **(PK)**
- horario

### horario_x_disciplina **(EP)**

- horario_x_disciplina_id **(PK)**
- disciplina **(FK)**
- horario **(FK)**
