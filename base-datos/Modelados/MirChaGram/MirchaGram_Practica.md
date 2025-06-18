# MirChaGram

## Listado de Entidades

### posts **(ED)**

- post_id
- post_date
- plot
- photo
- user **(FK)**

### user **(ED)**

- user_id **(PK)**
- user_date
- user_name
- email **(UQ)**
- password
- phone **(UQ)**
- bio
- web
- avatar
- birthdate
- genre
- country **(FK)**

### comments **(ED | EP)**

- comment_id **(PK)**
- comment_date
- comment
- post_id **(FK)**
- user_id **(FK)**

### hearts **(ED | EP)**

- heart_id **(PK)**
- heart_date
- post_id **(FK)**
- user_id **(FK)**

### follows

- follow_id **(PK)**
- follow_date
- follow_user **(FK)**
- following_user **(FK)**

### counties **(EC)**

- country_id **(PK)**
- country_name

## relaciones

un **usuario** _crea_ **publicaciones** (_1 a M_)
un **usuario** _genera_ **comentarios** (_1 a M_)
un **usuario** _crea_ **like** (_1 a 1_)
muchos **usuarios** _siguen_ **usuarios** (_M a M_)
