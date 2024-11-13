---- PERMISOS A NIVEL DE USUARIOS
-- Crear dos usuarios de base de datos.
CREATE LOGIN UsuarioAdmin WITH PASSWORD = '1234';
CREATE LOGIN UsuarioLectura WITH PASSWORD = '1234';

-- A un usuario darle el permiso de administrador y al otro usuario solo permiso de lectura.
USE TicketSuit;
CREATE USER UsuarioAdm FOR LOGIN UsuarioAdmin;
CREATE USER UsuarioLect FOR LOGIN UsuarioLectura; 

ALTER ROLE db_owner ADD MEMBER UsuarioAdm;
ALTER ROLE db_datareader ADD MEMBER UsuarioLect;

-- Verificacion de que se hayan a�adido los usuarios a los roles
SELECT 
    dp.name AS Usuario,
    dp.type_desc AS Tipo,
    rol.name AS Rol
FROM 
    sys.database_principals AS dp
INNER JOIN 
    sys.database_role_members AS drm
    ON dp.principal_id = drm.member_principal_id
INNER JOIN 
    sys.database_principals AS rol
    ON rol.principal_id = drm.role_principal_id
WHERE 
    dp.name = 'UsuarioAdm' OR dp.name = 'UsuarioLect'

-- Utilizar los procedimientos almacenados creados anteriormente.

CREATE PROCEDURE InsertarCine
(
    @id_cine INT,
    @nombre VARCHAR(200),
    @direccion VARCHAR(200)
) AS BEGIN
    INSERT INTO Cine (id_cine, nombre, direccion)
    VALUES (@id_cine, @nombre, @direccion);
END;

-- Al usuario con permiso de solo lectura, darle permiso de ejecuci�n sobre este procedimiento.

GRANT EXECUTE ON OBJECT::InsertarCine TO UsuarioLect;

-- Realizar INSERT con sentencia SQL sobre la tabla del procedimiento con ambos usuarios.

INSERT INTO Cine (id_cine, nombre, direccion) VALUES (101, 'Cines Av. Armenia', 'Av. Armenia 1032');


-- Realizar un INSERT a trav�s del procedimiento almacenado con el usuario con permiso de solo lectura

EXEC InsertarCine 102, Cineapolis, 'Cordoba 1520';



---- PERMISOS A NIVEL DE ROLES DEL DBMS
-- Crear dos usuarios de base de datos.

CREATE LOGIN Usuario1 WITH PASSWORD = '1234';
CREATE LOGIN Usuario2 WITH PASSWORD = '1234';

USE TicketSuit;

CREATE USER Usuario1 FOR LOGIN Usuario1;
CREATE USER Usuario2 FOR LOGIN Usuario2;

-- Crear un rol que solo permita la lectura de alguna de las tablas creadas.

CREATE ROLE LecturaPelicula;
GRANT SELECT ON Pelicula TO LecturaPelicula;

-- Darle permiso a uno de los usuarios sobre el rol creado anteriormente.

ALTER ROLE LecturaPelicula ADD MEMBER Usuario1;

-- Verificar el comportamiento de ambos usuarios (el que tiene permiso sobre el rol y el que no tiene), cuando intentan leer el contenido de la tabla

USE TicketSuit
SELECT * FROM Pelicula




