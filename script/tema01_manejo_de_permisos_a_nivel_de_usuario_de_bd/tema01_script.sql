---- PERMISOS A NIVEL DE USUARIOS
-- Crear dos usuarios de base de datos.
CREATE LOGIN UsuarioAdmin WITH PASSWORD = '1234';
CREATE LOGIN UsuarioLectura WITH PASSWORD = '1234';

-- A un usuario darle el permiso de administrador y al otro usuario solo permiso de lectura.
USE TicketSuit;
CREATE USER UsuarioAdm FOR LOGIN UsuarioAdmin;
CREATE USER UsuarioLect FOR LOGIN UsuarioLectura; 

ALTER ROLE db_owner ADD MEMBER UsuarioAdmin;
ALTER ROLE db_datareader ADD MEMBER UsuarioLect;

---- PERMISOS A NIVEL DE ROLES DEL DBMS
-- Crear dos usuarios de base de datos.

CREATE LOGIN Usuario1 WITH PASSWORD = '1234';
CREATE LOGIN Usuario2 WITH PASSWORD = '1234';

USE TicketSuit;
CREATE USER Usuario1 FOR LOGIN Usuario1;
CREATE USER Usuario2 FOR LOGIN Usuario2;

-- Crear un rol que solo permita la lectura de alguna de las tablas creadas.
CREATE ROLE LecturaPelicula;

-- Darle permiso a uno de los usuarios sobre el rol creado anteriormente.
GRANT SELECT ON Pelicula TO LecturaPelicula;

ALTER ROLE LecturaPelicula ADD MEMBER Usuario1;

-- Verificar el comportamiento de ambos usuarios (el que tiene permiso sobre el rol y el que no tiene), cuando intentan leer el contenido de la tabla
USE TicketSuit
SELECT * FROM Pelicula




