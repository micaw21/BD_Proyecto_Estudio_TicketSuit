USE TicketSuit;

-- Realizar una carga masiva de por lo menos un millón de registros sobre alguna tabla que contenga un campo fecha (sin índice)
DECLARE @i INT = 1;
DECLARE @fechaInicio DATE = '2022-01-01';

WHILE @i <= 1000000 BEGIN
    INSERT INTO Compra (id_compra, subtotal, fecha, cantidad, id_usuario) VALUES (
        @i,                                   -- id_compra
        ROUND(RAND() * 500 + 50, 2),          -- subtotal aleatorio entre 50 y 550
        DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 1000, @fechaInicio), -- Fecha aleatoria
        ABS(CHECKSUM(NEWID())) % 5 + 1,       -- Cantidad entre 1 y 5
        2                                     -- id_usuario siempre 2
    ); SET @i += 1;
END;
-- No utiliza ni 1/8 de los recursos de la maquina disponibles (CPU, RAM, Disco), por lo cual el tiempo de ingreso se datos se ve limitado a lo que puede manejar SSMS. Tiempo en ejecutar script de ingreso de 1 millon de datos: 3:40 Minutos

-- Realizar una búsqueda por periodo y registrar el plan de ejecución utilizado por el motor y los tiempos de respuesta
SET STATISTICS TIME ON;
SET STATISTICS IO ON;

SELECT *
FROM Compra
WHERE fecha BETWEEN '2022-06-01' AND '2023-12-30';
/* (578636 rows affected)
Table 'Compra'. Scan count 1, logical reads 3969, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 219 ms,  elapsed time = 2665 ms. */

SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;

SET SHOWPLAN_XML ON;
SET SHOWPLAN_XML OFF;

---- Crear índice agrupado sobre tabla Fecha y repetir consulta (Primero debemos eliminar el indice agrupado actual (PK_compra) y sus dependencias
ALTER TABLE Compra DROP CONSTRAINT PK_compra;
ALTER TABLE Ticket DROP CONSTRAINT FK_ticket_compra;
CREATE CLUSTERED INDEX IX_Compra_Fecha ON Compra(fecha);

SET STATISTICS TIME ON;
SET STATISTICS IO ON;

SELECT *
FROM Compra
WHERE fecha BETWEEN '2022-06-01' AND '2023-12-30';
/* 
(578636 rows affected)
Table 'Compra'. Scan count 1, logical reads 2876, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 187 ms,  elapsed time = 2687 ms. */

SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;

SET SHOWPLAN_XML ON;
SET SHOWPLAN_XML OFF;

-- borrar el indice creado
DROP INDEX IX_Compra_Fecha ON Compra;


-- Crear indice agrupado que incluya columnas adicionales (Debido a que es imposible crear un indice agrupado con diversas columnas, realizo lo mas cercano, un indice no agrupado que incluya dichas columnas)
CREATE NONCLUSTERED INDEX IX_Compra_Fecha_Includes
ON Compra (fecha)
INCLUDE (subtotal, cantidad);

-- Repetir la consulta
SET STATISTICS TIME ON;
SET STATISTICS IO ON;

SELECT *
FROM Compra
WHERE fecha BETWEEN '2022-06-01' AND '2023-12-30';
/* (578636 rows affected)
Table 'Compra'. Scan count 1, logical reads 4951, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 282 ms,  elapsed time = 2764 ms. */

SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;

SET SHOWPLAN_XML ON;
SET SHOWPLAN_XML OFF;

-- Extra: Indice agrupado de fecha + indice no agrupado de columnas incluidas

/* (578636 rows affected)
Table 'Compra'. Scan count 1, logical reads 2876, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 203 ms,  elapsed time = 2697 ms. */
