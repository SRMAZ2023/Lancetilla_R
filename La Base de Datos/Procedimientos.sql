USE MASTER 
GO
USE db_Lancetilla
GO

--************************************************************************************************************************************************************--

--**************************************************************PROCS DE ACCESO******************************************************************************--

--*************************************************************TABLA DE USUARIOS******************************************************************************--
--************************************************************/TABLA DE USUARIOS******************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--**************************************************************TABLA DE ROLES********************************************************************************--
--*************************************************************/TABLA DE ROLES********************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--************************************************************TABLA DE PANTALLAS******************************************************************************--
--***********************************************************/TABLA DE PANTALLAS******************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*******************************************************TABLA DE ROLES POR PANTALLA**************************************************************************--
--******************************************************/TABLA DE ROLES POR PANTALLA**************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*************************************************************/PROCS DE ACCESO******************************************************************************--


----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------


--***********************************************************PROCS DE MANTENIMIENTO**************************************************************************--

--***********************************************************TABLA DE DEPARTAMENTOS***************************************************************************--
CREATE OR ALTER PROC mant.UDP_tbDepartamentos_CREATE
@dept_Descripcion NVARCHAR(100),
@dept_UserCreacion INT
AS BEGIN

	BEGIN TRY
		BEGIN TRAN

		-- Si existe
		IF EXISTS (SELECT * FROM mant.tbDepartamentos WHERE dept_Descripcion = @dept_Descripcion AND dept_Estado = 1)
		BEGIN
			SELECT 409 AS codeStatus, 'El departamento ya existe.' AS messageStatus
		END


		ELSE IF EXISTS (SELECT * FROM mant.tbDepartamentos WHERE dept_Descripcion = @dept_Descripcion AND dept_Estado = 0)
		BEGIN
			DECLARE @Id INT = (SELECT dept_Id FROM mant.tbDepartamentos WHERE dept_Descripcion = @dept_Descripcion) 

			BEGIN TRAN -- Agregado BEGIN TRAN

			UPDATE mant.tbDepartamentos
			SET
				dept_Descripcion = @dept_Descripcion,
				dept_UserCreacion = @dept_UserCreacion,
				dept_UserModificacion = NULL,
				dept_Estado = 1
			WHERE dept_Id = @Id

		    SELECT 200 AS codeStatus, 'El departamento ha sido creado con �xito.' AS messageStatus

			COMMIT -- Agregado COMMIT
		END


		ELSE IF NOT EXISTS (SELECT * FROM mant.tbDepartamentos WHERE dept_Descripcion = @dept_Descripcion AND dept_Estado = 1)
		BEGIN
			INSERT INTO mant.tbDepartamentos (dept_Descripcion, dept_UserCreacion)
			VALUES (@dept_Descripcion, @dept_UserCreacion)

			BEGIN TRAN -- Agregado BEGIN TRAN

			SELECT 200 AS codeStatus, 'El departamento ha sido creado con �xito.' AS messageStatus

			COMMIT -- Agregado COMMIT
		END


		ELSE IF EXISTS (SELECT * FROM mant.tbDepartamentos WHERE dept_Descripcion = @dept_Descripcion AND dept_Estado = 0)
		BEGIN
			BEGIN TRAN -- Agregado BEGIN TRAN

			UPDATE mant.tbDepartamentos 
			SET dept_Estado = 1,
			dept_FechaCreacion = GETDATE();

			COMMIT -- Agregado COMMIT
		END

		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
		SELECT 500 AS codeStatus, ERROR_MESSAGE() AS messageStatus
	END CATCH
	END
GO

--EXEC mant.UDP_tbDepartamentos_CREATE 'AAAAA', 1
--select * from mant.tbDepartamentos
--EXEC mant.udp_tbDepartamentos_DELETE 22

CREATE OR ALTER PROC mant.UDP_tbDepartamentos_UPDATE
@dept_Id INT,
@dept_Descripcion NVARCHAR(100),
@dept_UserModificacion INT
AS BEGIN

  	BEGIN TRY
		BEGIN TRAN
			IF EXISTS (SELECT * FROM mant.tbDepartamentos WHERE dept_Descripcion = @dept_Descripcion AND dept_Estado = 1)
			BEGIN
				SELECT 409 AS codeStatus, 'El departamento ya existe' AS messageStatus
			END
			ELSE IF EXISTS (SELECT * FROM mant.tbDepartamentos WHERE dept_Descripcion = @dept_Descripcion AND dept_Estado = 0)
			BEGIN
						DECLARE @Id INT = (SELECT dept_Id FROM mant.tbDepartamentos WHERE dept_Descripcion = @dept_Descripcion) 

				UPDATE mant.tbDepartamentos
				SET
					dept_Descripcion = @dept_Descripcion,
					dept_UserModificacion = @dept_UserModificacion,
					dept_Estado = 1
				WHERE dept_Id = @Id

				SELECT 200 AS codeStatus, 'El departamento ha sido actualizado con �xito.' AS messageStatus
			END
			ELSE -- Departamento no existe, se realiza la actualizaci�n
			BEGIN
				UPDATE mant.tbDepartamentos
				SET
					dept_Descripcion = @dept_Descripcion,
					dept_UserModificacion = @dept_UserModificacion
				WHERE dept_Id = @dept_Id

				SELECT 200 AS codeStatus, 'El departamento ha sido actualizado con �xito.' AS messageStatus
			END

			COMMIT
		END TRY
		BEGIN CATCH
			ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE() AS messageStatus
		END CATCH

END
GO


--EXEC mant.UDP_tbDepartamentos_UPDATE 22, 'hola', 1
--select * from mant.tbDepartamentos
--EXEC mant.udp_tbDepartamentos_DELETE 21



CREATE OR ALTER PROC mant.UDP_tbDepartamentos_DELETE
@dept_Id INT
AS BEGIN

  	BEGIN TRY
	BEGIN TRAN
			DECLARE @deptos INT = (SELECT COUNT(*) FROM mant.tbMunicipios WHERE dept_Id = @dept_Id)
			
			IF @deptos > 0
			BEGIN
			SELECT 150 AS codeStatus, 'El departamento que desea eliminar est� en uso.' AS messageStatus
			END
			ELSE
			BEGIN
			UPDATE mant.tbDepartamentos
			SET
<<<<<<< HEAD
				
=======
				dept_Estado		=	0
				WHERE dept_Id	=	@dept_Id
>>>>>>> b39071da32a69f9029e28d6a6de01c04ce8ffaab

			SELECT 200 AS codeStatus, 'El departamento ha sido eliminado con �xito.' AS messageStatus
			END
	COMMIT
	END TRY
	BEGIN CATCH
	ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH


END
GO
--**********************************************************/TABLA DE DEPARTAMENTOS***************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*************************************************************TABLA DE MUNICIPIOS****************************************************************************--
--*************************************************************/TABLA DE MUNICIPIOS***************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--***********************************************************TABLA DE ESTADOS CIVILES*************************************************************************--
--**********************************************************/TABLA DE ESTADOS CIVILES*************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--****************************************************************TABLA DE CARGOS*****************************************************************************--
--***************************************************************/TABLA DE CARGOS*****************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--**************************************************************TABLA DE EMPLEADOS****************************************************************************--
--*************************************************************/TABLA DE EMPLEADOS****************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*************************************************************/TABLA DE VISITANTES***************************************************************************--
--*************************************************************/TABLA DE VISITANTES***************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*********************************************************TABLA DE TIPOS MANTENIMIENTO**********************************************************************--
--*********************************************************/TABLA DE TIPOS MANTENIMIENTO**********************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*************************************************************TABLA DE MANTENIMIENTO*************************************************************************--
--************************************************************/TABLA DE MANTENIMIENTO*************************************************************************--


--**********************************************************/PROCS DE MANTENIMIENTO**************************************************************************--


----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------


--***************************************************************PROCS DE ZOOLOGICO**************************************************************************--

--*****************************************************************TABLA DE �REAS*****************************************************************************--
--****************************************************************/TABLA DE �REAS*****************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--****************************************************************TABLA DE ESPECIES**************************************************************************--
GO 
CREATE OR ALTER VIEW zool.VW_tbEspecies
as
SELECT TOP (100) [espe_Id]
      ,[espe_Descripcion]
      ,[espe_UserCreacion]
      ,[espe_FechaCreacion]
      ,[espe_UserModificacion]
      ,[espe_FechaModificacion]
      ,[espe_Estado]
  FROM [db_Lancetilla].[zool].[tbEspecies]

go
CREATE OR ALTER PROCEDURE zool.UDP_tbEspecies_SELECT
AS
BEGIN
	SELECT TOP (100) [espe_Id]
      ,[espe_Descripcion]
      ,[espe_UserCreacion]
      ,[espe_FechaCreacion]
      ,[espe_UserModificacion]
      ,[espe_FechaModificacion]
      ,[espe_Estado]
  FROM [db_Lancetilla].[zool].[VW_tbEspecies]
  WHERE espe_Estado = 1
END


go
CREATE OR ALTER PROCEDURE zool.UDP_tbEspecies_INSERT
AS
BEGIN
	BEGIN TRY
	SELECT TOP (100) [espe_Id]
      ,[espe_Descripcion]
      ,[espe_UserCreacion]
      ,[espe_FechaCreacion]
      ,[espe_UserModificacion]
      ,[espe_FechaModificacion]
      ,[espe_Estado]
  FROM [db_Lancetilla].[zool].[VW_tbEspecies]
  WHERE espe_Estado = 1
  	 	   SELECT 1 CodeStatus

  END TRY
  BEGIN CATCH
  		   SELECT 0 CodeStatus

  END CATCH
END



--***************************************************************/TABLA DE ESPECIES**************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--**************************************************************TABLA DE ALIMENTACI�N************************************************************************--
--*************************************************************/TABLA DE ALIMENTACI�N************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--****************************************************************TABLA DE ANIMALES**************************************************************************--
--***************************************************************/TABLA DE ANIMALES**************************************************************************--

--**************************************************************/PROCS DE ZOOLOGICO**************************************************************************--


----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------


--****************************************************************PROCS DE BOT�NICA**************************************************************************--

--*************************************************************TABLA DE AREAS BOT�NICAS***********************************************************************--
--************************************************************/TABLA DE AREAS BOT�NICAS***********************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*****************************************************************TABLA DE CUIDADOS***************************************************************************--
--****************************************************************/TABLA DE CUIDADOS***************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*****************************************************************TABLA DE PLANTAS****************************************************************************--
--****************************************************************/TABLA DE PLANTAS***************************************************************************--

--***************************************************************/PROCS DE BOT�NICA**************************************************************************--


----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------


--***************************************************************PROCS DE FACTURACI�N************************************************************************--

--*****************************************************************TABLA DE TICKETS***************************************************************************--
--****************************************************************/TABLA DE TICKETS***************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*************************************************************TABLA DE M�TODOS DE PAGO***********************************************************************--
--************************************************************/TABLA DE M�TODOS DE PAGO***********************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--****************************************************************TABLA DE FACTURAS***************************************************************************--
--***************************************************************/TABLA DE FACTURAS***************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--***********************************************************TABLA DE FACTURAS DETALLE************************************************************************--
--**********************************************************/TABLA DE FACTURAS DETALLE************************************************************************--

--**************************************************************/PROCS DE FACTURACI�N************************************************************************--

--************************************************************************************************************************************************************--