USE TicketSuit;

/*
Tareas: 

Realizar al menos tres procedimientos almacenados que permitan: 
Insertar, Modificar y borrar registros de alguna de las tablas del proyecto.
*/

---|------------------------------------|---
---|------------ INSERTS ---------------|---
---|------------------------------------|---

CREATE PROCEDURE InsertarCine
(
    @id_cine INT,
    @nombre VARCHAR(200),
    @direccion VARCHAR(200)
) AS BEGIN
    INSERT INTO Cine (id_cine, nombre, direccion)
    VALUES (@id_cine, @nombre, @direccion);
END;

CREATE PROCEDURE InsertarSala
(
	@id_sala INT,
	@nombre VARCHAR(200),
	@capacidad INT,
	@id_cine INT
) AS BEGIN
	DECLARE @estado INT;
	SET @estado = 1;

	INSERT INTO Sala (id_sala, nombre, capacidad, id_cine, estado) 
	VALUES (@id_sala, @nombre, @capacidad, @id_cine, @estado);
END;

CREATE PROCEDURE InsertarAsientos
(
	@id_sala INT,
	@cantidad_filas INT,
	@cantidad_columnas INT
) AS BEGIN

	DECLARE @letra CHAR(1);
    DECLARE @i INT;
	DECLARE @j INT;
	DECLARE @id INT;

    SET @i = 1;
	SET @j = 1;
	SET @id = 1;

    WHILE @j <= @cantidad_filas
    BEGIN
        SET @letra = CHAR(65 + @j - 1); 
        
        WHILE @i <= @cantidad_columnas
        BEGIN
            INSERT INTO Asiento (id_asiento, letra_fila, numero_columna, id_sala)
            VALUES (@id, @letra, @i, @id_sala);
            SET @i = @i + 1;
			SET @id = @id + 1;
        END
        SET @i = 1;
        SET @j = @j + 1;
    END
	UPDATE Sala SET capacidad = @cantidad_columnas * @cantidad_columnas;
END;

---|------------------------------------|---
---|------------ UPDATES ---------------|---
---|------------------------------------|---

CREATE PROCEDURE ModificarNombreSala
(
	@id_sala INT,
	@nombre VARCHAR(200)
) AS BEGIN
	UPDATE Sala 
	SET nombre = @nombre WHERE id_sala = @id_sala; 
END;

---|------------------------------------|---
---|------------ DELETES ---------------|---
---|------------------------------------|---

CREATE PROCEDURE EliminarSalaYAsientos
(
	@id_sala INT
) AS BEGIN
	DELETE FROM Asiento WHERE id_sala = @id_sala;
	DELETE FROM Sala WHERE id_sala = @id_sala;
END;

/*
Insertar un lote de datos en las tablas mencionadas (guardar el script) con sentencias insert y otro lote 
invocando a los procedimientos creados.
*/

---|------------------------------------|---
---|-------- SENTENCIA INSERT ----------|---
---|------------------------------------|---

INSERT INTO Cine (id_cine, nombre, direccion) VALUES (1, 'Cines Av. Armenia', 'Av. Armenia 1032');

INSERT INTO Sala (id_cine, id_sala, nombre, capacidad, estado) VALUES
(1, 1, 'Sala 1', 10, 1),
(1, 2, 'Sala 2', 8, 1)

INSERT INTO Asiento (id_asiento, letra_fila, numero_columna, id_sala) VALUES
(1, 'A', 1, 1),
(2, 'A', 2, 1),
(3, 'A', 3, 1),
(4, 'A', 4, 1),
(5, 'A', 5, 1),
(6, 'B', 1, 1),
(7, 'B', 2, 1),
(8, 'B', 3, 1),
(9, 'B', 4, 1),
(10, 'B', 5, 1)

INSERT INTO Asiento (id_asiento, letra_fila, numero_columna, id_sala) VALUES
(1, 'A', 1, 2),
(2, 'A', 2, 2),
(3, 'A', 3, 2),
(4, 'A', 4, 2),
(5, 'B', 1, 2),
(6, 'B', 2, 2),
(7, 'B', 3, 2),
(8, 'B', 4, 2),
(9, 'B', 5, 2)

---|------------------------------------|---
---|----------- PROCEDURES -------------|---
---|------------------------------------|---

EXEC InsertarSala 3, 'Sala 3', 25, 1;
EXEC InsertarSala 4, 'Sala 4', 10, 1;
EXEC InsertarAsientos 3, 4, 6;
EXEC InsertarAsientos 4, 5, 5;

SELECT * FROM Cine;
SELECT * FROM Sala;
SELECT * FROM Asiento;

--Realizar update y delete sobre algunos de los registros insertados en esas tablas invocando a los procedimientos.
EXEC ModificarNombreSala 1, 'SALA PRIVADA 1';
EXEC ModificarNombreSala 2, 'SALA PRIVADA 2';

EXEC EliminarSalaYAsientos 3;
EXEC EliminarSalaYAsientos 4;

--Desarrollar al menos tres funciones almacenadas

CREATE FUNCTION NombreSala (@id_sala INT)
	RETURNS VARCHAR(200)
	AS BEGIN
		DECLARE @nombreSala VARCHAR(200);
		SELECT @nombreSala = nombre FROM Sala WHERE id_sala = @id_sala;
		RETURN @nombreSala;
END;

CREATE FUNCTION CalcularTotalCompra (@id_compra INT)
	RETURNS FLOAT
	AS BEGIN
		DECLARE @total FLOAT;
		SELECT @total = cantidad * subtotal FROM Compra WHERE id_compra = @id_compra;
		RETURN @total;
END;

CREATE FUNCTION AsientoDisponible(
    @id_sala INT,
    @id_funcion INT,
    @letra_fila VARCHAR(2),
    @numero_columna INT
)
	RETURNS INT
	AS BEGIN
		DECLARE @disponible INT;

		IF EXISTS (
			SELECT 1
			FROM Ticket AS t
			JOIN Asiento AS a ON t.id_asiento = a.id_asiento AND t.id_sala = a.id_sala
			WHERE t.id_funcion = @id_funcion
			  AND a.id_sala = @id_sala
			  AND a.letra_fila = @letra_fila
			  AND a.numero_columna = @numero_columna
		)
		BEGIN
			SET @disponible = 0; 
		END
		ELSE
		BEGIN
			SET @disponible = 1;
		END

		RETURN @disponible;
END;
