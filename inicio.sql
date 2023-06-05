USE MASTER
GO
USE db_Lancetilla
GO


CREATE OR ALTER PROC fact.UDP_tbFacturas_ConteoZoologico
AS BEGIN
SELECT SUM(fade_Cantidad) AS conteo
FROM fact.tbFacturasDetalles T1
INNER JOIN fact.tbFacturas T2 ON T1.fact_Id = T2.fact_Id
WHERE tick_Id = 1 AND T2.fact_Fecha BETWEEN '2023-01-01' AND '2023-06-30';
END
GO


CREATE OR ALTER PROC fact.UDP_tbFacturas_ConteoBotanica
AS BEGIN
SELECT SUM(fade_Cantidad) AS conteo
FROM fact.tbFacturasDetalles T1
INNER JOIN fact.tbFacturas T2 ON T1.fact_Id = T2.fact_Id
WHERE tick_Id = 2 AND T2.fact_Fecha BETWEEN '2023-01-01' AND '2023-06-30';
END
GO


CREATE OR ALTER PROC mant.UDP_tbMantenimientosAnimal_Conteo
AS BEGIN
SELECT TOP 1 COUNT(*) AS conteo, anim_Nombre FROM mant.tbMantenimientoAnimal T1
INNER JOIN zool.tbAnimales T2 ON T1.anim_Id = T2.anim_Id
GROUP BY T1.anim_Id, anim_Nombre
ORDER BY COUNT(*) ASC
END
GO

CREATE OR ALTER PROC zool.UDP_tbAreasZoologico_Conteo
AS BEGIN

SELECT TOP 1 COUNT(*) AS conteo, arzo_Descripcion
	   FROM zool.tbAreasZoologico T1 
	   INNER JOIN zool.tbAnimales T2
	   ON T1.arzo_Id = T2.arzo_Id
	   GROUP BY T1.arzo_Id, arzo_Descripcion
	   ORDER BY T1.arzo_Id ASC
END

