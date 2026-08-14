-- 2.4 Lugares turisticos por region

CREATE OR ALTER FUNCTION DJRL.fn_LugaresTuristicosPorRegion
(
    @id_region INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        lt.id_lugarturistico,
        lt.nombre,
        lt.calificacion,
        lt.precio_entrada,
        c.nombreciudad,
        reg.nombreregion
    FROM DJRL.lugar_turistico lt
    INNER JOIN DJRL.direccion_lugarturistico dlt ON dlt.id_lugarturistico = lt.id_lugarturistico
    INNER JOIN DJRL.direccion d  ON d.id_direccion = dlt.id_direccion
    INNER JOIN DJRL.ciudad c     ON c.id_ciudad = d.id_ciudad
    INNER JOIN DJRL.subregion sr ON sr.id_subregion = c.id_subregion
    INNER JOIN DJRL.region reg   ON reg.id_region = sr.id_region
    WHERE reg.id_region = @id_region
);
GO

-- Prueba:
 SELECT * , 
    GETDATE() AS Fecha_Consulta
	FROM DJRL.fn_LugaresTuristicosPorRegion(6);