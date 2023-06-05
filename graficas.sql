USE MASTER
GO
USE db_Lancetilla
GO
--*********************************************************************GRAFICOS*******************************************************************************--
CREATE OR ALTER PROCEDURE zool.UDP_tbMantenimientoAnimal_Grafica  
@maan_FechaInicio NVARCHAR(100),
@maan_FechaFinal NVARCHAR(100)
AS BEGIN
DECLARE @FechaInicio DATE;
DECLARE @FechaFinal DATE;

-- Convertir las variables de tipo string a tipo Date
SET @FechaInicio = CONVERT(DATE, @maan_FechaInicio, 23);
SET @FechaFinal = CONVERT(DATE, @maan_FechaFinal, 23);

SELECT COUNT(T1.maan_Id) as conteo, T1.anim_Id, T2.anim_Nombre
FROM mant.tbMantenimientoAnimal T1 
INNER JOIN zool.tbAnimales T2
ON T1.anim_Id = T2.anim_Id
WHERE maan_Fecha BETWEEN @FechaInicio AND @FechaFinal
GROUP BY T1.anim_Id, T2.anim_Nombre
END
GO






CREATE OR ALTER PROC bota.UDP_tbCuidadosPorPlantas_Grafica
AS BEGIN
SELECT COUNT(T1.cupl_Id) as conteo, T1.plan_Id, T3.tipl_NombreComun
FROM bota.tbCuidadoPlanta T1 
INNER JOIN bota.tbPlantas T2
ON T1.plan_Id = T2.plan_Id
INNER JOIN bota.tbTiposPlantas T3
ON T2.tipl_Id = T3.tipl_Id
GROUP BY T1.plan_Id, T3.tipl_NombreComun;
END
--*********************************************************************GRAFICOS*******************************************************************************--