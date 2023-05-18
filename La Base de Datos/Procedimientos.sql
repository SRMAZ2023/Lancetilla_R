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
CREATE OR ALTER PROC mant.UPD_tbDepartamentos_INDEX
AS BEGIN

SELECT * FROM mant.VW_tbDepartamentos
WHERE dept_Estado = 1;

END
GO


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

		    SELECT 200 AS codeStatus, 'El departamento ha sido creado con éxito.' AS messageStatus

			COMMIT -- Agregado COMMIT
		END


		ELSE IF NOT EXISTS (SELECT * FROM mant.tbDepartamentos WHERE dept_Descripcion = @dept_Descripcion AND dept_Estado = 1)
		BEGIN
			INSERT INTO mant.tbDepartamentos (dept_Descripcion, dept_UserCreacion)
			VALUES (@dept_Descripcion, @dept_UserCreacion)

			BEGIN TRAN -- Agregado BEGIN TRAN

			SELECT 200 AS codeStatus, 'El departamento ha sido creado con éxito.' AS messageStatus

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



CREATE OR ALTER PROC mant.UDP_tbDepartamentos_UPDATE
@dept_Id INT,
@dept_Descripcion NVARCHAR(100),
@dept_UserModificacion INT
AS BEGIN

  	BEGIN TRY
		BEGIN TRAN
			IF EXISTS (SELECT * FROM mant.tbDepartamentos WHERE dept_Descripcion = @dept_Descripcion AND dept_Estado = 1)
			BEGIN
				SELECT 409 AS codeStatus, 'El departamento ya existe.' AS messageStatus
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

				SELECT 200 AS codeStatus, 'El departamento ha sido actualizado con éxito.' AS messageStatus
			END
			ELSE -- Departamento no existe, se realiza la actualización
			BEGIN
				UPDATE mant.tbDepartamentos
				SET
					dept_Descripcion = @dept_Descripcion,
					dept_UserModificacion = @dept_UserModificacion
				WHERE dept_Id = @dept_Id

				SELECT 200 AS codeStatus, 'El departamento ha sido actualizado con éxito.' AS messageStatus
			END

			COMMIT
		END TRY
		BEGIN CATCH
			ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE() AS messageStatus
		END CATCH

END
GO





CREATE OR ALTER PROC mant.UDP_tbDepartamentos_DELETE
@dept_Id INT
AS BEGIN

  	BEGIN TRY
	BEGIN TRAN
			DECLARE @deptos INT = (SELECT COUNT(*) FROM mant.tbMunicipios WHERE dept_Id = @dept_Id)
			
			IF @deptos > 0
			BEGIN
			SELECT 150 AS codeStatus, 'El departamento que desea eliminar está en uso.' AS messageStatus
			END
			ELSE
			BEGIN
			UPDATE mant.tbDepartamentos
			SET
				dept_Estado		=	0
				WHERE dept_Id	=	@dept_Id

			SELECT 200 AS codeStatus, 'El departamento ha sido eliminado con éxito.' AS messageStatus
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
CREATE OR ALTER PROC mant.UDP_tbMunicipios_INDEX
AS BEGIN

SELECT * FROM mant.VW_tbMunicipios
WHERE muni_Estado = 1;

END
GO

CREATE OR ALTER PROC mant.UDP_tbMunicipios_CREATE
@muni_Descripcion NVARCHAR(100),
@dept_Id INT,
@muni_UserCreacion INT
AS BEGIN

BEGIN TRY

	BEGIN TRAN

		-- Si existe
		IF EXISTS (SELECT * FROM mant.tbMunicipios WHERE muni_Descripcion = @muni_Descripcion AND muni_Estado = 1)
		BEGIN
			SELECT 409 AS codeStatus, 'El municipio ya existe.' AS messageStatus
		END


		ELSE IF EXISTS (SELECT * FROM mant.tbMunicipios WHERE muni_Descripcion = @muni_Descripcion AND muni_Estado = 0)
		BEGIN
			DECLARE @Id INT = (SELECT muni_Id FROM mant.tbMunicipios WHERE muni_Descripcion = @muni_Descripcion) 

			BEGIN TRAN -- Agregado BEGIN TRAN

			UPDATE mant.tbMunicipios
			SET
				muni_Descripcion = @muni_Descripcion,
				dept_Id			= @dept_Id,
				muni_UserCreacion = @muni_UserCreacion,
				muni_UserModificacion = NULL,
				muni_Estado = 1
			WHERE muni_Id = @Id

		    SELECT 200 AS codeStatus, 'El municipio ha sido creado con éxito.' AS messageStatus

			COMMIT -- Agregado COMMIT
		END


		ELSE IF NOT EXISTS (SELECT * FROM mant.tbMunicipios WHERE muni_Descripcion = @muni_Descripcion AND muni_Estado = 1)
		BEGIN
			INSERT INTO mant.tbMunicipios(muni_Descripcion, dept_Id, muni_UserCreacion)
			VALUES (@muni_Descripcion, @dept_Id, @muni_UserCreacion)

			BEGIN TRAN -- Agregado BEGIN TRAN

			SELECT 200 AS codeStatus, 'El municipio ha sido creado con éxito.' AS messageStatus

			COMMIT -- Agregado COMMIT
		END



		COMMIT

END TRY


BEGIN CATCH 
ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus

END CATCH
END
GO



CREATE OR ALTER PROC mant.UDP_tbMunicipios_UPDATE
@muni_Id INT,
@muni_Descripcion NVARCHAR(100),
@dept_Id INT,
@muni_UserModificacion INT
AS BEGIN

  	BEGIN TRY
		BEGIN TRAN
			IF EXISTS (SELECT * FROM mant.tbMunicipios WHERE muni_Descripcion = @muni_Descripcion AND muni_Estado = 1)
			BEGIN
				SELECT 409 AS codeStatus, 'El municipio ya existe.' AS messageStatus
			END
			ELSE IF EXISTS (SELECT * FROM mant.tbMunicipios WHERE muni_Descripcion = @muni_Descripcion AND muni_Estado = 0)
			BEGIN
						DECLARE @Id INT = (SELECT muni_Id FROM mant.tbMunicipios WHERE muni_Descripcion = @muni_Descripcion) 

				UPDATE mant.tbMunicipios
				SET
					muni_Descripcion = @muni_Descripcion,
					muni_UserModificacion = @muni_UserModificacion,
					muni_Estado = 1
				WHERE muni_Id = @Id

				SELECT 200 AS codeStatus, 'El muniçipio ha sido actualizado con éxito.' AS messageStatus
			END

			ELSE -- Municipio no existe, se realiza la actualización
			BEGIN
				UPDATE mant.tbMunicipios
				SET
					muni_Descripcion = @muni_Descripcion,
					muni_UserModificacion = @muni_UserModificacion
				WHERE muni_Id = @muni_Id

				SELECT 200 AS codeStatus, 'El municipio ha sido actualizado con éxito.' AS messageStatus
			END

			COMMIT
		END TRY
		BEGIN CATCH
			ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE() AS messageStatus
		END CATCH

END
GO

CREATE OR ALTER PROC mant.UDP_tbMunicipios_DELETE
@muni_Id INT
AS BEGIN

  	BEGIN TRY
	BEGIN TRAN
			DECLARE @munis INT = (SELECT COUNT(*) FROM mant.tbEmpleados WHERE muni_Id = @muni_Id)
			
			IF @munis > 0
			BEGIN
			SELECT 150 AS codeStatus, 'El municipio que desea eliminar está en uso.' AS messageStatus
			END
			ELSE
			BEGIN
			UPDATE mant.tbMunicipios
			SET
				muni_Estado		=	0
				WHERE muni_Id	=	@muni_Id

			SELECT 200 AS codeStatus, 'El municipios ha sido eliminado con éxito.' AS messageStatus
			END
	COMMIT
	END TRY
	BEGIN CATCH
	ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH


END
GO


CREATE OR ALTER PROC mant.UDP_tbMunicipios_MUNISPORDEPTO
@dept_Id INT
AS BEGIN

SELECT * FROM mant.tbMunicipios
WHERE dept_Id = @dept_Id;

END
GO
--*************************************************************/TABLA DE MUNICIPIOS***************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--***********************************************************TABLA DE ESTADOS CIVILES*************************************************************************--
CREATE OR ALTER PROC mant.UDP_tbEstadosCiviles_INDEX
AS BEGIN

SELECT * FROM mant.VW_tbEstadosCiviles
WHERE estc_Estado = 1;

END
GO

CREATE OR ALTER PROC mant.UDP_tbEstadosCiviles_CREATE
@estc_Descripcion NVARCHAR(100),
@estc_UserCreacion INT
AS BEGIN

BEGIN TRY

	BEGIN TRAN

		-- Si existe
		IF EXISTS (SELECT * FROM mant.tbEstadosCiviles WHERE estc_Descripcion = @estc_Descripcion AND estc_Estado = 1)
		BEGIN
			SELECT 409 AS codeStatus, 'El estado civil ya existe.' AS messageStatus
		END


		ELSE IF EXISTS (SELECT * FROM mant.tbEstadosCiviles WHERE estc_Descripcion = @estc_Descripcion AND estc_Estado = 0)
		BEGIN
			DECLARE @Id INT = (SELECT estc_Id FROM mant.tbEstadosCiviles WHERE estc_Descripcion = @estc_Descripcion) 

			BEGIN TRAN -- Agregado BEGIN TRAN

			UPDATE mant.tbEstadosCiviles
			SET
				estc_Descripcion = @estc_Descripcion,
				estc_UserCreacion = @estc_UserCreacion,
				estc_UserModificacion = NULL,
				estc_Estado = 1
			WHERE estc_Id = @Id

		    SELECT 200 AS codeStatus, 'El estado civil ha sido creado con éxito.' AS messageStatus

			COMMIT -- Agregado COMMIT
		END


		ELSE IF NOT EXISTS (SELECT * FROM mant.tbEstadosCiviles WHERE estc_Descripcion = @estc_Descripcion AND estc_Estado = 1)
		BEGIN
			INSERT INTO mant.tbEstadosCiviles(estc_Descripcion, estc_UserCreacion)
			VALUES (@estc_Descripcion, @estc_UserCreacion)

			BEGIN TRAN -- Agregado BEGIN TRAN

			SELECT 200 AS codeStatus, 'El estado civil ha sido creado con éxito.' AS messageStatus

			COMMIT -- Agregado COMMIT
		END




		COMMIT

END TRY


BEGIN CATCH 
ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus

END CATCH
END
GO



CREATE OR ALTER PROC mant.UDP_tbEstadosCiviles_UPDATE
@estc_Id INT,
@estc_Descripcion NVARCHAR(100),
@estc_UserModificacion INT
AS BEGIN

  	BEGIN TRY
		BEGIN TRAN
			IF EXISTS (SELECT * FROM mant.tbEstadosCiviles WHERE estc_Descripcion = @estc_Descripcion AND estc_Estado = 1)
			BEGIN
				SELECT 409 AS codeStatus, 'El estado civil ya existe.' AS messageStatus
			END
			ELSE IF EXISTS (SELECT * FROM mant.tbEstadosCiviles WHERE estc_Descripcion = @estc_Descripcion AND estc_Estado = 0)
			BEGIN
						DECLARE @Id INT = (SELECT estc_Id FROM mant.tbEstadosCiviles WHERE estc_Descripcion = @estc_Descripcion) 

				UPDATE mant.tbEstadosCiviles
				SET
					estc_Descripcion = @estc_Descripcion,
					estc_UserModificacion = @estc_UserModificacion,
					estc_Estado = 1
				WHERE estc_Id = @Id

				SELECT 200 AS codeStatus, 'El estado civil ha sido actualizado con éxito.' AS messageStatus
			END

			ELSE -- Estadi civil no existe, se realiza la actualización
			BEGIN
				UPDATE mant.tbEstadosCiviles
				SET
					estc_Descripcion = @estc_Descripcion,
					estc_UserModificacion = @estc_UserModificacion
				WHERE estc_Id = estc_Id

				SELECT 200 AS codeStatus, 'El estado civil ha sido actualizado con éxito.' AS messageStatus
			END

			COMMIT
		END TRY
		BEGIN CATCH
			ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE() AS messageStatus
		END CATCH

END
GO

CREATE OR ALTER PROC mant.UDP_tbMunicipios_DELETE
@estc_Id INT
AS BEGIN

  	BEGIN TRY
	BEGIN TRAN
			DECLARE @estados INT = (SELECT COUNT(*) FROM mant.tbEmpleados WHERE estc_Id = @estc_Id)
			
			IF @estados > 0
			BEGIN
			SELECT 150 AS codeStatus, 'El estado civil que desea eliminar está en uso.' AS messageStatus
			END
			ELSE
			BEGIN
			UPDATE mant.tbEstadosCiviles
			SET
				estc_Estado		=	0
				WHERE estc_Id	=	@estc_Id

			SELECT 200 AS codeStatus, 'El estado civil ha sido eliminado con éxito.' AS messageStatus
			END
	COMMIT
	END TRY
	BEGIN CATCH
	ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH


END
GO
--**********************************************************/TABLA DE ESTADOS CIVILES*************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--****************************************************************TABLA DE CARGOS*****************************************************************************--
CREATE OR ALTER PROC mant.UDP_tbCargos_INDEX
AS BEGIN

SELECT * FROM mant.VW_tbCargos
WHERE carg_Estado = 1;

END
GO

CREATE OR ALTER PROC mant.UDP_tbCargos_CREATE
@carg_Descripcion NVARCHAR(100),
@carg_UserCreacion INT
AS BEGIN

BEGIN TRY

	BEGIN TRAN

		-- Si existe
		IF EXISTS (SELECT * FROM mant.tbCargos WHERE carg_Descripcion = @carg_Descripcion AND carg_Estado = 1)
		BEGIN
			SELECT 409 AS codeStatus, 'El cargo ya existe.' AS messageStatus
		END


		ELSE IF EXISTS (SELECT * FROM mant.tbCargos WHERE carg_Descripcion = @carg_Descripcion AND carg_Estado = 0)
		BEGIN
			DECLARE @Id INT = (SELECT carg_iD FROM mant.tbCargos WHERE carg_Descripcion = @carg_Descripcion) 

			BEGIN TRAN -- Agregado BEGIN TRAN

			UPDATE mant.tbCargos
			SET
				carg_Descripcion =  @carg_Descripcion,
				carg_UserCreacion = @carg_UserCreacion,
				carg_UserModificacion = NULL,
				carg_Estado = 1
			WHERE carg_Id = @Id

		    SELECT 200 AS codeStatus, 'El cargo ha sido creado con éxito.' AS messageStatus

			COMMIT -- Agregado COMMIT
		END


		ELSE IF NOT EXISTS (SELECT * FROM mant.tbCargos WHERE carg_Descripcion = @carg_Descripcion AND carg_Estado = 1)
		BEGIN
			INSERT INTO mant.tbCargos(carg_Descripcion, carg_UserCreacion)
			VALUES (@carg_Descripcion, @carg_UserCreacion)

			BEGIN TRAN -- Agregado BEGIN TRAN

			SELECT 200 AS codeStatus, 'El cargo ha sido creado con éxito.' AS messageStatus

			COMMIT -- Agregado COMMIT
		END

		COMMIT

END TRY


BEGIN CATCH 
ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus

END CATCH
END
GO



CREATE OR ALTER PROC mant.UDP_tbCargos_UPDATE
@carg_Id INT,
@carg_Descripcion NVARCHAR(100),
@carg_UserModificacion INT
AS BEGIN

  	BEGIN TRY
		BEGIN TRAN
			IF EXISTS (SELECT * FROM mant.tbCargos WHERE carg_Descripcion = @carg_Descripcion AND carg_Estado = 1)
			BEGIN
				SELECT 409 AS codeStatus, 'El cargo ya existe.' AS messageStatus
			END
			ELSE IF EXISTS (SELECT * FROM mant.tbCargos WHERE carg_Descripcion = @carg_Descripcion AND carg_Estado = 0)
			BEGIN
						DECLARE @Id INT = (SELECT carg_Id FROM mant.tbCargos WHERE carg_Descripcion= @carg_Descripcion) 

				UPDATE mant.tbCargos
				SET
						carg_Descripcion =      @carg_Descripcion,
						carg_UserModificacion = @carg_UserModificacion,
						carg_Estado = 1
				WHERE   carg_Id = @Id

				SELECT 200 AS codeStatus, 'El cargo ha sido actualizado con éxito.' AS messageStatus
			END

			ELSE -- Estadi civil no existe, se realiza la actualización
			BEGIN
				UPDATE mant.tbCargos
				SET
					  carg_Descripcion =      @carg_Descripcion,
					  carg_UserModificacion = @carg_UserModificacion
				WHERE carg_Id = carg_Id

				SELECT 200 AS codeStatus, 'El cargo ha sido actualizado con éxito.' AS messageStatus
			END

			COMMIT
		END TRY
		BEGIN CATCH
			ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE() AS messageStatus
		END CATCH

END
GO

CREATE OR ALTER PROC mant.UDP_tbCargos_DELETE
@carg_Id INT
AS BEGIN

  	BEGIN TRY
	BEGIN TRAN
			DECLARE @cargos INT = (SELECT COUNT(*) FROM mant.tbCargos WHERE carg_Id = @carg_Id)
			
			IF @cargos > 0
			BEGIN
			SELECT 150 AS codeStatus, 'El cargo que desea eliminar está en uso.' AS messageStatus
			END
			ELSE
			BEGIN
			UPDATE mant.tbCargos
			SET
				carg_Estado		=	0
				WHERE carg_Id	=	@carg_Id

			SELECT 200 AS codeStatus, 'El cargo ha sido eliminado con éxito.' AS messageStatus
			END
	COMMIT
	END TRY
	BEGIN CATCH
	ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH


END
GO

--***************************************************************/TABLA DE CARGOS*****************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--**************************************************************TABLA DE EMPLEADOS****************************************************************************--
CREATE OR ALTER PROC mant.UDP_tbEmpleados_INDEX
AS BEGIN

SELECT * FROM mant.VW_tbEmpleados
WHERE empl_Estado = 1;

END
GO

CREATE OR ALTER PROC mant.UDP_tbEmpleados_FIND
@empl_Id INT
AS BEGIN

SELECT * FROM mant.VW_tbEmpleados
WHERE empl_Id = @empl_Id

END
GO

CREATE OR ALTER PROC mant.UDP_tbEmpleados_CREATE
@empl_Nombre NVARCHAR(100),
@empl_Apellido NVARCHAR(100),
@empl_Identidad NVARCHAR(100),
@empl_FechaNacimiento DATE,
@empl_Direccion NVARCHAR(100),
@empl_Sexo CHAR(1),
@empl_Telefono NVARCHAR(100),
@estc_Id INT,
@carg_Id INT,
@muni_Id INT,
@empl_UserCreacion INT
AS BEGIN

BEGIN TRY

	BEGIN TRAN

		-- Si existe
		IF EXISTS (SELECT * FROM mant.tbEmpleados WHERE empl_Identidad = @empl_Identidad AND empl_Estado = 1)
		BEGIN	
			SELECT 409 AS codeStatus, 'El número de identidad ya existe.' AS messageStatus
		END

		ELSE IF EXISTS (SELECT * FROM mant.tbEmpleados WHERE empl_Identidad = @empl_Identidad AND empl_Estado = 0)
		BEGIN
		DECLARE @Id INT = (SELECT empl_Id FROM mant.tbEmpleados WHERE empl_Identidad = @empl_Identidad)

			BEGIN TRAN -- Agregado BEGIN TRAN

			UPDATE mant.tbEmpleados
			SET
			empl_Nombre = @empl_Nombre,
			empl_Apellido = @empl_Apellido,
			empl_Identidad = @empl_Identidad,
			empl_FechaNacimiento = @empl_FechaNacimiento,
			empl_Direccion = @empl_Direccion,
			empl_Sexo = @empl_Sexo,
			empl_Telefono = @empl_Telefono,
			estc_Id = @estc_Id,
			carg_Id = @carg_Id,
			muni_Id = @muni_Id,
			empl_UserModificacion = NULL,
			empl_Estado = 1
			WHERE empl_Id = @Id

		    SELECT 200 AS codeStatus, 'El empleado ha sido creado con éxito.' AS messageStatus

			COMMIT -- Agregado COMMIT
		END


		ELSE IF NOT EXISTS (SELECT * FROM mant.tbEmpleados WHERE empl_Identidad = @empl_Identidad AND empl_Estado = 1)
		BEGIN
			INSERT INTO mant.tbEmpleados(empl_Nombre, empl_Apellido, empl_Identidad, empl_FechaNacimiento, empl_Direccion, empl_Sexo, empl_Telefono, estc_Id, carg_Id, muni_Id, empl_UserCreacion)
			VALUES (@empl_Nombre, @empl_Apellido, @empl_Identidad, @empl_FechaNacimiento,@empl_Direccion, @empl_Sexo, @empl_Telefono, @estc_Id, @carg_Id, @muni_Id, @empl_UserCreacion)

			BEGIN TRAN -- Agregado BEGIN TRAN

			SELECT 200 AS codeStatus, 'El empleado ha sido creado con éxito.' AS messageStatus

			COMMIT -- Agregado COMMIT
		END


		COMMIT

END TRY


BEGIN CATCH 
ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus

END CATCH
END
GO


--exec mant.UDP_tbEmpleados_CREATE 'a', 'a', '123', '2005-02-22', 'sgfhdfghdfgh', 'f', '33333', 1,1,1,1
--select * from mant.tbEmpleados
--exec mant.UDP_tbEmpleados_DELETE 11


CREATE OR ALTER PROC mant.UDP_tbEmpleados_UPDATE
@empl_Id INT,
@empl_Nombre NVARCHAR(100),
@empl_Apellido NVARCHAR(100),
@empl_Identidad NVARCHAR(100),
@empl_FechaNacimiento DATE,
@empl_Direccion NVARCHAR(100),
@empl_Sexo CHAR(1),
@empl_Telefono NVARCHAR(100),
@estc_Id INT,
@carg_Id INT,
@muni_Id INT,
@empl_UserModificacion INT
AS BEGIN

  	BEGIN TRY
		BEGIN TRAN
			IF EXISTS (SELECT * FROM mant.tbEmpleados WHERE empl_Identidad = @empl_Identidad AND empl_Estado = 1)
			BEGIN
				SELECT 409 AS codeStatus, 'El número de identidad ya existe.' AS messageStatus
			END
			ELSE IF EXISTS (SELECT * FROM mant.tbEmpleados WHERE empl_Identidad = @empl_Identidad AND empl_Estado = 0)
			BEGIN
						DECLARE @Id INT = (SELECT empl_Id FROM mant.tbEmpleados WHERE empl_Identidad = @empl_Identidad) 

				UPDATE mant.tbEmpleados
				SET
				empl_Nombre = @empl_Nombre,
				empl_Apellido = @empl_Apellido,
				empl_Identidad = @empl_Identidad,
				empl_FechaNacimiento = @empl_FechaNacimiento,
				empl_Direccion = @empl_Direccion,
				empl_Sexo = @empl_Sexo,
				empl_Telefono = @empl_Telefono,
				estc_Id = @estc_Id,
				carg_Id = @carg_Id,
				muni_Id = @muni_Id,
				empl_UserModificacion = @empl_UserModificacion,
				empl_FechaModificacion = GETDATE(),
				empl_Estado = 1
				WHERE   empl_Id = @Id

				SELECT 200 AS codeStatus, 'El cargo ha sido actualizado con éxito.' AS messageStatus
			END

			ELSE --Empleado no existe, se realiza la actualización
			BEGIN
				UPDATE mant.tbEmpleados
				SET
				empl_Nombre = @empl_Nombre,
				empl_Apellido = @empl_Apellido,
				empl_Identidad = @empl_Identidad,
				empl_FechaNacimiento = @empl_FechaNacimiento,
				empl_Direccion = @empl_Direccion,
				empl_Sexo = @empl_Sexo,
				empl_Telefono = @empl_Telefono,
				estc_Id = @estc_Id,
				carg_Id = @carg_Id,
				muni_Id = @muni_Id,
				empl_UserModificacion = @empl_UserModificacion,
				empl_FechaModificacion = GETDATE()
				WHERE   empl_Id = @empl_Id

				SELECT 200 AS codeStatus, 'El empleado ha sido actualizado con éxito.' AS messageStatus
			END

			COMMIT
		END TRY
		BEGIN CATCH
			ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE() AS messageStatus
		END CATCH

END
GO

CREATE OR ALTER PROC mant.UDP_tbEmpleados_DELETE
@empl_Id INT
AS BEGIN

  	BEGIN TRY
	BEGIN TRAN
			DECLARE @emple INT = (SELECT COUNT(*) FROM fact.tbFacturas WHERE empl_Id = @empl_Id)
			
			IF @emple > 0
			BEGIN
			SELECT 150 AS codeStatus, 'El empleado no ha sido despedido.' AS messageStatus
			END
			ELSE
			BEGIN
			UPDATE mant.tbEmpleados
			SET
				empl_Estado		=	0
				WHERE empl_Id	=	@empl_Id

			SELECT 200 AS codeStatus, 'El empleado ha sido eliminado con éxito.' AS messageStatus
			END
	COMMIT
	END TRY
	BEGIN CATCH
	ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH


END
GO

--*************************************************************/TABLA DE EMPLEADOS****************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*************************************************************/TABLA DE VISITANTES***************************************************************************--
CREATE OR ALTER PROC mant.UDP_tbVisitantes_INDEX
AS BEGIN

SELECT * FROM mant.VW_tbVisitantes
WHERE visi_Estado = 1;

END
GO

CREATE OR ALTER PROC mant.UDP_tbVisitantes_CREATE
@visi_Nombres NVARCHAR(100),
@visi_Apellido NVARCHAR(100),
@visi_RTN NVARCHAR(100),
@visi_Sexo CHAR(1),
@visi_UserCreacion INT
AS BEGIN

BEGIN TRY
BEGIN TRAN
	-- Si existe
		IF EXISTS (SELECT * FROM mant.tbVisitantes WHERE visi_RTN = @visi_RTN)
		BEGIN	
			SELECT 409 AS codeStatus, 'El número de RTN ya existe.' AS messageStatus
		END

		ELSE IF NOT EXISTS (SELECT * FROM mant.tbVisitantes WHERE visi_RTN = @visi_RTN)
		BEGIN
			INSERT INTO mant.tbVisitantes(visi_Nombres, visi_Apellido, visi_RTN, visi_Sexo, visi_UserCreacion)
			VALUES (@visi_Nombres, @visi_Apellido, @visi_RTN, @visi_Sexo, @visi_UserCreacion)

			BEGIN TRAN -- Agregado BEGIN TRAN

			SELECT 200 AS codeStatus, 'El visitate ha sido creado con éxito.' AS messageStatus

			COMMIT -- Agregado COMMIT
		END



COMMIT
END TRY

BEGIN CATCH
ROLLBACK
END CATCH
END
GO

EXEC mant.UDP_tbVisitantes_UPDATE 11, 'a', 'e', '000', 'f', 1
select * from mant.tbVisitantes


CREATE OR ALTER PROC mant.UDP_tbVisitantes_UPDATE
@visi_Id INT,
@visi_Nombres NVARCHAR(100),
@visi_Apellido NVARCHAR(100),
@visi_RTN NVARCHAR(100),
@visi_Sexo CHAR(1),
@visi_UserModificacion INT
AS BEGIN

  	BEGIN TRY
		BEGIN TRAN
			IF EXISTS (SELECT * FROM mant.tbVisitantes WHERE visi_RTN = @visi_RTN)
			BEGIN
				SELECT 409 AS codeStatus, 'El número de RTN ya existe.' AS messageStatus
			END
	
			ELSE -- Estadi civil no existe, se realiza la actualización
			BEGIN
				UPDATE mant.tbVisitantes
				SET
					  visi_Nombres =      @visi_Nombres,
					  visi_Apellido = @visi_Apellido,
					  visi_RTN = @visi_RTN,
					  visi_Sexo = @visi_Sexo,
					  visi_UserModificacion = @visi_UserModificacion,
					  visi_FechaModificacion = GETDATE()
				WHERE visi_Id = @visi_Id

				SELECT 200 AS codeStatus, 'El visitante ha sido actualizado con éxito.' AS messageStatus
			END

			COMMIT
		END TRY
		BEGIN CATCH
			ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE() AS messageStatus
		END CATCH

END
GO

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

--*****************************************************************TABLA DE ÁREAS*****************************************************************************--
--****************************************************************/TABLA DE ÁREAS*****************************************************************************--

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

--**************************************************************TABLA DE ALIMENTACIÓN************************************************************************--
--*************************************************************/TABLA DE ALIMENTACIÓN************************************************************************--

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


--****************************************************************PROCS DE BOTÁNICA**************************************************************************--

--*************************************************************TABLA DE AREAS BOTÁNICAS***********************************************************************--
--************************************************************/TABLA DE AREAS BOTÁNICAS***********************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*****************************************************************TABLA DE CUIDADOS***************************************************************************--
--****************************************************************/TABLA DE CUIDADOS***************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*****************************************************************TABLA DE PLANTAS****************************************************************************--
--****************************************************************/TABLA DE PLANTAS***************************************************************************--

--***************************************************************/PROCS DE BOTÁNICA**************************************************************************--


----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------


--***************************************************************PROCS DE FACTURACIÓN************************************************************************--

--*****************************************************************TABLA DE TICKETS***************************************************************************--
--****************************************************************/TABLA DE TICKETS***************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*************************************************************TABLA DE MÉTODOS DE PAGO***********************************************************************--
--************************************************************/TABLA DE MÉTODOS DE PAGO***********************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--****************************************************************TABLA DE FACTURAS***************************************************************************--
--***************************************************************/TABLA DE FACTURAS***************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--***********************************************************TABLA DE FACTURAS DETALLE************************************************************************--
--**********************************************************/TABLA DE FACTURAS DETALLE************************************************************************--

--**************************************************************/PROCS DE FACTURACIÓN************************************************************************--

--************************************************************************************************************************************************************--