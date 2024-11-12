--DESARROLLO TEMA 4
--Crear una nueva tabla  con una columna JSON
CREATE TABLE Ciudad (
    id_ciudad INT PRIMARY KEY,
    nombre NVARCHAR(100), 
    detalles NVARCHAR(MAX)
);

--Conecto cine a ciudad
ALTER TABLE Cine
ADD id_ciudad INT, 
CONSTRAINT FK_Cine_Ciudad FOREIGN KEY (id_ciudad) REFERENCES Ciudad(id_ciudad);

-- Agregar un conjunto de datos no estructurados en formato JSON, realizar operaciones de actualizaci�n, agregaci�n y borrado de datos.

INSERT INTO Ciudad (id_ciudad, nombre, detalles)
VALUES 
(1, 'Chaco', '{"clima": "subtropical", "poblacion": "1100000", "area": "99695 km�", "idioma": "Espa�ol", "pais": "Argentina"}'),
(2, 'Corrientes', '{"clima": "subtropical", "poblacion": "350000", "area": "88000 km�", "idioma": "Espa�ol", "pais": "Argentina"}'),
(3, 'Santa Fe', '{"clima": "templado", "poblacion": "3400000", "area": "133007 km�", "idioma": "Espa�ol", "pais": "Argentina"}');

INSERT INTO Ciudad (id_ciudad, nombre, detalles)
VALUES 
(4, 'Buenos Aires', '{"clima": "templado", "poblacion": "3050000", "area": "203 km²", "idioma": "Español", "pais": "Argentina"}'),
(5, 'Córdoba', '{"clima": "subtropical", "poblacion": "1350000", "area": "576 km²", "idioma": "Español", "pais": "Argentina"}'),
(6, 'Rosario', '{"clima": "templado", "poblacion": "1190000", "area": "178 km²", "idioma": "Español", "pais": "Argentina"}'),
(7, 'Mendoza', '{"clima": "semiárido", "poblacion": "1040000", "area": "57 km²", "idioma": "Español", "pais": "Argentina"}'),
(8, 'La Plata', '{"clima": "templado", "poblacion": "740000", "area": "940 km²", "idioma": "Español", "pais": "Argentina"}'),
(9, 'San Miguel de Tucumán', '{"clima": "subtropical", "poblacion": "800000", "area": "90 km²", "idioma": "Español", "pais": "Argentina"}'),
(10, 'Salta', '{"clima": "templado", "poblacion": "620000", "area": "60 km²", "idioma": "Español", "pais": "Argentina"}');

-- Operaciones de Actualizacion
UPDATE Ciudad
SET detalles = JSON_MODIFY(detalles, '$.clima', '�rido')
WHERE nombre = 'Santa Fe';

UPDATE Ciudad
SET detalles = JSON_MODIFY(detalles, '$.poblacion', '440000')
WHERE nombre = 'Corrientes';

-- Operacion de Agregado
UPDATE Ciudad
SET detalles = JSON_MODIFY(detalles, '$.superficie_urbana', '80%')
WHERE nombre IN ('Chaco', 'Corrientes', 'Santa Fe');


--Operaci�n de Borrado de Datos
UPDATE Ciudad
SET detalles = JSON_MODIFY(detalles, '$.superficie_urbana', NULL)
WHERE nombre = 'Chaco';

-- Realizar operaciones de consultas.

SELECT * FROM Ciudad

SELECT nombre, JSON_VALUE(detalles, '$.clima') AS clima --Consulta el clima dentro de detalles
FROM Ciudad;

SELECT nombre, JSON_VALUE(detalles, '$.poblacion') AS poblacion -- Consulta la poblacion dentro de detalles
FROM Ciudad
WHERE JSON_VALUE(detalles, '$.poblacion') < 1000000;

SELECT nombre, 
    JSON_VALUE(detalles, '$.clima') AS clima,
    JSON_VALUE(detalles, '$.poblacion') AS poblacion
FROM Ciudad;


-- Comparación de Optimización 
CREATE TABLE Ciudad2 (
    id_ciudad INT NOT NULL,
	nombre VARCHAR(100),
	clima VARCHAR(100),
	poblacion VARCHAR(100),
	area VARCHAR(100),
	idioma VARCHAR(100),
	pais VARCHAR(100),
	CONSTRAINT PK_Ciudad2 PRIMARY KEY (id_ciudad)
);

ALTER TABLE Cine
ADD id_ciudad2 INT, 
CONSTRAINT FK_Cine_Ciudad2 FOREIGN KEY (id_ciudad2) REFERENCES Ciudad2(id_ciudad);

INSERT INTO Ciudad2 (id_ciudad, nombre, clima, poblacion, area, idioma, pais) VALUES
(1, 'Buenos Aires', 'Templado', '3050000', '203 km²', 'Español', 'Argentina'),
(2, 'Córdoba', 'Subtropical', '1350000', '576 km²', 'Español', 'Argentina'),
(3, 'Rosario', 'Templado', '1190000', '178 km²', 'Español', 'Argentina'),
(4, 'Mendoza', 'Semiárido', '1040000', '57 km²', 'Español', 'Argentina'),
(5, 'La Plata', 'Templado', '740000', '940 km²', 'Español', 'Argentina'),
(6, 'Chaco', 'Subtropical', '1100000', '562 km²', 'Español', 'Argentina'),
(7, 'Corrientes', 'Subtropical', '350000', '500 km²', 'Español', 'Argentina'),
(8, 'Salta', 'Templado', '620000', '60 km²', 'Español', 'Argentina'),
(9, 'Santa Fe', 'Templado', '3400000', '268 km²', 'Español', 'Argentina');

SELECT * FROM Ciudad2
SELECT * FROM Cine

INSERT INTO Cine (id_cine, nombre, direccion, id_ciudad, id_ciudad2) VALUES
(2, 'Showcase Cinemas', 'Calle Corrientes 5678', 7, NULL),
(3, 'Hoyts', 'Boulevard San Juan 4321', 5, NULL),
(4, 'Cinemark', 'Avenida Rivadavia 1357', 1, NULL),
(5, 'Village Cines', 'Calle Córdoba 7654', 3, NULL),
(6, 'Multiplex', 'Av. Libertador 9876', 6, NULL),
(7, 'Cinema Center', 'Calle San Martín 2468', 9, NULL),
(8, 'Atlas Cines', 'Av. Belgrano 1358', 4, NULL),
(9, 'Cine Teatro', 'Boulevard Mitre 2546', 8, NULL),
(10, 'Cine Monumental', 'Av. Sarmiento 1358', NULL, 1),
(11, 'Cinepolis', 'Av. Las Heras 1234', 2, NULL);

INSERT INTO Cine (id_cine, nombre, direccion, id_ciudad, id_ciudad2) VALUES
(12, 'Cine Lumiere', 'Calle Belgrano 3456', NULL, 2),
(13, 'Cinemundo', 'Av. 3 de Abril 7890', NULL, 7),
(14, 'Cinema XXI', 'Ruta Nacional 9 km 123', NULL, 5),
(15, 'Cine Premier', 'Av. Rivadavia 3210', 1, NULL),
(16, 'Palacio del Cine', 'Calle San Juan 6543', 3, NULL),
(17, 'Cine Planet', 'Av. Santa Fe 1122', 6, NULL),
(18, 'Cinema Park', 'Calle Bolívar 123', NULL, 9),
(19, 'MegaCine', 'Av. Independencia 4567', NULL, 4),
(20, 'Gran Cine', 'Boulevard Mitre 999', 8, NULL),
(21, 'Star Cinema', 'Av. 9 de Julio 5678', NULL, 1);

INSERT INTO Cine (id_cine, nombre, direccion, id_ciudad, id_ciudad2) VALUES
(22, 'Cine Aurora', 'Calle Las Flores 123', NULL, 3),
(23, 'Cinema Estelar', 'Av. Libertad 456', 2, NULL),
(24, 'Cine Fantasía', 'Boulevard Sol 789', NULL, 5),
(25, 'Cinemágico', 'Av. Luna 1011', 1, NULL),
(26, 'Cine Estrella', 'Calle Estrellas 1213', NULL, 6),
(27, 'Cine Maravilla', 'Boulevard Ilusión 1415', 4, NULL),
(28, 'Cine de Ensueño', 'Av. Sueños 1617', NULL, 8),
(29, 'Cinema Galaxy', 'Calle Estelar 1819', NULL, 9),
(30, 'Cine Cometa', 'Boulevard Espacial 2021', 3, NULL),
(31, 'Cine Astral', 'Av. Constelación 2223', NULL, 2),
(32, 'Cine Viajero', 'Calle Cometa 2425', NULL, 7),
(33, 'Cine Rayo', 'Boulevard Trueno 2627', 5, NULL),
(34, 'Cine Lluvia de Estrellas', 'Av. Lluvia 2829', NULL, 1),
(35, 'Cine Meteorito', 'Calle Meteor 3031', NULL, 4),
(36, 'Cinema Nebula', 'Boulevard Espacio 3233', 6, NULL),
(37, 'Cine Quásar', 'Av. Universo 3435', NULL, 8),
(38, 'Cine Estrella Fugaz', 'Calle Brillo 3637', 9, NULL),
(39, 'Cine Eclipse', 'Boulevard Eclipse 3839', NULL, 3),
(40, 'Cine Pulsar', 'Av. Pulso 4041', NULL, 2),
(41, 'Cine Nova', 'Calle Nueva 4243', 7, NULL),
(42, 'Cine Big Bang', 'Boulevard Expansión 4445', NULL, 5),
(43, 'Cine Galaxia', 'Av. Vía Láctea 4647', 1, NULL),
(44, 'Cine Supernova', 'Calle Brillante 4849', NULL, 6),
(45, 'Cine Estrella Roja', 'Boulevard Sangriento 5051', 4, NULL),
(46, 'Cine Cometa Halley', 'Av. Halley 5253', NULL, 8),
(47, 'Cine Nebulosa', 'Calle Nebula 5455', 9, NULL),
(48, 'Cine Cosmos', 'Boulevard Cósmico 5657', NULL, 3),
(49, 'Cine Vía Láctea', 'Av. Láctea 5859', NULL, 2),
(50, 'Cine Espacio Profundo', 'Calle Profundo 6061', 7, NULL),
(51, 'Cine Horizonte', 'Boulevard Horizonte 6263', NULL, 5),
(52, 'Cine Sideral', 'Av. Sideral 6465', 1, NULL),
(53, 'Cine Estelar', 'Calle Cosmos 6667', NULL, 6),
(54, 'Cine Galáctico', 'Boulevard Galáctico 6869', 4, NULL),
(55, 'Cine Astro', 'Av. Astro 7071', NULL, 8),
(56, 'Cine Universal', 'Calle Universo 7273', 9, NULL),
(57, 'Cine Espacial', 'Boulevard Espacial 7475', NULL, 3),
(58, 'Cine Intergaláctico', 'Av. Galaxia 7677', NULL, 2),
(59, 'Cine Orbital', 'Calle Órbita 7879', 7, NULL),
(60, 'Cine Viaje Estelar', 'Boulevard Viaje 8081', NULL, 5);

INSERT INTO Cine (id_cine, nombre, direccion, id_ciudad, id_ciudad2) VALUES
(61, 'Cine Espacio', 'Avenida Ficción 101', NULL, 7),
(62, 'Cine Estrella Azul', 'Boulevard Fantasía 202', 5, NULL),
(63, 'Cine Galaxia Lejana', 'Calle Órbita 303', NULL, 9),
(64, 'Cinema Mundo', 'Avenida Galáctica 404', 3, NULL),
(65, 'Cine Cometa Verde', 'Boulevard Lluvia 505', NULL, 2),
(66, 'Cine Solar', 'Calle Espacial 606', 1, NULL),
(67, 'Cine Viento Solar', 'Avenida Luna 707', NULL, 6),
(68, 'Cine Súper Estrella', 'Boulevard Estelar 808', 4, NULL),
(69, 'Cinema Intergaláctico', 'Calle Cometa 909', NULL, 8),
(70, 'Cine Cosmoso', 'Avenida Cósmica 1001', 9, NULL),
(71, 'Cine Viaje', 'Boulevard Interestelar 1102', NULL, 3),
(72, 'Cine Astronomía', 'Calle Neptuno 1203', 2, NULL),
(73, 'Cine Astro-Estrella', 'Avenida Saturno 1304', NULL, 7),
(74, 'Cine Rayo de Luna', 'Boulevard Júpiter 1405', 5, NULL),
(75, 'Cine Interplanetario', 'Calle Mercurio 1506', NULL, 4),
(76, 'Cine Galaxia Violeta', 'Avenida Venus 1607', 1, NULL),
(77, 'Cine Estrella Dorada', 'Boulevard Plutón 1708', NULL, 6),
(78, 'Cine Espacio Negro', 'Calle Cosmos 1809', 3, NULL),
(79, 'Cine Viaje Estrella', 'Avenida Saturno 1900', NULL, 2),
(80, 'Cine Estrella Verde', 'Boulevard Neptuno 2001', 4, NULL),
(81, 'Cine Supernovo', 'Calle Júpiter 2102', NULL, 5),
(82, 'Cine Eclipse Solar', 'Avenida Mercurio 2203', 6, NULL),
(83, 'Cine Cosmos Azul', 'Boulevard Venus 2304', NULL, 7),
(84, 'Cine Galaxia Negra', 'Calle Plutón 2405', 8, NULL),
(85, 'Cine Estrella Plateada', 'Avenida Neptuno 2506', NULL, 9),
(86, 'Cine Viajero Espacial', 'Boulevard Urano 2607', 1, NULL),
(87, 'Cine Estrella Brillante', 'Calle Satélite 2708', NULL, 2),
(88, 'Cine Cósmico', 'Avenida Espacio 2809', 3, NULL),
(89, 'Cine Estrella Rosa', 'Boulevard Asteroide 2901', NULL, 4),
(90, 'Cine Estrella Fugazetta', 'Calle Galaxia 3002', 5, NULL),
(91, 'Cine Estrella Doradinha', 'Avenida Cosmos 3103', NULL, 6),
(92, 'Cine Súper Nova', 'Boulevard Espacio 3204', 7, NULL),
(93, 'Cine Ashtral', 'Calle Estrella 3305', NULL, 8),
(94, 'Cinemax', 'Avenida Láctea 3406', 9, NULL),
(95, 'Cine Supernova 2', 'Boulevard Espacio 3507', NULL, 1),
(96, 'Cine Interestelar', 'Calle Viaje 3608', 2, NULL),
(97, 'Cine Sideralio', 'Avenida Espacio 3709', NULL, 3),
(98, 'Cine Estrello Roja', 'Boulevard Vía Láctea 3801', 4, NULL),
(99, 'Cine Estrelli Verde', 'Calle Cosmos 3902', NULL, 5),
(100, 'Cine Cósmicou', 'Avenida Láctea 4003', 6, NULL);


INSERT INTO Sala (id_sala, nombre, capacidad, id_cine, estado) VALUES
(3, 'SALA 3', 60, 2, 1),
(4, 'SALA 4', 75, 2, 1),
(5, 'SALA 5', 90, 3, 1),
(6, 'SALA 6', 120, 3, 1),
(7, 'SALA 7', 110, 4, 1),
(8, 'SALA 8', 130, 4, 1),
(9, 'SALA 9', 140, 5, 1),
(10, 'SALA 10', 150, 5, 1),
(11, 'SALA 11', 160, 6, 1),
(12, 'SALA 12', 170, 6, 1),
(13, 'SALA 13', 180, 7, 1),
(14, 'SALA 14', 190, 7, 1);

INSERT INTO Sala (id_sala, nombre, capacidad, id_cine, estado) VALUES
(15, 'Sala 15', 100, 10, 1),
(16, 'Sala 16', 120, 10, 1),
(17, 'Sala 17', 80, 12, 1),
(18, 'Sala 18', 150, 12, 1),
(19, 'Sala 19', 200, 13, 1),
(20, 'Sala 20', 100, 13, 1),
(21, 'Sala 21', 90, 14, 1),
(22, 'Sala 22', 110, 14, 1),
(23, 'Sala 23', 130, 15, 1),
(24, 'Sala 24', 140, 15, 1),
(25, 'Sala 25', 160, 16, 1),
(26, 'Sala 26', 180, 16, 1),
(27, 'Sala 27', 150, 17, 1),
(28, 'Sala 28', 170, 17, 1),
(29, 'Sala 29', 200, 18, 1),
(30, 'Sala 30', 220, 18, 1),
(31, 'Sala 31', 190, 19, 1),
(32, 'Sala 32', 210, 19, 1),
(33, 'Sala 33', 100, 21, 1),
(34, 'Sala 34', 120, 21, 1);





-- CONSULTA SIMPLE
SET STATISTICS TIME ON;
SET STATISTICS IO ON;

SELECT nombre, 
    JSON_VALUE(detalles, '$.clima') AS clima,
    JSON_VALUE(detalles, '$.poblacion') AS poblacion
FROM Ciudad;

SELECT nombre, clima, poblacion FROM Ciudad2

SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;

-- CONSULTAS CON JOIN 
SET STATISTICS TIME ON;
SET STATISTICS IO ON;

SELECT c.*
FROM Cine c 
JOIN Ciudad2 cd ON c.id_ciudad2 = cd.id_ciudad
JOIN Sala s ON c.id_cine = s.id_cine
WHERE CAST(cd.poblacion AS INT) > 100000 AND cd.clima LIKE '%Templado%' AND s.capacidad > 20

SELECT 
	c.*
FROM Cine c 
JOIN Ciudad cd ON c.id_ciudad = cd.id_ciudad
JOIN Sala s ON c.id_cine = s.id_cine
WHERE JSON_VALUE(detalles, '$.poblacion') > 100000 AND JSON_VALUE(detalles, '$.clima') LIKE '%Templado%' AND s.capacidad > 20

SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;

















