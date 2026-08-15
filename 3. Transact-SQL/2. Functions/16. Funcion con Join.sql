-- 3.6 Utilizar la funcion en un JOIN (CROSS APPLY)
-- Lista todos los clientes junto con el detalle de cada una de sus reservas,
SELECT
    c.id_persona                                   AS id_cliente,
    DJRL.fn_NombreCompletoPersona(c.id_persona)     AS nombre_cliente,
    f.id_reserva,
    f.codigo_reserva,
    f.fecha_inicio,
    f.fecha_fin,
    f.precio_total,
    f.estado_reserva
FROM DJRL.cliente c
CROSS APPLY DJRL.fn_ReservasClienteEstadoOpcional(c.id_persona, NULL) f
ORDER BY c.id_persona, f.fecha_inicio;
GO