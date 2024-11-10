# Tema 1: Manejo de Permisos a Nivel de Usuarios de Bases de Datos
Los permisos en el motor de base de datos se administran a nivel de base de datos a través de usuarios de base de datos y roles de base de datos.

### Usuarios de Bases de Datos

Los inicios de sesión conceden acceso a una base de datos mediante la creación de un usuario y la asignación del mismo para iniciar sesión. Cada usuario se asigna a un inicio de sesión único. 
También se pueden crear usuarios de base de datos que no tengan un nombre de usuario correspondiente. Estos se denominan usuarios de bases de datos independientes. Esto es recomendado por Microsoft porque facilita mover la base de datos a otro servidor. Al igual que un inicio de sesión, un usuario de base de datos independiente puede usar la autenticación de Windows o la de SQL Server.

### Roles de Bases de Datos (Fijos y Creados por el Usuario)
- Los roles fijos de base de datos son un conjunto de roles preconfigurados que proporcionan un práctico grupo de permisos de nivel de base de datos. Se pueden agregar usuarios de base de datos y roles de base de datos definidos por el usuario a los roles fijos de base de datos mediante la instrucción ALTER ROLE ... ADD MEMBER.
- Los usuarios con el permiso CREATE ROLE pueden crear nuevos roles de base de datos definidos por el usuario para representar grupos de usuarios con permisos comunes. Normalmente, los permisos se conceden o deniegan a todo el rol, lo que simplifica la administración y supervisión de permisos. Se pueden agregar usuarios de base de datos a los roles de base de datos mediante la instrucción ALTER ROLE ... ADD MEMBER
  
Algunos roles de base de datos predeterminados incluyen:
- db_owner: Control total dentro de la base de datos.
- db_datareader: Permiso de lectura en todas las tablas y vistas de la base de datos.
- db_datawriter: Permiso de escritura en todas las tablas y vistas de la base de datos.
- db_ddladmin: Permite ejecutar cualquier comando DDL (Data Definition Language), como CREATE, ALTER y DROP.

### Entidades de Seguridad 
Las entidades de seguridad son el nombre oficial de las identidades que utilizan SQL Server y a las que se puede asignar permiso para realizar acciones. Suelen ser personas o grupos de personas, pero pueden ser otras entidades que finjan ser personas. 
Las entidades de seguridad se pueden crear y administrar mediante la lista Transact-SQL o mediante SQL Server Management Studio.

# Desarrollo del TEMA 1
Tareas: 
1. Verificar que la base de datos esté configurada en modo mixto (autenticación integrada con windows y por usuario de base de datos).

![configuracion_sql_modo_mixto](/script/tema01_manejo_de_permisos_a_nivel_de_usuario_de_bd/tema01_img/modo_mixto.png) 

2. Manejo de permisos a nivel de roles y de usuarios. Implementar un caso práctico para cada uno.

## Permisos a nivel de usuarios:
- Crear dos usuarios de base de datos.
- A un usuario darle el permiso de administrador y al otro usuario solo permiso de lectura.
- Utilizar los procedimientos almacenados creados anteriormente.
- Al usuario con permiso de solo lectura, darle permiso de ejecución sobre este procedimiento. 
- Realizar INSERT con sentencia SQL sobre la tabla del procedimiento con ambos usuarios.
- Realizar un INSERT a través del procedimiento almacenado con el usuario con permiso de solo lectura

## Permisos a nivel de roles del DBMS:
- Crear dos usuarios de base de datos.


![usuarios_rol_lectura](/script/tema01_manejo_de_permisos_a_nivel_de_usuario_de_bd/tema01_img/usuarios_rol_lectura.png)

- Crear un rol que solo permita la lectura de alguna de las tablas creadas.


![creacion_rol_lectura](/script/tema01_manejo_de_permisos_a_nivel_de_usuario_de_bd/tema01_img/creacion_rol_lectura.png)


- Darle permiso a uno de los usuarios sobre el rol creado anteriormente.


![alteracion_rol_lectura](/script/tema01_manejo_de_permisos_a_nivel_de_usuario_de_bd/tema01_img/alteracion_rol_lectura.png)


- Verificar el comportamiento de ambos usuarios (el que tiene permiso sobre el rol y el que no tiene), cuando intentan leer el contenido de la tabla


![verificacion_rol_lectura](/script/tema01_manejo_de_permisos_a_nivel_de_usuario_de_bd/tema01_img/verificacion_rol_lectura.png)

- Expresar sus conclusiones

  
Cree dos usuarios, un Usuario1 que posee el rol creado "LecturaPelicula", y otro usuario Usuario2, que no posee dicho rol.
Al iniciar sesion en Usuario1 e intentar, con un SELECT, visualizar los datos de la tabla Pelicula, si me permite hacerlo, en cambio si inicio sesión con el Usuario2
e intento leer la tabla película, aparece un mensaje de error ya que dicho usuario no posee el permiso para esa visualización.

| Usuario1    | Usuario2     | 
|:-----------: |:------------:|
| ![usuario1_rol_lectura](/script/tema01_manejo_de_permisos_a_nivel_de_usuario_de_bd/tema01_img/usuario1_rol_lectura.png)      |  ![usuario2_rol_lectura](/script/tema01_manejo_de_permisos_a_nivel_de_usuario_de_bd/tema01_img/usuario2_rol_lectura.png)      | 






 





