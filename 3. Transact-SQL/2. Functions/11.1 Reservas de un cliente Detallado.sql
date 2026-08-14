-- 3.1 Reservas de un cliente 
CREATE OR ALTER FUNCTION DJRL.fn_ReservasClienteDetalle
(
    @id_cliente INT
)
RETURNS @Resultado TABLE
(
    id_reserva      INT,
    codigo_reserva  VARCHAR(20),
    fecha_inicio    DATE,
    fecha_fin       DATE,
    dias_estadia    INT,
    precio_total    DECIMAL(9,2),
    estado_reserva  VARCHAR(30)
)
AS
BEGIN
    INSERT INTO @Resultado
    SELECT
        r.id_reserva,
        r.codigo_reserva,
        r.fecha_inicio,
        r.fecha_fin,
        DATEDIFF(DAY, r.fecha_inicio, r.fecha_fin) AS dias_estadia,
        r.precio_total,
        er.nombre
    FROM DJRL.reserva r
    INNER JOIN DJRL.estado_reserva er ON er.id_estado_reserva = r.id_estado_reserva
    WHERE r.id_cliente = @id_cliente;

    RETURN;
END;
GO

-- Prueba:
SELECT *
, 
    GETDATE() AS Fecha_Consulta
FROM DJRL.fn_ReservasClienteDetalle(1);