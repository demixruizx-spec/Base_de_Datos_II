CREATE OR ALTER PROCEDURE DJRL.sp_ListarPersonas
AS
BEGIN
    SELECT id_persona, tipo_persona, DJRL.fn_NombreCompletoPersona(id_persona) AS nombre_completo, telefono, email
    FROM DJRL.persona;
END;
GO
-- Prueba:
EXEC DJRL.sp_ListarPersonas;
