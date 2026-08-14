-- 2.1 Reservas de un cliente
CREATE OR ALTER FUNCTION DJRL.fn_ReservasCliente
(
    @id_cliente INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        r.id_reserva,
        r.codigo_reserva,
        r.fecha_inicio,
        r.fecha_fin,
        r.numero_personas,
        r.precio_total,
        r.saldo_pendiente,
        er.nombre AS estado_reserva
    FROM DJRL.reserva r
    INNER JOIN DJRL.estado_reserva er ON er.id_estado_reserva = r.id_estado_reserva
    WHERE r.id_cliente = @id_cliente
);
GO

-- Prueba:
SELECT 
    *, 
    GETDATE() AS Fecha_Consulta 
FROM 
    DJRL.fn_ReservasCliente(1);