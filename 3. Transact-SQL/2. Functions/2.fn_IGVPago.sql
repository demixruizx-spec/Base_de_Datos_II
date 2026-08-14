-- 1.2 Calcular el IGV de un pago (18%)
CREATE OR ALTER FUNCTION DJRL.fn_IGVPago
(
    @id_pago INT
)
RETURNS DECIMAL(9,2)
AS
BEGIN
    DECLARE @monto DECIMAL(9,2);

    SELECT @monto = monto
    FROM DJRL.pago
    WHERE id_pago = @id_pago;

    RETURN ISNULL(@monto, 0) * 0.18;
END;
GO

-- Prueba:
SELECT 
    -- 1. Identificadores y Relaciones
    p.id_pago,
    p.id_reserva,
    p.id_medio_pago,

    -- 2. Informaci�n del Comprobante y Estado
    p.comprobante,
    p.numero_operacion,
    p.estado,

    -- 3. Fechas del Registro y Auditor�a
    p.fecha_pago,
    GETDATE() AS Fecha_Consulta,

    -- 4. Desglose Financiero (Base + IGV + Total)
    p.monto AS Subtotal_Base,
    DJRL.fn_CalcularIGVPago(p.monto) AS IGV,
    (p.monto + DJRL.fn_CalcularIGVPago(p.monto)) AS Total_Con_IGV

FROM DJRL.pago p
WHERE p.monto >= 0             
ORDER BY p.id_pago DESC;