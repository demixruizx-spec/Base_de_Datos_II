
-- 2.2 Habitaciones por alojamiento
CREATE OR ALTER FUNCTION DJRL.fn_HabitacionesPorAlojamiento
(
    @id_alojamiento INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        h.id_habitacion,
        h.numero_habitacion,
        th.nombrehabitacion AS tipo_habitacion,
        h.precio_noche,
        h.estado
    FROM DJRL.habitacion h
    INNER JOIN DJRL.tipo_habitacion th ON th.id_tipo_habitacion = h.id_tipo_habitacion
    WHERE h.id_alojamiento = @id_alojamiento
);
GO

-- Prueba:
 SELECT * , 
    GETDATE() AS Fecha_Consulta
	FROM DJRL.fn_HabitacionesPorAlojamiento(1);