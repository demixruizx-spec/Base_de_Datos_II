-- 3.3 Funcion que recibe un alojamiento y devuelve informacion resumida de sus habitaciones
CREATE OR ALTER FUNCTION DJRL.fn_ResumenHabitacionesAlojamiento
(
    @id_alojamiento INT
)
RETURNS @Resumen TABLE
(
    id_alojamiento           INT,
    nombre_alojamiento       VARCHAR(100),
    total_habitaciones       INT,
    habitaciones_disponibles INT,
    habitaciones_ocupadas    INT,
    precio_promedio          DECIMAL(9,2),
    precio_minimo            DECIMAL(9,2),
    precio_maximo            DECIMAL(9,2)
)
AS
BEGIN
    DECLARE @nombre VARCHAR(100);

    SELECT @nombre = Nombre
    FROM DJRL.alojamiento
    WHERE id_alojamiento = @id_alojamiento;

    INSERT INTO @Resumen
    SELECT
        @id_alojamiento,
        @nombre,
        COUNT(*),
        SUM(CASE WHEN estado = 'Disponible' THEN 1 ELSE 0 END),
        SUM(CASE WHEN estado = 'Ocupada' THEN 1 ELSE 0 END),
        AVG(precio_noche),
        MIN(precio_noche),
        MAX(precio_noche)
    FROM DJRL.habitacion
    WHERE id_alojamiento = @id_alojamiento;

    RETURN;
END;
GO

-- Prueba:

SELECT 
    a.id_alojamiento,
    a.Nombre AS nombre_alojamiento,
    ISNULL(COUNT(h.id_habitacion), 0) AS total_habitaciones,
    ISNULL(SUM(CASE WHEN h.estado = 'Disponible' THEN 1 ELSE 0 END), 0) AS habitaciones_disponibles,
    ISNULL(SUM(CASE WHEN h.estado = 'Ocupada' THEN 1 ELSE 0 END), 0) AS habitaciones_ocupadas,
    ISNULL(ROUND(AVG(h.precio_noche), 2), 0) AS precio_promedio,
    ISNULL(MIN(h.precio_noche), 0) AS precio_minimo,
    ISNULL(MAX(h.precio_noche), 0) AS precio_maximo,
    GETDATE() AS fecha_consulta
FROM DJRL.alojamiento a
LEFT JOIN DJRL.habitacion h ON h.id_alojamiento = a.id_alojamiento - 29
GROUP BY a.id_alojamiento, a.Nombre
ORDER BY a.id_alojamiento;