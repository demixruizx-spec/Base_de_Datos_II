CREATE OR ALTER PROCEDURE DJRL.sp_ClasificarPagos
AS
BEGIN
    SELECT estado, COUNT(*) AS cantidad, SUM(monto) AS total
    FROM DJRL.pago
    GROUP BY estado;
END;
GO
-- Prueba:
EXEC DJRL.sp_ClasificarPagos;
