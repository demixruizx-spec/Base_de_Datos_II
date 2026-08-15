-- 3.4 Reporte de clientes frecuentes
-- Paso 1: reservas por cliente | Paso 2: pagos por cliente | Paso 3: clasificacion
CREATE OR ALTER FUNCTION DJRL.fn_ReporteClientesFrecuentes
(
    @dummy BIT = 1
)
RETURNS @Reporte TABLE
(
    id_cliente        INT,
    nombre_completo    VARCHAR(300),
    cantidad_reservas  INT,
    total_pagado       DECIMAL(12,2),
    clasificacion      VARCHAR(20)
)
AS
BEGIN
    DECLARE @Reservas TABLE (id_cliente INT, cantidad_reservas INT);
    DECLARE @Pagos    TABLE (id_cliente INT, total_pagado DECIMAL(12,2));

    -- Paso 1: obtenemos las reservas por cliente
    INSERT INTO @Reservas
    SELECT id_cliente, COUNT(*)
    FROM DJRL.reserva
    GROUP BY id_cliente;

    -- Paso 2: calculamos los pagos por cliente
    INSERT INTO @Pagos
    SELECT r.id_cliente, SUM(p.monto)
    FROM DJRL.reserva r
    INNER JOIN DJRL.pago p ON p.id_reserva = r.id_reserva
    GROUP BY r.id_cliente;

    -- Paso 3: clasificamos y consolidamos el reporte
    INSERT INTO @Reporte
    SELECT
        res.id_cliente,
        DJRL.fn_NombreCompletoPersona(res.id_cliente),
        res.cantidad_reservas,
        ISNULL(pag.total_pagado, 0),
        CASE
            WHEN res.cantidad_reservas >= 10 THEN 'VIP'
            WHEN res.cantidad_reservas BETWEEN 3 AND 9 THEN 'Frecuente'
            WHEN res.cantidad_reservas BETWEEN 1 AND 2 THEN 'Regular'
            ELSE 'Nuevo'
        END
    FROM @Reservas res
    LEFT JOIN @Pagos pag ON pag.id_cliente = res.id_cliente;

    RETURN;
END;
GO

-- Prueba:
SELECT *,GETDATE() AS fecha_consulta
FROM DJRL.fn_ReporteClientesFrecuentes(DEFAULT) ORDER BY cantidad_reservas DESC;
