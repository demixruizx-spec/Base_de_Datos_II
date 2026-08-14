 --2.3 Pagos por rango de fechas
CREATE OR ALTER FUNCTION DJRL.fn_PagosPorRangoFechas
(
    @fecha_inicio DATETIME,
    @fecha_fin    DATETIME
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        p.id_pago,
        p.id_reserva,
        p.monto,
        p.fecha_pago,
        mp.nombre AS medio_pago,
        p.estado
    FROM DJRL.pago p
    INNER JOIN DJRL.medio_pago mp ON mp.id_medio_pago = p.id_medio_pago
    WHERE p.fecha_pago BETWEEN @fecha_inicio AND @fecha_fin
);
GO

-- Prueba:
SELECT *, 
    GETDATE() AS Fecha_Consulta
	FROM DJRL.fn_PagosPorRangoFechas('2026-01-01','2026-12-31');
