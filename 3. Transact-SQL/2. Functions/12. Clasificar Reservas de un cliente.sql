-- 3.2 Clasificar las reservas de un cliente segun su cantidad
CREATE OR ALTER FUNCTION DJRL.fn_ClasificarReservasCliente
(
    @id_cliente INT
)
RETURNS @Resultado TABLE
(
    id_cliente        INT,
    cantidad_reservas INT,
    clasificacion     VARCHAR(20)
)
AS
BEGIN
    DECLARE @cantidad INT;
    DECLARE @clasificacion VARCHAR(20);

    SELECT @cantidad = COUNT(*)
    FROM DJRL.reserva
    WHERE id_cliente = @id_cliente;

    SET @cantidad = ISNULL(@cantidad, 0);

    IF @cantidad >= 10
        SET @clasificacion = 'VIP';
    ELSE IF @cantidad BETWEEN 5 AND 9
        SET @clasificacion = 'Frecuente';
    ELSE IF @cantidad BETWEEN 1 AND 4
        SET @clasificacion = 'Regular';
    ELSE
        SET @clasificacion = 'Nuevo';

    INSERT INTO @Resultado (id_cliente, cantidad_reservas, clasificacion)
    VALUES (@id_cliente, @cantidad, @clasificacion);

    RETURN;
END;
GO

-- Prueba:
SELECT 
    cl.id_persona AS id_cliente,
    DJRL.fn_NombreCompletoPersona(cl.id_persona) AS nombre_cliente,
    f.cantidad_reservas,
    f.clasificacion,
    GETDATE() AS fecha_consulta
FROM DJRL.cliente cl
CROSS APPLY DJRL.fn_ClasificarReservasCliente(cl.id_persona) f
ORDER BY f.cantidad_reservas DESC;