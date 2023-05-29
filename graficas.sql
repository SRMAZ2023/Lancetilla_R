USE MASTER
GO
USE db_Lancetilla
GO

CREATE OR ALTER PROC bota.UDP_tbPlantas_Grafica
AS BEGIN

SELECT TOP 5 
	   T2.arbo_Descripcion, 
		COUNT(*) as cantidad
		FROM bota.tbPlantas T1 
		INNER JOIN bota.tbAreasBotanicas T2
		ON T1.arbo_Id = T2.arbo_Id
GROUP BY arbo_Descripcion

END
GO

CREATE OR ALTER PROC zool.UDP_tbAnimales_Grafica
AS BEGIN

SELECT TOP 5 
	   arzo_Descripcion, 
	   COUNT(*) as cantidad 
	   FROM zool.tbAnimales T1 
	   INNER JOIN zool.tbAreasZoologico T2
	   ON T1.arzo_Id = T2.arzo_Id
GROUP BY arzo_Descripcion
ORDER BY COUNT(*) DESC

END
GO


CREATE OR ALTER PROC mant.UDP_tbVisitantes_Grafica
AS BEGIN

SELECT  visi_Sexo, 
		CASE visi_Sexo 
		WHEN 'F' THEN 'Femenino'
		WHEN 'M' THEN 'Masculino'
		ELSE 'Otro' END visi_Sexos, 
		COUNT(*) cantidad
		FROM mant.tbVisitantes
GROUP BY visi_Sexo

END
GO


CREATE OR ALTER PROC zool.UDP_tbAnimales_AnimalesHabitatGrafica
AS BEGIN

SELECT TOP 5
	   habi_Descripcion,
	   COUNT(anim_Id) as cantidad
	   FROM zool.tbAnimales T1
	   INNER JOIN zool.tbHabitat T2 
	   ON T1.habi_Id = T2.habi_Id
GROUP BY habi_Descripcion
ORDER BY COUNT(anim_Id) DESC

END
GO

CREATE OR ALTER PROC zool.UDP_tbAnimales_FIND 
@anim_Id INT
AS BEGIN

SELECT * FROM zool.VW_tbAnimales 
WHERE anim_Id = @anim_Id

END
GO


