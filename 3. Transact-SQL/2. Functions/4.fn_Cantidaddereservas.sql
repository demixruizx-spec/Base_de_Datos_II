
-- 1.4 Cantidad de reservas por cliente
CREATE OR ALTER FUNCTION DJRL.fn_CantidadReservasCliente
(
    @id_cliente INT
)
RETURNS INT
AS
BEGIN
    DECLARE @cantidad INT;

    SELECT @cantidad = COUNT(*)
    FROM DJRL.reserva
    WHERE id_cliente = @id_cliente;

    RETURN ISNULL(@cantidad, 0);
END;
GO

-- Prueba:
SELECT 
    1 AS IdCliente,
    DJRL.fn_CantidadReservasCliente(1) AS CantidadReservas,
    GETDATE() AS FechaConsulta;