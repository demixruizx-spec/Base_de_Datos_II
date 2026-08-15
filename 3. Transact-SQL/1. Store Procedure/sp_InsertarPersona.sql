CREATE OR ALTER PROCEDURE DJRL.sp_InsertarPersona
(
    @tipo_persona     CHAR(1),
    @nombres          VARCHAR(100) = NULL,
    @apaterno         VARCHAR(100) = NULL,
    @amaterno         VARCHAR(100) = NULL,
    @razon_social     VARCHAR(150) = '',
    @id_tipo_documento INT,
    @numero_documento VARCHAR(20),
    @telefono         VARCHAR(20)  = NULL,
    @email            VARCHAR(150) = NULL,
    @id_nacionalidad  INT = 1
)
AS
BEGIN
    INSERT INTO DJRL.persona (tipo_persona, nombres, apaterno, amaterno, razon_social, id_tipo_documento, numero_documento, telefono, email, id_nacionalidad)
    VALUES (@tipo_persona, @nombres, @apaterno, @amaterno, @razon_social, @id_tipo_documento, @numero_documento, @telefono, @email, @id_nacionalidad);
END;
GO
-- Prueba:
EXEC DJRL.sp_InsertarPersona @tipo_persona = 'N', @nombres = 'Ana', @apaterno = 'Torres', @id_tipo_documento = 1, @numero_documento = '87654321';
