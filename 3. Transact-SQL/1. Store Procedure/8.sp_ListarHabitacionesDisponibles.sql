CREATE OR ALTER PROCEDURE DJRL.sp_ListarHabitacionesDisponibles
AS
BEGIN
    SELECT id_habitacion, id_alojamiento, numero_habitacion, precio_noche
    FROM DJRL.habitacion
    WHERE estado = 'Disponible';
END;
GO
-- Prueba:
EXEC DJRL.sp_ListarHabitacionesDisponibles;
