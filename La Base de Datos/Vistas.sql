USE MASTER 
GO
USE db_Lancetilla
GO

--************************************************************************************************************************************************************--

--**************************************************************INSERT DE ACCESO******************************************************************************--

--*************************************************************TABLA DE USUARIOS******************************************************************************--
CREATE OR ALTER VIEW acce.VW_tbUsuarios
AS 

SELECT T1.usua_Id, 
	   T1.usua_NombreUsuario, 
	   T1.empl_Id, 
	   empl_Nombre + ' ' + empl_Apellido AS empl_Nombre,
	   T1.usua_Clave,
	   T3.role_Id, 
	   role_Descripcion,
	   T1.usua_Admin, 
	   CASE T1.usua_Admin WHEN 1 THEN 'S�'
	   ELSE 'No' END AS usua_EsAdmin,
	   usua_UserCreaNombre = T4.usua_NombreUsuario,
	   T1.usua_UserCreacion, 
	   T1.usua_FechaCreacion, 
	   usua_UserModiNombre = T5.usua_NombreUsuario,
	   T1.usua_UserModificacion, 
	   T1.usua_FechaModificacion, 
	   T1.usua_Estado 
	   FROM acce.tbUsuarios T1
	   INNER JOIN mant.tbEmpleados T2
	   ON T1.empl_Id = T2.empl_Id
	   INNER JOIN acce.tbRoles T3
	   ON T1.role_Id = T3.role_Id
	   INNER JOIN acce.tbUsuarios T4
	   ON T1.usua_Id = T4.usua_Id
	   LEFT JOIN acce.tbUsuarios T5
	   ON T1.usua_Id = T5.usua_Id
	   WHERE T1.usua_Estado = 1;
GO
--************************************************************/TABLA DE USUARIOS******************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--**************************************************************TABLA DE ROLES********************************************************************************--
CREATE OR ALTER VIEW acce.VW_tbRoles
AS
SELECT role_Id, 
	   role_Descripcion,
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = role_UserCreacion)) AS usua_UserCreaNombre,
	   role_UserCreacion,
	   role_FechaCreacion,
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = role_UserModificacion)) AS usua_UserModiNombre,
	   role_UserModificacion,
	   role_FechaModificacion, 
	   role_Estado
	   FROM acce.tbRoles
	   WHERE role_Estado = 1;



GO
--*************************************************************/TABLA DE ROLES********************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*******************************************************TABLA DE ROLES POR PANTALLA**************************************************************************--
CREATE OR ALTER VIEW acce.VW_tbRolesPantalla_INDEX
AS 
SELECT ropa_Id, 
	   T1.role_Id, 
	   role_Descripcion,
	   T1.pant_Id,
	   pant_Descripcion,	   
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = ropa_UserCreacion)) AS usua_UserCreaNombre,
	   ropa_UserCreacion,
	   ropa_FechaCreacion,
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = ropa_UserModificacion)) AS usua_UserModiNombre,
	   ropa_UserModificacion,
	   ropa_FechaModificacion
	   FROM acce.tbRolesPantallas T1
	   INNER JOIN acce.tbPantallas T2
	   ON T1.pant_Id = T2.pant_Id
	   INNER JOIN acce.tbRoles T3
	   ON T1.role_Id = T3.role_Id

GO
--******************************************************/TABLA DE ROLES POR PANTALLA**************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*************************************************************/INSERT DE ACCESO******************************************************************************--


----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------


--***********************************************************INSERT DE MANTENIMIENTO**************************************************************************--

--***********************************************************TABLA DE DEPARTAMENTOS***************************************************************************--
CREATE OR ALTER VIEW mant.VW_tbDepartamentos
AS

SELECT  dept_Id, 
		dept_Descripcion, 
		(SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
		WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = dept_UserCreacion)) AS usua_UserCreaNombre,
		dept_UserCreacion, 
		dept_FechaCreacion, 
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
		WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = dept_UserModificacion)) AS usua_UserModiNombre,
		dept_UserModificacion, 
		dept_FechaModificacion, 
		dept_Estado 
		FROM mant.tbDepartamentos
		WHERE dept_Estado = 1;
GO
--**********************************************************/TABLA DE DEPARTAMENTOS***************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*************************************************************TABLA DE MUNICIPIOS****************************************************************************--
CREATE OR ALTER VIEW mant.VW_tbMunicipios
AS

SELECT muni_Id, 
	   muni_Descripcion, 
	   T1.dept_Id, 
	   dept_Descripcion,
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = muni_UserCreacion)) AS usua_UserCreaNombre,
	   muni_UserCreacion, 
	   muni_FechaCreacion, 
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = muni_UserModificacion)) AS usua_UserModiNombre,
	   muni_UserModificacion, 
	   muni_FechaModificacion, 
	   muni_Estado
       FROM mant.tbMunicipios T1
	   INNER JOIN mant.tbDepartamentos T2
	   ON T1.dept_Id = T2.dept_Id
	   WHERE muni_Estado = 1;
GO
--*************************************************************/TABLA DE MUNICIPIOS***************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--***********************************************************TABLA DE ESTADOS CIVILES*************************************************************************--
CREATE OR ALTER VIEW mant.VW_tbEstadosCiviles
AS 

SELECT  estc_Id, 
		estc_Descripcion, 
	    (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	    WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = estc_UserCreacion)) AS usua_UserCreaNombre,
		estc_UserCreacion,
		estc_FechaCreacion,
	    (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	    WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = estc_UserModificacion)) AS usua_UserModiNombre,
		estc_UserModificacion,
		estc_FechaModificacion,
		estc_Estado 
		FROM mant.tbEstadosCiviles
		WHERE estc_Estado = 1;

GO
--**********************************************************/TABLA DE ESTADOS CIVILES*************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--****************************************************************TABLA DE CARGOS*****************************************************************************--
CREATE OR ALTER VIEW mant.VW_tbCargos
AS 

SELECT carg_Id, 
       carg_Descripcion,
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = carg_UserCreacion)) AS usua_UserCreaNombre,
	   carg_UserCreacion, 
	   carg_FechaCreacion,
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = carg_UserModificacion)) AS usua_UserModiNombre,
	   carg_UserModificacion,
	   carg_FechaModificacion,
	   carg_Estado 
	   FROM mant.tbCargos
	   WHERE carg_Estado = 1;
GO
--***************************************************************/TABLA DE CARGOS*****************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--**************************************************************TABLA DE EMPLEADOS****************************************************************************--
CREATE OR ALTER VIEW mant.VW_tbEmpleados
AS 

SELECT empl_Id,
       empl_Nombre,
	   empl_Apellido,
	   empl_Identidad,
	   empl_FechaNacimiento,
	   empl_Direccion, 
	   empl_Sexo,
	   CASE empl_Sexo 
	   WHEN 'F' THEN 'Femenino'
	   WHEN 'M' THEN 'Masculino'
	   ELSE 'Otro' END AS empl_Sexos,
	   empl_Telefono,
	   T1.estc_Id, 
	   estc_Descripcion,
	   T1.carg_Id,
	   carg_Descripcion,
	   T1.muni_Id,
	   muni_Descripcion,
	   T5.dept_Id,
	   dept_Descripcion,
	   (SELECT MAX(empl_Nombre+' '+empl_ApellIdo) FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = empl_UserCreacion)) AS usua_UserCreaNombre,
	   empl_UserCreacion,
	   empl_FechaCreacion, 
	   (SELECT MAX(empl_Nombre+' '+empl_ApellIdo) FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = empl_UserModificacion)) AS usua_UserModiNombre,
	   empl_UserModificacion, 
	   empl_FechaModificacion, 
	   empl_Estado 
	   FROM mant.tbEmpleados T1
	   INNER JOIN mant.tbEstadosCiviles T2
	   ON T1.estc_Id = T2.estc_Id
	   INNER JOIN mant.tbCargos T3
	   ON T1.carg_Id = T3.carg_Id
	   INNER JOIN mant.tbMunicipios T4
	   ON T1.muni_Id = T4.muni_Id
	   INNER JOIN mant.tbDepartamentos T5
	    ON T4.dept_Id = T5.dept_Id
		WHERE empl_Estado = 1;
GO
--*************************************************************/TABLA DE EMPLEADOS****************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*************************************************************TABLA DE VISITANTES****************************************************************************--
CREATE OR ALTER VIEW mant.VW_tbVisitantes
AS 

SELECT visi_Id, 
       visi_Nombres + ' ' + visi_Apellido + ' RTN: ' + visi_RTN  AS visi_NombreCompleto, 
	   visi_Nombres,
	   visi_Apellido,
	   visi_RTN,
	   visi_Sexo,
	   CASE visi_Sexo WHEN 'F' THEN 'Femenino'
	   ELSE 'Masculino' END AS visi_Sexos,
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = visi_UserCreacion)) AS usua_UserCreaNombre,
	   visi_UserCreacion,
	   visi_FechaCreacion,
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = visi_UserModificacion)) AS usua_UserModiNombre,
	   visi_UserModificacion,
	   visi_FechaModificacion,
	   visi_Estado
	   FROM mant.tbVisitantes 
	   WHERE visi_Estado = 1;

GO
--************************************************************/TABLA DE VISITANTES****************************************************************************--

---------------------------------------------------------------------------------------------------------------------------------------------------------------

--**********************************************************TABLA DE TIPOS MANTENIMIENTO*********************************************************************--
CREATE OR ALTER VIEW mant.VW_tbTiposMantenimientos
AS

SELECT tima_Id, 
	   tima_Descripcion, 
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = tima_UserCreacion)) AS usua_UserCreaNombre,
	   tima_UserCreacion, 
	   tima_FechaCreacion,
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = tima_UserModificacion)) AS usua_UserModiNombre,
	   tima_UserModificacion,
	   tima_FechaModificacion,
	   tima_Estado
	   FROM mant.tbTiposMantenimientos 
	   WHERE tima_Estado =1;

GO
--**********************************************************TABLA DE TIPOS MANTENIMIENTO*********************************************************************--

---------------------------------------------------------------------------------------------------------------------------------------------------------------

--*************************************************************TABLA DE MANTENIMIENTO************************************************************************--
CREATE OR ALTER VIEW mant.VW_tbMantenimientos
AS

SELECT mant_Id, 
	   mant_Observaciones,
	   T1.tima_Id,
	   tima_Descripcion,
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = mant_UserCreacion)) AS usua_UserCreaNombre,
	   mant_UserCreacion, 
	   mant_FechaCreacion,
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = mant_UserModificacion)) AS usua_UserModiNombre,
	   mant_UserModificacion,
	   mant_FechaModificacion,
	   mant_Estado
	   FROM mant.tbMantenimientos  T1
	   INNER JOIN mant.tbTiposMantenimientos T2
	   ON T1.tima_Id = T2.tima_Id
	   WHERE mant_Estado = 1;


GO
--************************************************************/TABLA DE MANTENIMIENTO*************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*******************************************************TABLA DE MANTENIMIENTO POR ANIMAL********************************************************************--
GO
CREATE OR ALTER VIEW mant.VW_MantenimientoAnimales
AS 
SELECT maan_Id,
	   T1.anim_Id,
	   anim_Nombre,
       CASE
           WHEN TRY_CONVERT(datetime, maan_Fecha, 106) IS NOT NULL THEN CONVERT(varchar(10), TRY_CONVERT(datetime, maan_Fecha, 106), 105)
           WHEN TRY_CONVERT(datetime, maan_Fecha) IS NOT NULL THEN CONVERT(varchar(10), TRY_CONVERT(datetime, maan_Fecha), 105)
           ELSE 'Fecha inv�lida'
       END AS maan_Fecha,
	   T1.tima_Id,
	   t3.tima_Descripcion,
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = maan_UserCreacion)) AS usua_UserCreaNombre,
	   maan_UserCreacion,
	   maan_FechaCreacion,
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = maan_UserModificacion)) AS usua_UserModiNombre,
	   maan_UserModificacion,
	   maan_Estado,
	   maan_FechaModificacion
FROM mant.tbMantenimientoAnimal T1
INNER JOIN zool.tbAnimales T2 ON T1.anim_Id = T2.anim_Id
INNER JOIN mant.tbTiposMantenimientos T3 ON T1.tima_Id = T3.tima_Id
WHERE maan_Estado = 1;



GO
--******************************************************/TABLA DE MANTENIMIENTO POR ANIMAL********************************************************************--

--**********************************************************/INSERT DE MANTENIMIENTO**************************************************************************--


----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------


--***************************************************************INSERT DE ZOOLOGICO**************************************************************************--

--*****************************************************************TABLA DE �REAS*****************************************************************************--
CREATE OR ALTER VIEW zool.VW_tbAreasZoologico
AS 

SELECT arzo_Id, 
       arzo_Descripcion, 
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = arzo_UserCreacion)) AS usua_UserCreaNombre,
	   arzo_UserCreacion,
	   arzo_FechaCreacion,
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = arzo_UserModificacion)) AS usua_UserModiNombre,
	   arzo_UserModificacion,
	   arzo_FechaModificacion,
	   arzo_Estado 
       FROM zool.tbAreasZoologico
	   WHERE arzo_Estado = 1;
GO
--****************************************************************/TABLA DE �REAS*****************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--****************************************************************TABLA DE ESPECIES**************************************************************************--
CREATE OR ALTER VIEW zool.VW_tbEspecies
AS 

SELECT espe_Id, 
       espe_Descripcion, 
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = espe_UserCreacion)) AS usua_UserCreaNombre,
	   espe_UserCreacion,
	   espe_FechaCreacion,
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = espe_UserModificacion)) AS usua_UserModiNombre,
	   espe_UserModificacion, 
	   espe_FechaModificacion,
	   espe_Estado 
	   FROM zool.tbEspecies
	   WHERE espe_Estado = 1;

GO
--***************************************************************/TABLA DE ESPECIES**************************************************************************--

---------------------------------------------------------------------------------------------------------------------------------------------------------------

--***************************************************************TABLA DE H�BITATS***************************************************************************--
CREATE OR ALTER VIEW zool.VW_tbHabitat
AS 

SELECT habi_Id, 
	   habi_Descripcion, 
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = habi_UserCreacion)) AS usua_UserCreaNombre,
	   habi_UserCreacion,
	   habi_FechaCreacion,
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = habi_UserModificacion)) AS usua_UserModiNombre,
	   habi_UserModificacion, 
	   habi_FechaModificacion,
	   habi_Estado
	   FROM zool.tbHabitat
GO
--**************************************************************/TABLA DE H�BITATS***************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*****************************************************************TABLA DE RAZAS*****************************************************************************--
CREATE OR ALTER VIEW zool.VW_tbRazas
AS 

SELECT raza_Id,
	   raza_Descripcion,
	   raza_NombreCientifico,
	   T1.habi_Id,
	   habi_Descripcion,
	   T1.espe_Id,
	   espe_Descripcion,
	   T1.rein_Id,
	   rein_Descripcion,
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = raza_UserCreacion)) AS usua_UserCreaNombre,
	   raza_UserCreacion,
	   raza_FechaCreacion,
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = raza_UserModificacion)) AS usua_UserModiNombre,
	   raza_UserModificacion,
	   raza_FechaModificacion,
	   raza_Estado
	   FROM zool.tbRazas T1
	   INNER JOIN zool.tbHabitat T2
	   ON T1.habi_Id = T2.habi_Id
	   INNER JOIN zool.tbEspecies T3
	   ON T1.espe_Id = T3.espe_Id
	   INNER JOIN zool.tbReinos T4
	   ON T1.rein_Id = T4.rein_Id
	   WHERE raza_Estado = 1;
	    

	   
GO
--****************************************************************/TABLA DE RAZAS*****************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--**************************************************************TABLA DE ALIMENTACI�N************************************************************************--
CREATE OR ALTER VIEW zool.VW_tbALimentacion
AS 

SELECT alim_Id, 
       alim_Descripcion, 
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = alim_UserCreacion)) AS usua_UserCreaNombre,
	   alim_UserCreacion,
	   alim_FechaCreacion,
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = alim_UserModificacion)) AS usua_UserModiNombre,
	   alim_UserModificacion,
	   alim_FechaModificacion,
	   alim_Estado 
	   FROM zool.tbAlimentacion
	   WHERE alim_Estado = 1;
GO
--*************************************************************/TABLA DE ALIMENTACI�N************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--****************************************************************TABLA DE ANIMALES**************************************************************************--
CREATE OR ALTER VIEW zool.VW_tbAnimales
AS 

SELECT  anim_Id, 
		anim_Codigo,
		anim_Nombre, 
		T1.raza_Id,
		raza_Descripcion,
		T4.habi_Id,
		habi_Descripcion,
		T4.rein_Id,
		rein_Descripcion,
		T1.arzo_Id, 
		arzo_Descripcion,
		T1.alim_Id, 
		alim_Descripcion,
	    (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	    WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = anim_UserCreacion)) AS usua_UserCreaNombre,
		anim_UserCreacion,
		anim_FechaCreacion, 
	    (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	    WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = anim_UserModificacion)) AS usua_UserModiNombre,
		anim_UserModificacion, 
		anim_FechaModificacion,
		anim_Estado 
		FROM zool.tbAnimales T1
		INNER JOIN zool.tbAreasZoologico T2
		ON T1.arzo_Id = T2.arzo_Id
		INNER JOIN zool.tbAlimentacion T3
		ON T1.alim_Id = T3.alim_Id
		INNER JOIN zool.tbRazas T4
		ON T1.raza_Id = T4.raza_Id
		INNER JOIN zool.tbHabitat T5
		ON T4.habi_Id = T5.habi_Id
		INNER JOIN zool.tbReinos T6
		ON T4.rein_Id = T6.rein_Id
	    WHERE anim_Estado = 1;

GO
--***************************************************************/TABLA DE ANIMALES**************************************************************************--

--**************************************************************/INSERT DE ZOOLOGICO**************************************************************************--


----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------


--****************************************************************INSERT DE BOT�NICA**************************************************************************--

--*************************************************************TABLA DE AREAS BOT�NICAS***********************************************************************--
CREATE OR ALTER VIEW bota.VW_tbAreasBotanicas
AS 

SELECT arbo_Id, 
	   arbo_Descripcion,
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = arbo_UserCreacion)) AS usua_UserCreaNombre,
	   arbo_UserCreacion,
	   arbo_FechaCreacion,
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = arbo_UserModificacion)) AS usua_UserModiNombre,
	   arbo_UserModificacion, 
	   arbo_FechaModificacion, 
	   arbo_Estado
	   FROM bota.tbAreasBotanicas  
	   WHERE arbo_Estado = 1;
GO
--************************************************************/TABLA DE AREAS BOT�NICAS***********************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE OR ALTER VIEW zool.VW_tbReinos
AS 

SELECT rein_Id, 
	   rein_Descripcion,
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = rein_UserCreacion)) AS usua_UserCreaNombre,
	   rein_UserCreacion,
	   rein_FechaCreacion,
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = rein_UserModificacion)) AS usua_UserModiNombre,
	   rein_UserModificacion, 
	   rein_FechaModificacion, 
	   rein_Estado
	   FROM zool.tbReinos  
	   WHERE rein_Estado = 1;
GO
--************************************************************/TABLA DE AREAS BOT�NICAS***********************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--************************************************************TABLA DE TIPOS DE PLANTAS************************************************************************--
CREATE OR ALTER VIEW zool.VW_tbTiposPlantas
AS 

SELECT tipl_Id,
       tipl_NombreComun,
       tipl_NombreCientifico,
       T1.rein_Id,
       rein_Descripcion,
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = tipl_UserCreacion)) AS usua_UserCreaNombre,
	   tipl_UserCreacion,
	   tipl_FechaCreacion,
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = tipl_UserModificacion)) AS usua_UserModiNombre,
	   tipl_UserModificacion, 
	   tipl_FechaModificacion, 
	   tipl_Estado
	   FROM bota.tbTiposPlantas T1
	   INNER JOIN zool.tbReinos T2
	   ON T1.rein_Id = T2.rein_Id
	   WHERE tipl_Estado = 1;
GO
--***********************************************************/TABLA DE TIPOS DE PLANTAS***********************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*****************************************************************TABLA DE REINOS****************************************************************************--
CREATE OR ALTER VIEW zool.VW_tbReinos
AS 

SELECT rein_Id, 
	   rein_Descripcion,
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = rein_UserCreacion)) AS usua_UserCreaNombre,
	   rein_UserCreacion,
	   rein_FechaCreacion,
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = rein_UserModificacion)) AS usua_UserModiNombre,
	   rein_UserModificacion, 
	   rein_FechaModificacion, 
	   rein_Estado
	   FROM zool.tbReinos  
	   WHERE rein_Estado = 1;
GO
--*****************************************************************TABLA DE REINOS****************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*****************************************************************TABLA DE CUIDADOS***************************************************************************--
CREATE OR ALTER VIEW bota.VW_tbCuidados
AS

SELECT cuid_Id,
       cuid_Observacion,
	   T1.ticu_Id,
	   ticu_Descripcion,
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = cuid_UserCreacion)) AS usua_UserCreaNombre,
	   cuid_UserCreacion, 
	   cuid_FechaCreacion, 
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = cuid_UserModificacion)) AS usua_UserModiNombre,
	   cuid_UserModificacion,
	   cuid_FechaModificacion, 
	   cuid_Estado 
	   FROM bota.tbCuidados   T1
	   INNER JOIN bota.tbTiposCuidados T2
	   ON T1.ticu_Id = T2.ticu_Id
	   WHERE cuid_Estado = 1;
GO
--****************************************************************/TABLA DE CUIDADOS**************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--************************************************************TABLA DE TIPOS DE CUIDADOS**********************************************************************--
CREATE OR ALTER VIEW bota.VW_tbTiposCuidados
AS

SELECT ticu_Id,
       ticu_Descripcion,
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = ticu_UserCreacion)) AS usua_UserCreaNombre,
	   ticu_UserCreacion, 
	   ticu_FechaCreacion, 
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = ticu_UserModificacion)) AS usua_UserModiNombre,
	   ticu_UserModificacion,
	   ticu_FechaModificacion, 
	   ticu_Estado 
	   FROM bota.tbTiposCuidados  
	   WHERE ticu_Estado = 1;
GO
--***********************************************************/TABLA DE TIPOS DE CUIDADOS**********************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--**********************************************************TABLA DE CUIDADOS POR PLANTA**********************************************************************--
CREATE OR ALTER VIEW zool.VW_tbCuidadoPlanta
AS

SELECT cupl_Id, 
	   T1.plan_Id,
	   plan_Codigo,
	   T4.tipl_Id,
	   T4.tipl_NombreComun,
	   T4.tipl_NombreCientifico,
	   t2.arbo_Id, 
	   T1.ticu_Id, 
	   ticu_Descripcion,
	   cupl_Fecha,
	   cupl_UserCreacion, 
	   cupl_FechaCreacion, 
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = cupl_UserCreacion)) AS usua_UserCreaNombre,
	   cupl_UserModificacion, 
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = cupl_UserModificacion)) AS usua_UserModiNombre,
	   cupl_FechaModificacion,
	   cupl_Estado
	   FROM bota.tbCuidadoPlanta T1
	   INNER JOIN bota.tbPlantas T2
	   ON T1.plan_Id = T2.plan_Id
	   INNER JOIN bota.tbTiposCuidados T3
	   ON T1.ticu_Id = T3.ticu_Id
	   INNER JOIN bota.tbTiposPlantas T4
	   ON T2.tipl_Id = T4.tipl_Id
	   WHERE ticu_Estado = 1;
GO

 --**********************************************************/TABLA DE CUIDADOS POR PLANTA**********************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*****************************************************************TABLA DE PLANTAS***************************************************************************--
CREATE OR ALTER VIEW bota.VW_tbPlantas
AS
SELECT plan_Id, 
	   plan_Codigo,
	   T1.tipl_Id,
	   tipl_NombreComun,
	   tipl_NombreCientifico,
	   T1.arbo_Id, 
	   arbo_Descripcion,
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = plan_UserCreacion)) AS usua_UserCreaNombre,
	   plan_UserCreacion,
	   plan_FechaCreacion, 
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = plan_UserModificacion)) AS usua_UserModiNombre,
	   plan_UserModificacion,
	   plan_FechaModificacion, 
	   plan_Estado 
	   FROM bota.tbPlantas T1
	   INNER JOIN bota.tbAreasBotanicas T2
	   ON T1.arbo_Id = T2.arbo_Id
	   INNER JOIN bota.tbTiposPlantas T3
	   ON T1.tipl_Id = T3.tipl_Id
	   WHERE plan_Estado = 1;
GO
--****************************************************************/TABLA DE PLANTAS***************************************************************************--

--***************************************************************/M�DULO DE BOT�NICA**************************************************************************--


----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------


--***************************************************************INSERT DE FACTURACI�N************************************************************************--

--*****************************************************************TABLA DE TICKETS***************************************************************************--
CREATE OR ALTER VIEW fact.VW_tbTickets
AS 

SELECT tick_Id,
       tick_Descripcion, 
	   tick_Precio,
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = tick_UserCreacion)) AS usua_UserCreaNombre,
	   tick_UserCreacion, 
	   tick_FechaCreacion,
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = tick_UserModificacion)) AS usua_UserModiNombre,
	   tick_UserModificacion, 
	   tick_FechaModificacion,
	   tick_Estado
       FROM fact.tbTickets  
	   WHERE tick_Estado = 1;

GO
--****************************************************************/TABLA DE TICKETS***************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*************************************************************TABLA DE M�TODOS DE PAGO***********************************************************************--
CREATE OR ALTER VIEW fact.VW_tbMetodosPago
AS 

SELECT meto_Id,
       meto_Descripcion,
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = meto_UserCreacion)) AS usua_UserCreaNombre,
	   meto_UserCreacion,
	   meto_FechaCreacion,
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = meto_UserModificacion)) AS usua_UserModiNombre,
	   meto_UserModificacion,
	   meto_FechaModificacion,
	   meto_Estado 
	   FROM fact.tbMetodosPago
	   WHERE meto_Estado = 1;
GO
--************************************************************/TABLA DE M�TODOS DE PAGO***********************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--****************************************************************TABLA DE FACTURAS***************************************************************************--
CREATE OR ALTER VIEW fact.VW_tbFacturas
AS

SELECT fact_Id,
       T1.empl_Id, 
	   empl_Nombre + ' '+ empl_Apellido AS empleado,
	   T1.visi_Id,
	   visi_Nombres + ' ' + visi_Apellido AS visitante,
	   T1.meto_Id,
	   meto_Descripcion,
	   fact_Fecha, 
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = empl_UserCreacion)) AS usua_UserCreaNombre,
	   fact_UserCreacion, 
	   fact_FechaCreacion, 
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = fact_UserModificacion)) AS usua_UserModiNombre,
	   fact_UserModificacion, 
	   fact_FechaModificacion, 
	   fact_Estado 
	   FROM fact.tbFacturas T1
	   INNER JOIN mant.tbEmpleados T2
	   ON T1.empl_Id = T2.empl_Id 
	   INNER JOIN mant.tbVisitantes T3
	   ON T1.visi_Id = T3.visi_Id
	   INNER JOIN fact.tbMetodosPago T4
	   ON T1.meto_Id = T4.meto_Id   
	   WHERE fact_Estado = 1;

GO
--***************************************************************/TABLA DE FACTURAS***************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--***********************************************************TABLA DE FACTURAS DETALLE************************************************************************--
CREATE OR ALTER VIEW fact.VW_FacturasDetalle
AS

SELECT fade_Id,
	   T1.fact_Id,
	   T1.tick_Id, 
	   tick_Descripcion,
	   fade_Cantidad,
	   fade_Total,
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = fade_UserCreacion)) AS usua_UserCreaNombre,
	   fade_UserCreacion, 
	   fade_FechaCreacion,
	   (SELECT empl_Nombre+' '+empl_ApellIdo FROM mant.tbEmpleados 
	   WHERE empl_Id IN (SELECT empl_Id FROM acce.tbUsuarios WHERE [usua_Id] = fade_UserModificacion)) AS usua_UserModiNombre,
	   fade_UserModificacion, 
	   fade_FechaModificacion, 
	   fade_Estado 
	   FROM fact.tbFacturasDetalles T1
	   INNER JOIN fact.tbTickets T2
	   ON T1.tick_Id = T2.tick_Id  
	   INNER JOIN fact.tbFacturas T3
	   ON T1.fact_Id = T3.fact_Id
	   WHERE fade_Estado = 1;
GO
--**********************************************************/TABLA DE FACTURAS DETALLE************************************************************************--

--**************************************************************/INSERT DE FACTURACI�N************************************************************************--

--************************************************************************************************************************************************************--