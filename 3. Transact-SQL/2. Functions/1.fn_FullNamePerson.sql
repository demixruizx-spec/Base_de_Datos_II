-- 1.1 Obtener el nombre completo de una persona
CREATE OR ALTER FUNCTION DJRL.fn_NombreCompletoPersona
(
    @id_persona INT
)
RETURNS VARCHAR(300)
AS
BEGIN
    DECLARE @nombre_completo VARCHAR(300);

    SELECT @nombre_completo =
        CASE
            WHEN tipo_persona = 'J' THEN ISNULL(razon_social, '')
            ELSE RTRIM(ISNULL(nombres,'') + ' ' + ISNULL(apaterno,'') + ' ' + ISNULL(amaterno,''))
        END
    FROM DJRL.persona
    WHERE id_persona = @id_persona;

    RETURN @nombre_completo;
END;
GO

-- Prueba:
SELECT 
    DJRL.fn_NombreCompletoPersona(1) AS NombreCompleto,
    GETDATE() AS FechaConsulta;
