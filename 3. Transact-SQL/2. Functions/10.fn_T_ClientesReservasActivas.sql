
-- 2.5 Clientes con reservas activas

CREATE OR ALTER FUNCTION DJRL.fn_ClientesConReservasActivas
()
RETURNS TABLE
AS
RETURN
(
    SELECT 
        p.id_persona,
        DJRL.fn_NombreCompletoPersona(p.id_persona) AS nombre_completo,
        p.telefono,
        p.email,
        r.id_reserva,
        er.id_estado_reserva,
        er.nombre AS estado_reserva,
        r.fecha_inicio,
        r.fecha_fin
    FROM DJRL.persona p
    INNER JOIN DJRL.cliente cl 
        ON cl.id_persona = p.id_persona
    INNER JOIN DJRL.reserva r  
        ON r.id_cliente = cl.id_persona
    INNER JOIN DJRL.estado_reserva er 
        ON er.id_estado_reserva = r.id_estado_reserva
    WHERE er.id_estado_reserva NOT IN (4, 5, 6, 9, 11, 14, 15)
      AND r.fecha_fin >= CAST(GETDATE() AS DATE)
);
GO

-- Prueba:
 
	SELECT 
    id_persona,
    nombre_completo,
    telefono,
    id_reserva,
    estado_reserva,
    fecha_inicio,
    fecha_fin, 
    GETDATE() AS Fecha_Consulta
FROM DJRL.fn_ClientesConReservasActivas()
ORDER BY fecha_inicio ASC;