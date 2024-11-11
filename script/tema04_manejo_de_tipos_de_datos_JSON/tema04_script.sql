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


--Optimización por indexación
ALTER TABLE Ciudad
ADD poblacion_calculada AS JSON_VALUE(detalles, '$.poblacion');

CREATE INDEX idx_poblacion ON Ciudad (poblacion_calculada);

SELECT id_ciudad, nombre, detalles
FROM Ciudad
WHERE JSON_VALUE(detalles, '$.poblacion') > 400000;






