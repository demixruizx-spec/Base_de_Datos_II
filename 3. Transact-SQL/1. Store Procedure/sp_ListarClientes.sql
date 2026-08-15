CREATE OR ALTER PROCEDURE DJRL.sp_ListarClientesResumen
AS
BEGIN
    SELECT cl.id_persona, DJRL.fn_NombreCompletoPersona(cl.id_persona) AS nombre_completo
    FROM DJRL.cliente cl;
END;
GO
-- Prueba:
EXEC DJRL.sp_ListarClientesResumen;
