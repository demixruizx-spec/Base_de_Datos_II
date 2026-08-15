CREATE OR ALTER PROCEDURE DJRL.sp_BuscarCliente
(
    @texto_busqueda VARCHAR(200)
)
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
    INNER JOIN DJRL.cliente cl ON cl.id_persona = p.id_persona
    WHERE p.nombres          LIKE '%' + @texto_busqueda + '%'
       OR p.apaterno         LIKE '%' + @texto_busqueda + '%'
       OR p.numero_documento LIKE '%' + @texto_busqueda + '%'
       OR p.email            LIKE '%' + @texto_busqueda + '%';
END;
GO

-- Prueba:
EXEC DJRL.sp_BuscarCliente @texto_busqueda = 'García';
EXEC DJRL.sp_BuscarCliente @texto_busqueda = 'juan.garcia@email.com';
