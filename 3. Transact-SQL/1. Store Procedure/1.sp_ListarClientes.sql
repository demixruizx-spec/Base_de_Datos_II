CREATE OR ALTER PROCEDURE DJRL.sp_ListarClientes
AS
BEGIN
    SELECT
        p.id_persona,
        p.nombres,
        p.apaterno,
        p.amaterno,
        p.numero_documento,
        p.telefono,
        p.email
    FROM DJRL.persona p
    INNER JOIN DJRL.cliente cl ON cl.id_persona = p.id_persona;
END;
GO

-- Prueba:
EXEC DJRL.sp_ListarClientes;
