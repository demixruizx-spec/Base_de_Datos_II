CREATE OR ALTER PROCEDURE DJRL.sp_DisponibilidadHabitacion
(
    @id_habitacion INT
)
AS
BEGIN
    SELECT id_habitacion, numero_habitacion, estado
    FROM DJRL.habitacion
    WHERE id_habitacion = @id_habitacion;
END;
GO
-- Prueba:
EXEC DJRL.sp_DisponibilidadHabitacion @id_habitacion = 1;
