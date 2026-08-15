CREATE OR ALTER PROCEDURE DJRL.sp_TotalReservas
AS
BEGIN
    SELECT COUNT(*) AS total_reservas
    FROM DJRL.reserva;
END;
GO
-- Prueba:
EXEC DJRL.sp_TotalReservas;
