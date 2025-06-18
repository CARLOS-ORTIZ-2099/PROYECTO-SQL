# reglas de cuando elegir tablas pivotes

tenemos que tener en cuenta que cuando vamos a tener una relacion de 1 a 1 o de 1 a M, si es valido que nuestra entidad tenga como foreign key el id
de la otra entidad a relacionar.
por ejemplo supongamos que tenemos una entidad usuarios y cada usuario puede tener varios roles, entonces si nuestros usuarios quisieran tener mas de 2 roles para un mismo campo ahi estariamos limitando esa accion ya que solo tendremos un id que referencie a un solo rol en la entidad de roles, entonces lo ideal es ya no tener la FK en dicha entidad de usuarios, lo ideal seria tener una tabla pivote que relacione ambas entidad tanto usuarios como roles

# Sistema de Autenticación

## Listado de Entidades

### usuarios **(ED)**

- usuario_id **(PK)**
- username **(UQ)**
- password
- email **(UQ)**
- nombre
- apellido
- avatar
- activo
- fecha_creacion
- fecha_actualizacion

### roles **(EC)**

- rol_id **(PK)**
- nombre
- descripcion

### permisos **(EC)**

- permiso_id **(PK)**
- nombre
- descripcion

### roles_x_usuario **(EP)**

- rxu_id **(PK)**
- usuario_id **(FK)**
- rol_id **(FK)**

### permisos_x_roles **(EP)**

- pxr_id **(PK)**
- rol_id **(FK)**
- permiso_id **(FK)**

## relaciones

un **usuario** _tiene_ varios **roles** (_M a M_)
un **rol** _tiene_ **permiso** (_M a M_)

## logica negocio

### usuarios

1. crear usuario
1. actualizar usuario
1. obtener un usuario en especifico
1. obtener usuarios
1. eliminar usuario usuario
1. asignar roles a un usuario
