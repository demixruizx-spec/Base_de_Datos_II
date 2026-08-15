CREATE OR ALTER PROCEDURE DJRL.sp_TotalPagos
AS
BEGIN
    SELECT SUM(monto) AS total_pagado
    FROM DJRL.pago;
END;
GO
-- Prueba:
EXEC DJRL.sp_TotalPagos;
