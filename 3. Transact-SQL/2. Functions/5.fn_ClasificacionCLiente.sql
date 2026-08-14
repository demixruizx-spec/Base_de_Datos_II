-- 1.5 Clasificación del cliente (según su cantidad de reservas)
CREATE OR ALTER FUNCTION DJRL.fn_ClasificacionCliente
(
    @id_cliente INT
)
RETURNS VARCHAR(20)
AS
BEGIN
    DECLARE @cantidad INT;
    SET @cantidad = DJRL.fn_CantidadReservasCliente(@id_cliente);

    RETURN CASE
        WHEN @cantidad > 10 THEN 'Cliente VIP'
        WHEN @cantidad > 5  THEN 'Cliente Frecuente'
        WHEN @cantidad >= 1 THEN 'Cliente Regular'
        ELSE 'Cliente Nuevo'
    END;
END;
GO

-- Prueba:
SELECT 
    1 AS IdCliente,
    DJRL.fn_CantidadReservasCliente(10) AS CantidadReservas,
    DJRL.fn_ClasificacionCliente(10) AS Clasificacion,
    GETDATE() AS FechaConsulta;