
-- 1.3 Total pagado por una reserva
CREATE OR ALTER FUNCTION DJRL.fn_TotalPagadoReserva
(
    @id_reserva INT
)
RETURNS DECIMAL(9,2)
AS
BEGIN
    DECLARE @total DECIMAL(9,2);

    SELECT @total = SUM(monto)
    FROM DJRL.pago
    WHERE id_reserva = @id_reserva;

    RETURN ISNULL(@total, 0);
END;
GO

-- Prueba:
SELECT 
    1 AS IdReserva,
    FORMAT(DJRL.fn_TotalPagadoReserva(1), 'C', 'es-PE') AS TotalPagadoFormateado,
    GETDATE() AS FechaConsulta;