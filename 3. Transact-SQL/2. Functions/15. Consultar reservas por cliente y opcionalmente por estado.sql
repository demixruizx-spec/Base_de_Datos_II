
-- 3.5 Consultar reservas por cliente y opcionalmente por estado
CREATE OR ALTER FUNCTION DJRL.fn_ReservasClienteEstadoOpcional
(
    @id_cliente         INT,
    @id_estado_reserva  INT = NULL
)
RETURNS @Resultado TABLE
(
    id_reserva      INT,
    codigo_reserva  VARCHAR(20),
    fecha_inicio    DATE,
    fecha_fin       DATE,
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
        r.precio_total,
        er.nombre
    FROM DJRL.reserva r
    INNER JOIN DJRL.estado_reserva er ON er.id_estado_reserva = r.id_estado_reserva
    WHERE r.id_cliente = @id_cliente
      AND (@id_estado_reserva IS NULL OR r.id_estado_reserva = @id_estado_reserva);

    RETURN;
END;
GO

-- Prueba (sin filtro de estado):
 SELECT 
    DJRL.fn_NombreCompletoPersona(1) AS nombre_cliente,
    f.id_reserva,
    f.codigo_reserva,
    f.fecha_inicio,
    f.fecha_fin,
    DATEDIFF(DAY, f.fecha_inicio, f.fecha_fin) AS dias_estadia,
    f.precio_total,
    f.estado_reserva,
    GETDATE() AS fecha_consulta
FROM DJRL.fn_ReservasClienteEstadoOpcional(1, NULL) f
ORDER BY f.fecha_inicio DESC;
-- Prueba (con filtro de estado):
 SELECT 
    DJRL.fn_NombreCompletoPersona(1) AS nombre_cliente,
    f.id_reserva,
    f.codigo_reserva,
    f.fecha_inicio,
    f.fecha_fin,
    DATEDIFF(DAY, f.fecha_inicio, f.fecha_fin) AS dias_estadia,
    f.precio_total,
    f.estado_reserva,
    CASE WHEN f.fecha_fin < CAST(GETDATE() AS DATE) THEN 'Vencida' ELSE 'Vigente' END AS estado_temporal,
    GETDATE() AS fecha_consulta
FROM DJRL.fn_ReservasClienteEstadoOpcional(1, 2) f
ORDER BY f.fecha_inicio DESC;