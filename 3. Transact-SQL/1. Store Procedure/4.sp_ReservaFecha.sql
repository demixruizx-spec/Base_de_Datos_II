CREATE OR ALTER PROCEDURE DJRL.sp_ReservaFecha
(
    @fecha_inicio DATE,
    @fecha_fin    DATE
)
AS
BEGIN
    SELECT r.id_reserva, r.codigo_reserva, r.id_cliente, r.fecha_inicio, r.fecha_fin, r.precio_total
    FROM DJRL.reserva r
    WHERE r.fecha_inicio BETWEEN @fecha_inicio AND @fecha_fin;
END;
GO
-- Prueba:
EXEC DJRL.sp_ReservaFecha @fecha_inicio = '2026-01-01', @fecha_fin = '2026-12-31';
