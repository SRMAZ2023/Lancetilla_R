USE MASTER 
GO
USE db_Lancetilla
GO

--************************************************************************************************************************************************************--

--**************************************************************PROCS DE ACCESO******************************************************************************--

--*************************************************************TABLA DE USUARIOS******************************************************************************--
CREATE OR ALTER PROCEDURE acce.UDP_tbUsuarios_INSERT
@usua_NombreUsuario			NVARCHAR(200),
@empl_Id					INT,
@usua_Clave			NVARCHAR(150),
@usua_Admin					BIT,
@role_Id					INT,
@usua_UserCreacion			INT
AS
BEGIN
	BEGIN TRY
	--si existe
		IF EXISTS (SELECT * FROM acce.tbUsuarios WHERE usua_NombreUsuario = @usua_NombreUsuario)
	     BEGIN
            SELECT 409 AS codeStatus, 'El nombre de usuario ya existe.' AS messageStatus
         END
	--si no existe
		 ELSE IF NOT EXISTS (SELECT * FROM acce.tbUsuarios WHERE usua_NombreUsuario = @usua_NombreUsuario)
		 BEGIN
			
			DECLARE @Encrypt NVARCHAR(MAX) = (HASHBYTES('SHA2_512',@usua_Clave))
		

			INSERT INTO acce.tbUsuarios
			(usua_NombreUsuario,empl_Id, usua_Clave, usua_Admin,role_Id,usua_UserCreacion)
			VALUES
			(@usua_NombreUsuario,@empl_Id,@Encrypt,@usua_Admin,@role_Id,@usua_UserCreacion)

			SELECT 200 AS codeStatus, 'Usuario creado con éxito.' AS messageStatus
		END

	END TRY
	BEGIN CATCH
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH
END
GO


CREATE OR ALTER PROCEDURE acce.UDP_tbUsuarios_UPDATE
@usua_Id					INT,
@empl_Id					INT,
@usua_Admin					BIT,
@role_Id					INT,
@usua_UserModificacion		INT
AS
BEGIN
	BEGIN TRY
	BEGIN TRAN
			UPDATE acce.tbUsuarios
			SET
				empl_Id				=	@empl_Id,
				usua_Admin			=	@usua_Admin,
				role_Id				=	@role_Id,
				usua_UserModificacion	=	@usua_UserModificacion
				WHERE [usua_Id]		=	@usua_Id

			SELECT 200 AS codeStatus, 'Usuario modificado con éxito.' AS messageStatus
			COMMIT
	END TRY
	BEGIN CATCH
	ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH

END
GO

CREATE OR ALTER PROC acce.UDP_tbUsuarios_DELETE
@usua_Id INT
AS BEGIN

DELETE FROM acce.tbUsuarios WHERE usua_Id = @usua_Id

END
GO



  CREATE OR ALTER PROC acce.UDP_tbUsuarios_LOGIN  
@usua_NombreUsuario NVARCHAR(100),
@usua_Clave VARCHAR(100)
AS BEGIN

	DECLARE @Pass AS VARCHAR(MAX);
	SET @Pass = CONVERT(VARCHAR(MAX), HASHBYTES('sha2_512', @usua_Clave), 2);
	
	
	IF EXISTS (SELECT * FROM acce.VW_tbUsuarios WHERE usua_NombreUsuario = @usua_NombreUsuario AND usua_Clave = @Pass AND usua_Estado = 1)
	BEGIN
            SELECT * FROM acce.VW_tbUsuarios
			WHERE usua_NombreUsuario = @usua_NombreUsuario AND usua_Clave = @Pass
    END
	IF EXISTS (SELECT * FROM acce.VW_tbUsuarios WHERE usua_NombreUsuario = @usua_NombreUsuario AND usua_Clave = @Pass AND usua_Estado = 0)
	BEGIN
			SELECT	usua_Id = 0 ,
					usua_NombreUsuario = 'Usuario No Valido'
	END
	IF NOT EXISTS (SELECT * FROM acce.VW_tbUsuarios WHERE usua_NombreUsuario = @usua_NombreUsuario AND usua_Clave = @Pass)
	BEGIN
			SELECT	usua_Id = 0 ,
					usua_NombreUsuario = 'Usuario o Contraseña Incorrectos'
	END
END
GO
--************************************************************/TABLA DE USUARIOS******************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--**************************************************************TABLA DE ROLES********************************************************************************--
CREATE OR ALTER PROC acce.UDP_tbRoles_CREATE
@role_DEscripcion NVARCHAR(100),
@role_UserCreacion INT
AS BEGIN
BEGIN TRY
	--si existe
		IF EXISTS (SELECT * FROM acce.tbRoles WHERE role_Descripcion = @role_Descripcion)
	     BEGIN
            SELECT 409 AS codeStatus, 'El rol ya existe.' AS messageStatus
         END
	--si no existe
		 ELSE IF NOT EXISTS (SELECT * FROM acce.tbRoles WHERE role_Descripcion = @role_Descripcion)
		 BEGIN
			
			INSERT INTO acce.tbRoles
			(role_Descripcion, role_UserCreacion)
			VALUES
			(@role_Descripcion, @role_UserCreacion)

			SELECT 200 AS codeStatus, 'Rol creado con éxito.' AS messageStatus

		END

COMMIT
END TRY
BEGIN CATCH
ROLLBACK
		SELECT 500 AS codeStatus, ERROR_MESSAGE() AS messageStatus

END CATCH
END
GO

CREATE OR ALTER PROC acce.UDP_tbRoles_UPDATE
@role_Id INT,
@role_Descripcion NVARCHAR(100),
@role_UserModificacion INT
AS BEGIN

	BEGIN TRY
	BEGIN TRAN
	--si existe
		IF EXISTS (SELECT * FROM acce.tbRoles WHERE role_Descripcion = @role_Descripcion)
	     BEGIN
            SELECT 409 AS codeStatus, 'El Rol ya existe.' AS messageStatus
         END
	--si no existe
		 ELSE IF NOT EXISTS (SELECT * FROM acce.tbRoles WHERE role_Descripcion = @role_Descripcion)
		 BEGIN
			


	UPDATE acce.tbRoles
	SET role_Descripcion	= @role_Descripcion,
		role_UserModificacion	= @role_UserModificacion
		WHERE role_Id = @role_Id

			SELECT 200 AS codeStatus, 'Rol modificado con éxito.' AS messageStatus
		END
		COMMIT
	END TRY
	BEGIN CATCH
	ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH

END
GO


CREATE OR ALTER PROC acce.UDP_tbRoles_DELETE
@role_Id INT
AS BEGIN 
BEGIN TRY 
BEGIN TRAN

			DECLARE @rol INT = (SELECT COUNT(*) FROM acce.tbUsuarios WHERE role_Id = @role_Id)
			
			IF @rol > 0
			BEGIN
			SELECT 202 AS codeStatus, 'El rol que desea eliminar está en uso.' AS messageStatus
			END
			ELSE
			BEGIN

			DELETE FROM acce.tbRoles WHERE role_Id = @role_Id
			SELECT 200 AS codeStatus, 'El rol ha sido eliminado con éxito.' AS messageStatus
			END

COMMIT
END TRY

BEGIN CATCH
ROLLBACK
		SELECT 500 AS codeStatus, ERROR_MESSAGE() AS messageStatus

END CATCH
END
GO
--*************************************************************/TABLA DE ROLES********************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*******************************************************TABLA DE ROLES POR PANTALLA**************************************************************************--
CREATE OR ALTER PROC acce.UDP_tbRolesPantalla_CREATE
@role_Id INT,
@pant_Id INT,
@ropa_UserCreacion INT
AS BEGIN
BEGIN TRY

BEGIN TRAN

INSERT INTO acce.tbRolesPantallas(role_Id, pant_Id, ropa_UserCreacion)
VALUES (@role_Id, @pant_Id, @ropa_UserCreacion)

			SELECT 200 AS codeStatus, 'Rol por pantalla creado con éxito.' AS messageStatus

COMMIT
END TRY

BEGIN CATCH
ROLLBACK
		SELECT 500 AS codeStatus, ERROR_MESSAGE() AS messageStatus

END CATCH
END
GO

CREATE OR ALTER PROC acce.UDP_tbRolesPantalla_UPDATE
@ropa_Id INT,
@role_Id INT,
@pant_Id INT,
@ropa_UserModificacion INT
AS BEGIN
BEGIN TRY
BEGIN TRAN

UPDATE acce.tbRolesPantallas 
SET role_Id = @role_Id,
	pant_Id = @pant_Id,
	ropa_UserModificacion = @ropa_UserModificacion,
	ropa_FechaModificacion = GETDATE()
	WHERE ropa_Id = @ropa_Id

	SELECT 200 AS codeStatus, 'Rol por pantalla modificado con éxito.' AS messageStatus

COMMIT
END TRY

BEGIN CATCH
ROLLBACK
		SELECT 500 AS codeStatus, ERROR_MESSAGE() AS messageStatus

END CATCH
END
GO

CREATE OR ALTER PROC acce.UDP_tbRolesPantallas_PANTALLAROL
@role_Id INT
AS BEGIN

SELECT * FROM acce.tbRolesPantallas
WHERE role_Id = @role_Id

END
GO
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
			SELECT 202 AS codeStatus, 'El departamento que desea eliminar está en uso.' AS messageStatus
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
			SELECT 202 AS codeStatus, 'El municipio que desea eliminar está en uso.' AS messageStatus
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

CREATE OR ALTER PROC mant.UDP_tbEstadosCiviles_DELETE
@estc_Id INT
AS BEGIN

  	BEGIN TRY
	BEGIN TRAN
			DECLARE @estados INT = (SELECT COUNT(*) FROM mant.tbEmpleados WHERE estc_Id = @estc_Id)
			
			IF @estados > 0
			BEGIN
			SELECT 202 AS codeStatus, 'El estado civil que desea eliminar está en uso.' AS messageStatus
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
				WHERE carg_Id = @carg_Id

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
			DECLARE @cargos INT = (SELECT COUNT(*) FROM mant.tbEmpleados WHERE carg_Id = @carg_Id)
			
			IF @cargos > 0
			BEGIN
			SELECT 202 AS codeStatus, 'El cargo que desea eliminar está en uso.' AS messageStatus
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
			SELECT 202 AS codeStatus, 'El empleado no ha sido despedido.' AS messageStatus
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

--EXEC mant.UDP_tbVisitantes_UPDATE 11, 'a', 'e', '111', 'f', 1
--select * from mant.tbVisitantes


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

--**********************************************************TABLA DE TIPOS MANTENIMIENTO**********************************************************************--
CREATE OR ALTER PROC mant.UDP_tbTiposMantenimientos_CREATE
@tima_Descripcion NVARCHAR(100),
@tima_UserCreacion INT
AS BEGIN

	BEGIN TRY
		BEGIN TRAN

		-- Si existe
		IF EXISTS (SELECT * FROM mant.tbTiposMantenimientos WHERE tima_Descripcion = @tima_Descripcion AND tima_Estado = 1)
		BEGIN
			SELECT 409 AS codeStatus, 'El tipo de mantenimiento ya existe.' AS messageStatus
		END


		ELSE IF EXISTS (SELECT * FROM mant.tbTiposMantenimientos WHERE tima_Descripcion = @tima_Descripcion AND tima_Estado = 0)
		BEGIN
			DECLARE @Id INT = (SELECT tima_Id FROM mant.tbTiposMantenimientos WHERE tima_Descripcion = tima_Descripcion) 

			BEGIN TRAN -- Agregado BEGIN TRAN

			UPDATE mant.tbTiposMantenimientos
			SET
				tima_Descripcion = @tima_Descripcion,
				tima_UserCreacion = @tima_UserCreacion,
				tima_UserModificacion = NULL,
				tima_Estado = 1
			WHERE tima_Id = @Id

		    SELECT 200 AS codeStatus, 'El tipo de mantenimiento ha sido creado con éxito.' AS messageStatus

			COMMIT -- Agregado COMMIT
		END


		ELSE IF NOT EXISTS (SELECT * FROM mant.tbTiposMantenimientos WHERE tima_Descripcion = @tima_Descripcion AND tima_Estado = 1)
		BEGIN
			INSERT INTO mant.tbTiposMantenimientos(tima_Descripcion, tima_UserCreacion)
			VALUES (@tima_Descripcion, @tima_UserCreacion)

			BEGIN TRAN -- Agregado BEGIN TRAN

			SELECT 200 AS codeStatus, 'El tipo de mantenimiento ha sido creado con éxito.' AS messageStatus

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



CREATE OR ALTER PROC mant.UDP_tbTiposMantenimientos_UPDATE
@tima_Id INT,
@tima_Descripcion NVARCHAR(100),
@tima_UserModificacion INT
AS BEGIN

  	BEGIN TRY
		BEGIN TRAN
			IF EXISTS (SELECT * FROM mant.tbTiposMantenimientos WHERE tima_Descripcion= @tima_Descripcion AND tima_Estado= 1)
			BEGIN
				SELECT 409 AS codeStatus, 'El tipo de mantenimiento ya existe.' AS messageStatus
			END
			ELSE IF EXISTS (SELECT * FROM mant.tbTiposMantenimientos WHERE tima_Descripcion = @tima_Descripcion AND tima_Estado = 0)
			BEGIN
						DECLARE @Id INT = (SELECT tima_Id FROM mant.tbTiposMantenimientos WHERE tima_Descripcion= @tima_Descripcion) 

				UPDATE mant.tbTiposMantenimientos
				SET
						tima_Descripcion =     @tima_Descripcion,
						tima_UserModificacion = @tima_UserModificacion,
						tima_Estado = 1
				WHERE   tima_Id = @Id

				SELECT 200 AS codeStatus, 'El tipo de mantenimiento ha sido actualizado con éxito.' AS messageStatus
			END

			ELSE -- Tipo de mantenimiento no existe, se realiza la actualización
			BEGIN
				UPDATE mant.tbTiposMantenimientos
				SET
					  tima_Descripcion =     @tima_Descripcion,
					  tima_UserModificacion = @tima_UserModificacion,
					  tima_FechaModificacion = GETDATE()
				WHERE tima_Id = @tima_Id

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

CREATE OR ALTER PROC mant.UDP_tbTiposMantenimientos_DELETE
@tima_Id INT
AS BEGIN

  	BEGIN TRY
	BEGIN TRAN
			DECLARE @tiposmants INT = (SELECT COUNT(*) FROM mant.tbMantenimientos WHERE tima_Id = @tima_Id)
			
			IF @tiposmants > 0
			BEGIN
			SELECT 202 AS codeStatus, 'El tipo de mantenimiento está en uso.' AS messageStatus
			END
			ELSE
			BEGIN
			UPDATE mant.tbTiposMantenimientos
			SET
				tima_Estado		=	0
				WHERE tima_Id	=	@tima_Id

			SELECT 200 AS codeStatus, 'El tipo de mantenimiento ha sido eliminado con éxito.' AS messageStatus
			END
	COMMIT
	END TRY
	BEGIN CATCH
	ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH
END
GO

--*********************************************************/TABLA DE TIPOS MANTENIMIENTO**********************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*************************************************************TABLA DE MANTENIMIENTO*************************************************************************--
CREATE OR ALTER PROC mant.UDP_tbMantenimientos_CREATE 
@mant_Observaciones NVARCHAR(200),
@tima_Id INT,
@mant_UserCreacion INT
AS BEGIN 
BEGIN TRY
BEGIN TRAN

		-- Si existe
		IF EXISTS (SELECT * FROM mant.tbMantenimientos WHERE mant_Observaciones = @mant_Observaciones AND mant_Estado = 1)
		BEGIN
			SELECT 409 AS codeStatus, 'El mantenimiento ya existe.' AS messageStatus
		END


		ELSE IF EXISTS (SELECT * FROM mant.tbMantenimientos WHERE mant_Observaciones = @mant_Observaciones AND mant_Estado = 0)
		BEGIN
			DECLARE @Id INT = (SELECT mant_Id FROM mant.tbMantenimientos WHERE mant_Observaciones = @mant_Observaciones) 

			BEGIN TRAN -- Agregado BEGIN TRAN

			UPDATE mant.tbMantenimientos
			SET
				mant_Observaciones =  @mant_Observaciones,
				tima_Id = @tima_Id,
				mant_UserCreacion = @mant_UserCreacion,
				mant_UserModificacion = NULL,
				mant_Estado = 1
			WHERE mant_Id = @Id

		    SELECT 200 AS codeStatus, 'El mantenimiento ha sido creado con éxito.' AS messageStatus

			COMMIT -- Agregado COMMIT
		END


		ELSE IF NOT EXISTS (SELECT * FROM mant.tbMantenimientos WHERE mant_Observaciones= @mant_Observaciones AND mant_Estado = 1)
		BEGIN
			INSERT INTO mant.tbMantenimientos(mant_Observaciones, tima_Id, mant_UserCreacion)
			VALUES (@mant_Observaciones, @tima_Id, @mant_UserCreacion)

			BEGIN TRAN -- Agregado BEGIN TRAN

			SELECT 200 AS codeStatus, 'El mantenimiento ha sido creado con éxito.' AS messageStatus

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




CREATE OR ALTER PROC mant.UDP_tbMantenimientos_UPDATE
@mant_Id INT,
@tima_Id INT,
@mant_Observaciones NVARCHAR(100),
@mant_UserModificacion INT
AS BEGIN

BEGIN TRY
BEGIN TRAN 

IF EXISTS (SELECT * FROM mant.tbMantenimientos WHERE mant_Observaciones = @mant_Observaciones AND mant_Estado = 1)
			BEGIN
				SELECT 409 AS codeStatus, 'El mantenimiento ya existe.' AS messageStatus
			END
			ELSE IF EXISTS (SELECT * FROM mant.tbMantenimientos WHERE mant_Observaciones= @mant_Observaciones AND mant_Estado= 0)
			BEGIN
						DECLARE @Id INT = (SELECT mant_Id FROM mant.tbMantenimientos WHERE mant_Observaciones= @mant_Observaciones) 

				UPDATE mant.tbMantenimientos
				SET
						mant_Observaciones =    @mant_Observaciones,
						tima_Id = @tima_Id,
						mant_UserModificacion = @mant_UserModificacion,
						mant_Estado = 1
				WHERE   mant_Id = @Id

				SELECT 200 AS codeStatus, 'El mantenimiento ha sido actualizado con éxito.' AS messageStatus
			END

			ELSE -- mantenimiento no existe, se realiza la actualización
			BEGIN
				UPDATE mant.tbMantenimientos
				SET
					  mant_Observaciones =    @mant_Observaciones,
					  tima_Id = @tima_Id,
					  mant_UserModificacion = @mant_UserModificacion,
					  mant_FechaModificacion = GETDATE()
				WHERE mant_Id = @tima_Id

				SELECT 200 AS codeStatus, 'El mantenimiento ha sido actualizado con éxito.' AS messageStatus
			END


COMMIT
END TRY

BEGIN CATCH
ROLLBACK
END CATCH 
END
GO




CREATE OR ALTER PROC mant.UDP_tbMantenimientos_DELETE
@mant_Id INT
AS BEGIN

	BEGIN TRY
	BEGIN TRAN
			DECLARE @mantes INT = (SELECT COUNT(*) FROM mant.tbMantenimientoAnimal WHERE mant_Id = @mant_Id)
			
			IF @mantes > 0
			BEGIN
			SELECT 202 AS codeStatus, 'El mantenimiento todavía se usa.' AS messageStatus
			END
			ELSE
			BEGIN
			UPDATE mant.tbMantenimientos
			SET
				mant_Estado		=	0
				WHERE mant_Id	=	@mant_Id

			SELECT 200 AS codeStatus, 'El mantenimiento ha sido eliminado con éxito.' AS messageStatus
			END
	COMMIT
	END TRY
	BEGIN CATCH
	ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH

END
GO
--************************************************************/TABLA DE MANTENIMIENTO*************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*******************************************************TABLA DE MANTENIMIENTO POR ANIMAL********************************************************************--
GO 
CREATE OR ALTER PROC mant.UDP_tbMantenimientosAnimal_SELECT
AS
BEGIN
	
	SELECT * FROM mant.VW_MantenimientoAnimales where maan_Estado = 1

END

GO 
CREATE OR ALTER PROC mant.UDP_tbMantenimientosAnimal_FIND 29
@anim_Id INT
AS
BEGIN

BEGIN TRY


    DECLARE @FechaActual DATE = CONVERT(DATE, GETDATE())

	DECLARE @ExisteHoy INT = (SELECT COUNT(*)
    FROM mant.VW_MantenimientoAnimales
    WHERE maan_Estado = 1
        AND anim_Id = @anim_Id
        AND CONVERT(DATE, maan_FechaCreacion) = @FechaActual)

	IF @ExisteHoy > 0 
	BEGIN
	 SELECT *
    FROM mant.VW_MantenimientoAnimales
    WHERE maan_Estado = 1
        AND anim_Id = @anim_Id
        AND CONVERT(DATE, maan_FechaCreacion) = @FechaActual
		UNION ALL
	SELECT 200 AS codeStatus, @ExisteHoy AS messageStatus
	END
   
   IF @ExisteHoy = 0 
	BEGIN
	 SELECT *
    FROM mant.VW_MantenimientoAnimales
    WHERE maan_Estado = 1
        AND anim_Id = @anim_Id
		UNION ALL
	SELECT 200 AS codeStatus, @ExisteHoy AS messageStatus
	END



			
END TRY

BEGIN CATCH
ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus

END CATCH
END
go

--select getdate()

GO
CREATE OR ALTER PROC mant.UDP_tbMantenimientosAnimal_CREATE   
@anim_Id INT,
@mant_Id INT,
@maan_Fecha DATE,
@maan_UserCreacion INT
AS BEGIN

BEGIN TRY

			INSERT INTO mant.tbMantenimientoAnimal(anim_Id, mant_Id, maan_Fecha,maan_UserCreacion)
			VALUES  (@anim_Id, @mant_Id,@maan_Fecha, @maan_UserCreacion)

			SELECT 200 AS codeStatus, 'El mantenimiento por animal ha sido creado con éxito.' AS messageStatus
END TRY

BEGIN CATCH
ROLLBACK
END CATCH

END
GO


CREATE OR ALTER PROC mant.UDP_tbMantenimientosAnimal_UPDATE
@maan_Id INT,
@anim_Id INT,
@mant_Id INT,
@maan_Fecha DATE,
@maan_UserModificacion INT
AS BEGIN
BEGIN TRY


BEGIN TRAN
UPDATE mant.tbMantenimientoAnimal

SET anim_Id = @anim_Id,
mant_Id = @mant_Id,
maan_Fecha = @maan_Fecha,
maan_UserModificacion = @maan_UserModificacion,
maan_FechaModificacion = GETDATE()
WHERE maan_Id = @maan_Id
			SELECT 200 AS codeStatus, 'El mantenimiento por animal ha sido creado con éxito.' AS messageStatus
COMMIT
			
END TRY

BEGIN CATCH
ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus

END CATCH
END
GO





GO
CREATE OR ALTER PROC mant.UDP_tbMantenimientoAnimal_DELETE
@maan_Id INT
 AS BEGIN

 BEGIN TRY 
 BEGIN TRAN

 UPDATE mant.tbMantenimientoAnimal 
 SET maan_Estado = 0
 WHERE maan_Id = @maan_Id
 			SELECT 200 AS codeStatus, 'El mantenimiento ha sido eliminado con éxito.' AS messageStatus

 COMMIT
 END TRY


 BEGIN CATCH
 ROLLBACK
 			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus

 END CATCH
 END
 GO


 --******************************************************/TABLA DE MANTENIMIENTO POR ANIMAL********************************************************************--

--**********************************************************/PROCS DE MANTENIMIENTO**************************************************************************--


----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------


--***************************************************************PROCS DE ZOOLOGICO**************************************************************************--

--*****************************************************************TABLA DE ÁREAS*****************************************************************************--
CREATE OR ALTER PROC zool.UDP_tbAreasZoologico_CREATE
@arzo_Descripcion NVARCHAR(100),
@arzo_UserCreacion INT
AS BEGIN

BEGIN TRY

	BEGIN TRAN

		-- Si existe
		IF EXISTS (SELECT * FROM zool.tbAreasZoologico WHERE arzo_Descripcion= @arzo_Descripcion AND arzo_Estado = 1)
		BEGIN
			SELECT 409 AS codeStatus, 'El área zoológica ya existe.' AS messageStatus
		END


		ELSE IF EXISTS (SELECT * FROM zool.tbAreasZoologico WHERE arzo_Descripcion = @arzo_Descripcion AND arzo_Estado = 0)
		BEGIN
			DECLARE @Id INT = (SELECT arzo_Id FROM zool.tbAreasZoologico WHERE arzo_Descripcion = @arzo_Descripcion) 

			BEGIN TRAN -- Agregado BEGIN TRAN

			UPDATE zool.tbAreasZoologico
			SET
				arzo_Descripcion =  @arzo_Descripcion,
				arzo_UserCreacion = @arzo_UserCreacion,
				arzo_UserModificacion = NULL,
				arzo_Estado = 1
			WHERE arzo_Id = @Id

		    SELECT 200 AS codeStatus, 'El área zoológica ha sido creada con éxito.' AS messageStatus

			COMMIT -- Agregado COMMIT
		END


		ELSE IF NOT EXISTS (SELECT * FROM zool.tbAreasZoologico WHERE arzo_Descripcion = @arzo_Descripcion AND arzo_Estado = 1)
		BEGIN
			INSERT INTO zool.tbAreasZoologico(arzo_Descripcion, arzo_UserCreacion)
			VALUES (@arzo_Descripcion, @arzo_UserCreacion)

			BEGIN TRAN -- Agregado BEGIN TRAN

			SELECT 200 AS codeStatus, 'El área zoológica ha sido creada con éxito.' AS messageStatus

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



CREATE OR ALTER PROC zool.UDP_tbAreasZoologico_UPDATE
@arzo_Id INT,
@arzo_Descripcion NVARCHAR(100),
@arzo_UserModificacion INT
AS BEGIN

  	BEGIN TRY
		BEGIN TRAN
		IF EXISTS (SELECT * FROM zool.tbAreasZoologico WHERE arzo_Descripcion= @arzo_Descripcion AND arzo_Estado = 1)
			BEGIN
				SELECT 409 AS codeStatus, 'El área zoológica ya existe.' AS messageStatus
			END
		IF EXISTS (SELECT * FROM zool.tbAreasZoologico WHERE arzo_Descripcion= @arzo_Descripcion AND arzo_Estado = 0)
			BEGIN
						DECLARE @Id INT = (SELECT arzo_Id FROM zool.tbAreasZoologico WHERE arzo_Descripcion = @arzo_Descripcion) 

				UPDATE zool.tbAreasZoologico
				SET
						arzo_Descripcion =      @arzo_Descripcion,
						arzo_UserModificacion = @arzo_UserModificacion,
						arzo_Estado = 1
				WHERE   arzo_Id = @Id

				SELECT 200 AS codeStatus, 'El área zoológica ha sido actualizado con éxito.' AS messageStatus
			END

			ELSE -- Estadi civil no existe, se realiza la actualización
			BEGIN
				UPDATE zool.tbAreasZoologico
				SET
					  arzo_Descripcion =      @arzo_Descripcion,
					  arzo_FechaModificacion = GETDATE(),
					  arzo_UserModificacion = @arzo_UserModificacion
				WHERE arzo_Id = @arzo_Id

				SELECT 200 AS codeStatus, 'El área zoológica ha sido actualizado con éxito.' AS messageStatus
			END

			COMMIT
		END TRY
		BEGIN CATCH
			ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE() AS messageStatus
		END CATCH

END
GO

CREATE OR ALTER PROC zool.UDP_tbAreasZoologico_DELETE
@arzo_Id INT
AS BEGIN

  	BEGIN TRY
	BEGIN TRAN
			DECLARE @areaszoo INT = (SELECT COUNT(*) FROM zool.tbAnimales WHERE arzo_Id = @arzo_Id)
			
			IF @areaszoo > 0
			BEGIN
			SELECT 202 AS codeStatus, 'El área zoológica que desea eliminar está en uso.' AS messageStatus
			END
			ELSE
			BEGIN
			UPDATE zool.tbAreasZoologico
			SET
				arzo_Estado	=	0
				WHERE arzo_Id	=	@arzo_Id

			SELECT 200 AS codeStatus, 'El área zoológica ha sido eliminado con éxito.' AS messageStatus
			END
	COMMIT
	END TRY
	BEGIN CATCH
	ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH


END
GO


--****************************************************************/TABLA DE ÁREAS*****************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--**************************************************************TABLA DE HABITATS*****************************************************************************--
CREATE OR ALTER PROC zool.UDP_tbHabitat_CREATE
@habi_Descripcion NVARCHAR(100),
@habi_UserCreacion INT
AS BEGIN
BEGIN TRY

	BEGIN TRAN

		-- Si existe
		IF EXISTS (SELECT * FROM zool.tbHabitat WHERE habi_Descripcion = @habi_Descripcion AND habi_Estado = 1)
		BEGIN
			SELECT 409 AS codeStatus, 'El habitat ya existe.' AS messageStatus
		END


		ELSE IF EXISTS (SELECT * FROM zool.tbHabitat WHERE habi_Descripcion = @habi_Descripcion AND habi_Estado = 0)
		BEGIN
			DECLARE @Id INT = (SELECT habi_Id FROM zool.tbHabitat WHERE habi_Descripcion  = @habi_Descripcion ) 

			BEGIN TRAN -- Agregado BEGIN TRAN

			UPDATE zool.tbHabitat
			SET
				habi_Descripcion  =  @habi_Descripcion ,
				habi_UserCreacion = @habi_UserCreacion,
				habi_UserModificacion = NULL,
				habi_Estado = 1
			WHERE habi_Id = @Id

		    SELECT 200 AS codeStatus, 'El hábitat ha sido creada con éxito.' AS messageStatus

			COMMIT -- Agregado COMMIT
		END


		ELSE IF NOT EXISTS (SELECT * FROM zool.tbHabitat WHERE habi_Descripcion  = @habi_Descripcion AND habi_Estado = 1)
		BEGIN
			INSERT INTO zool.tbHabitat(habi_Descripcion , habi_UserCreacion)
			VALUES (@habi_Descripcion , @habi_UserCreacion)

			BEGIN TRAN -- Agregado BEGIN TRAN

			SELECT 200 AS codeStatus, 'El hábitat ha sido creada con éxito.' AS messageStatus

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


CREATE OR ALTER PROC zool.UDP_tbHabitat_UPDATE
@habi_Id INT,
@habi_Descripcion NVARCHAR(100),
@habi_UserModificacion INT
AS BEGIN

  	BEGIN TRY
		BEGIN TRAN
		IF EXISTS (SELECT * FROM zool.tbHabitat WHERE habi_Descripcion = @habi_Descripcion AND habi_Estado= 1)
			BEGIN
				SELECT 409 AS codeStatus, 'El hábitat ya existe.' AS messageStatus
			END
		IF EXISTS (SELECT * FROM zool.tbHabitat WHERE habi_Descripcion = @habi_Descripcion AND habi_Estado = 0)
			BEGIN
						DECLARE @Id INT = (SELECT habi_Id FROM zool.tbHabitat WHERE habi_Descripcion = @habi_Descripcion ) 

				UPDATE zool.tbHabitat
				SET
						habi_Descripcion =      @habi_Descripcion,
						habi_UserModificacion = @habi_UserModificacion,
						habi_Estado = 1
				WHERE   habi_Id = @Id

				SELECT 200 AS codeStatus, 'El hábitat ha sido actualizado con éxito.' AS messageStatus
			END

			ELSE -- Estadi civil no existe, se realiza la actualización
			BEGIN
				UPDATE zool.tbHabitat
				SET
					  habi_Descripcion =      @habi_Descripcion,
					  habi_FechaModificacion = GETDATE(),
					  habi_UserModificacion = @habi_UserModificacion
				WHERE habi_Id = @habi_Id

				SELECT 200 AS codeStatus, 'El hábitat ha sido actualizado con éxito.' AS messageStatus
			END

			COMMIT
		END TRY
		BEGIN CATCH
			ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE() AS messageStatus
		END CATCH

END
GO

CREATE OR ALTER PROC zool.UDP_tbHabitat_DELETE
@habi_Id INT
AS BEGIN

  	BEGIN TRY
	BEGIN TRAN
			DECLARE @habis INT = (SELECT COUNT(*) FROM zool.tbAnimales WHERE habi_Id = @habi_Id)
			
			IF @habis > 0
			BEGIN
			SELECT 202 AS codeStatus, 'El hábitat que desea eliminar está en uso.' AS messageStatus
			END
			ELSE
			BEGIN
			UPDATE zool.tbHabitat
			SET
				habi_Estado	=	0
				WHERE habi_Id	=	@habi_Id

			SELECT 200 AS codeStatus, 'El hábitat ha sido eliminado con éxito.' AS messageStatus
			END
	COMMIT
	END TRY
	BEGIN CATCH
	ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH


END
GO

--*************************************************************TABLA DE HABITATS*****************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--****************************************************************TABLA DE ESPECIES**************************************************************************--
CREATE OR ALTER PROC zool.UDP_tbtbEspecies_CREATE
@espe_Descripcion NVARCHAR(100),
@espe_UserCreacion INT
AS BEGIN

BEGIN TRY

	BEGIN TRAN

		-- Si existe
		IF EXISTS (SELECT * FROM zool.tbEspecies WHERE espe_Descripcion = @espe_Descripcion AND espe_Estado = 1)
		BEGIN
			SELECT 409 AS codeStatus, 'La especie ya existe.' AS messageStatus
		END


		ELSE IF EXISTS (SELECT * FROM zool.tbEspecies WHERE espe_Descripcion = @espe_Descripcion AND espe_Estado= 0)
		BEGIN
			DECLARE @Id INT = (SELECT espe_Id FROM zool.tbEspecies WHERE espe_Descripcion = @espe_Descripcion) 

			BEGIN TRAN -- Agregado BEGIN TRAN

			UPDATE zool.tbEspecies
			SET
				  espe_Descripcion =  @espe_Descripcion,
				  espe_UserCreacion = @espe_UserCreacion,
				  espe_UserModificacion = NULL,
				  espe_Estado = 1
			WHERE espe_Id = @Id

		    SELECT 200 AS codeStatus, 'La especie ha sido creada con éxito.' AS messageStatus

			COMMIT -- Agregado COMMIT
		END


		ELSE IF NOT EXISTS (SELECT * FROM zool.tbEspecies WHERE espe_Descripcion = @espe_Descripcion AND espe_Estado= 1)
		BEGIN
			INSERT INTO zool.tbEspecies(espe_Descripcion, espe_UserCreacion)
			VALUES (@espe_Descripcion, @espe_UserCreacion)

			BEGIN TRAN -- Agregado BEGIN TRAN

			SELECT 200 AS codeStatus, 'La especie ha sido creada con éxito.' AS messageStatus

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



CREATE OR ALTER PROC zool.UDP_tbEspecie_UPDATE
@espe_Id INT,
@espe_Descripcion NVARCHAR(100),
@espe_UserModificacion INT
AS BEGIN

  	BEGIN TRY
		BEGIN TRAN
		IF EXISTS (SELECT * FROM zool.tbEspecies WHERE espe_Descripcion = @espe_Descripcion AND espe_Estado= 1)
			BEGIN
				SELECT 409 AS codeStatus, 'La especie ya existe.' AS messageStatus
			END
		IF EXISTS (SELECT * FROM zool.tbEspecies WHERE espe_Descripcion = @espe_Descripcion AND espe_Estado= 0)
			BEGIN
			DECLARE @Id INT = (SELECT espe_Id FROM zool.tbEspecies WHERE espe_Descripcion = @espe_Descripcion) 

				UPDATE zool.tbEspecies
				SET
						espe_Descripcion =      @espe_Descripcion,
						espe_UserModificacion = @espe_UserModificacion,
						espe_Estado = 1
				WHERE   espe_Id = @Id

				SELECT 200 AS codeStatus, 'La especie ha sido actualizado con éxito.' AS messageStatus
			END

			ELSE --Especie no existe, se realiza la actualización
			BEGIN
				UPDATE zool.tbEspecies
				SET
					  espe_Descripcion =      @espe_Descripcion,
					  espe_FechaModificacion = GETDATE(),
					  espe_UserModificacion = @espe_UserModificacion
				WHERE espe_Id = @espe_Id

				SELECT 200 AS codeStatus, 'La especie ha sido actualizado con éxito.' AS messageStatus
			END

			COMMIT
		END TRY
		BEGIN CATCH
			ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE() AS messageStatus
		END CATCH

END
GO

CREATE OR ALTER PROC zool.UDP_tbEspecies_DELETE
@espe_Id INT
AS BEGIN

  	BEGIN TRY
	BEGIN TRAN
			DECLARE @especies INT = (SELECT COUNT(*) FROM zool.tbAnimales WHERE espe_Id = @espe_Id)
			
			IF @especies > 0
			BEGIN
			SELECT 202 AS codeStatus, 'La especie que desea eliminar está en uso.' AS messageStatus
			END
			ELSE
			BEGIN
			UPDATE zool.tbEspecies
			SET
				espe_Estado	=	0
				WHERE espe_Id	=	@espe_Id

			SELECT 200 AS codeStatus, 'La especie ha sido eliminado con éxito.' AS messageStatus
			END
	COMMIT
	END TRY
	BEGIN CATCH
	ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH


END
GO


--***************************************************************/TABLA DE ESPECIES**************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--**************************************************************TABLA DE ALIMENTACIÓN************************************************************************--
CREATE OR ALTER PROC zool.UDP_tbAlimentacion_CREATE
@alim_Descripcion NVARCHAR(100),
@alim_UserCreacion INT
AS BEGIN

BEGIN TRY

	BEGIN TRAN

		-- Si existe
		IF EXISTS (SELECT * FROM zool.tbAlimentacion WHERE alim_Descripcion = @alim_Descripcion AND alim_Estado= 1)
		BEGIN
			SELECT 409 AS codeStatus, 'La alimentación ya existe.' AS messageStatus
		END


		ELSE IF EXISTS (SELECT * FROM zool.tbAlimentacion WHERE alim_Descripcion = @alim_Descripcion AND alim_Estado= 0)
		BEGIN
			DECLARE @Id INT = (SELECT alim_Id FROM zool.tbAlimentacion WHERE alim_Descripcion= @alim_Descripcion) 

			BEGIN TRAN -- Agregado BEGIN TRAN

			UPDATE zool.tbAlimentacion
			SET
				  alim_Descripcion =  @alim_Descripcion,
				  alim_UserCreacion = @alim_UserCreacion,
				  alim_UserModificacion = NULL,
				  alim_Estado = 1
			WHERE alim_Id = @Id

		    SELECT 200 AS codeStatus, 'La alimentación ha sido creada con éxito.' AS messageStatus

			COMMIT -- Agregado COMMIT
		END


		ELSE IF NOT EXISTS (SELECT * FROM zool.tbAlimentacion WHERE alim_Descripcion= @alim_Descripcion AND alim_Estado= 1)
		BEGIN
			INSERT INTO zool.tbAlimentacion(alim_Descripcion, alim_UserCreacion)
			VALUES (@alim_Descripcion, @alim_UserCreacion)

			BEGIN TRAN -- Agregado BEGIN TRAN

			SELECT 200 AS codeStatus, 'La especie ha sido creada con éxito.' AS messageStatus

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



CREATE OR ALTER PROC zool.UDP_tbAlimentacion_UPDATE
@alim_Id INT,
@alim_Descripcion NVARCHAR(100),
@alim_UserModificacion INT
AS BEGIN

  	BEGIN TRY
		BEGIN TRAN
		IF EXISTS (SELECT * FROM zool.tbAlimentacion WHERE alim_Descripcion = @alim_Descripcion AND alim_Estado= 1)
			BEGIN
				SELECT 409 AS codeStatus, 'La alimentación ya existe.' AS messageStatus
			END
		IF EXISTS (SELECT * FROM zool.tbAlimentacion WHERE alim_Descripcion = @alim_Descripcion AND alim_Estado= 0)
			BEGIN
						DECLARE @Id INT = (SELECT alim_Id FROM zool.tbAlimentacion WHERE alim_Descripcion= @alim_Descripcion) 

				UPDATE zool.tbAlimentacion
				SET
						alim_Descripcion =      @alim_Descripcion,
						alim_UserModificacion = @alim_UserModificacion,
						alim_Estado = 1
				WHERE   alim_Id = @Id

				SELECT 200 AS codeStatus, 'La alimentación ha sido actualizado con éxito.' AS messageStatus
			END

			ELSE --Especie no existe, se realiza la actualización
			BEGIN
				UPDATE zool.tbAlimentacion
				SET
					  alim_Descripcion =      @alim_Descripcion,
					  alim_FechaModificacion = GETDATE(),
					  alim_UserModificacion = @alim_UserModificacion
				WHERE alim_Id = @alim_Id

				SELECT 200 AS codeStatus, 'La alimentación ha sido actualizado con éxito.' AS messageStatus
			END

			COMMIT
		END TRY
		BEGIN CATCH
			ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE() AS messageStatus
		END CATCH

END
GO

CREATE OR ALTER PROC zool.UDP_tbAlimentacion_DELETE
@alim_Id INT
AS BEGIN

  	BEGIN TRY
	BEGIN TRAN
			DECLARE @alims INT = (SELECT COUNT(*) FROM zool.tbAnimales WHERE alim_Id= @alim_Id)
			
			IF @alims > 0
			BEGIN
			SELECT 202 AS codeStatus, 'La alaimentación que desea eliminar está en uso.' AS messageStatus
			END
			ELSE
			BEGIN
			UPDATE zool.tbAlimentacion
			SET
				alim_Estado	=	0
				WHERE alim_Id	=	@alim_Id

			SELECT 200 AS codeStatus, 'La alimentación ha sido eliminado con éxito.' AS messageStatus
			END
	COMMIT
	END TRY
	BEGIN CATCH
	ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH


END
GO

--*************************************************************/TABLA DE ALIMENTACIÓN************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--****************************************************************TABLA DE ANIMALES**************************************************************************--
CREATE OR ALTER PROC zool.UDP_tbAnimales_CREATE
@anim_Nombre NVARCHAR(100),
@anim_NombreCientifico NVARCHAR(100),
@anim_Reino NVARCHAR(100),
@habi_Id INT,
@arzo_Id INT,
@alim_Id INT,
@espe_Id INT,
@anim_UserCreacion INT
AS BEGIN

BEGIN TRY

	BEGIN TRAN

		-- Si existe
		IF EXISTS (SELECT * FROM zool.tbAnimales WHERE anim_Nombre = @anim_Nombre AND anim_Estado = 1)
		BEGIN
			SELECT 409 AS codeStatus, 'El nombre del animal ya existe.' AS messageStatus
		END
		ELSE IF EXISTS (SELECT * FROM zool.tbAnimales WHERE anim_NombreCientifico = @anim_NombreCientifico AND anim_Estado = 1)
		BEGIN
			SELECT 409 AS codeStatus, 'El nombre científico del animal ya existe.' AS messageStatus
		END
		ELSE IF EXISTS (SELECT * FROM zool.tbAnimales WHERE anim_Nombre = @anim_Nombre AND anim_Estado= 0)
		BEGIN
			DECLARE @Id INT = (SELECT anim_Id FROM zool.tbAnimales WHERE anim_Nombre = @anim_Nombre ) 

			BEGIN TRAN -- Agregado BEGIN TRAN

			UPDATE zool.tbAnimales
			SET
				  anim_Nombre = @anim_Nombre,
				  anim_NombreCientifico = @anim_NombreCientifico,
				  anim_Reino = @anim_Reino,
				  habi_Id = @habi_Id,
				  arzo_Id = @arzo_Id,
				  alim_Id = @alim_Id,
				  espe_Id = @espe_Id,
				  anim_UserModificacion = NULL,
				  anim_Estado = 1
			WHERE anim_Id = @Id

		    SELECT 200 AS codeStatus, 'El animal ha sido creada con éxito.' AS messageStatus

			COMMIT -- Agregado COMMIT
		END


		ELSE IF NOT EXISTS (SELECT * FROM zool.tbAnimales WHERE anim_Nombre = @anim_Nombre AND anim_Estado= 1)
		BEGIN
			INSERT INTO zool.tbAnimales(anim_Nombre, anim_NombreCientifico, anim_Reino, habi_Id, arzo_Id, alim_Id, espe_Id, anim_UserCreacion)
			VALUES (@anim_Nombre, @anim_NombreCientifico, @anim_Reino, @habi_Id, @arzo_Id, @alim_Id, @espe_Id, @anim_UserCreacion)

			BEGIN TRAN -- Agregado BEGIN TRAN

			SELECT 200 AS codeStatus, 'El animal ha sido creada con éxito.' AS messageStatus

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

--exec zool.UDP_tbAnimales_CREATE 'R', 'GGG', 'a', 1, 1, 1,1,1
--select * from zool.tbAnimales

CREATE OR ALTER PROC zool.UDP_tbAnimales_UPDATE
@anim_Id INT,
@anim_Nombre NVARCHAR(100),
@anim_NombreCientifico NVARCHAR(100),
@anim_Reino NVARCHAR(100),
@habi_Id INT,
@arzo_Id INT,
@alim_Id INT,
@espe_Id INT,
@anim_UserModificacion INT
AS BEGIN

  	BEGIN TRY
		BEGIN TRAN
		IF EXISTS (SELECT * FROM zool.tbAnimales WHERE anim_Nombre = @anim_Nombre AND anim_Estado = 1)
		BEGIN
			SELECT 409 AS codeStatus, 'El nombre del animal ya existe.' AS messageStatus
		END
		ELSE IF EXISTS (SELECT * FROM zool.tbAnimales WHERE anim_NombreCientifico = @anim_NombreCientifico AND anim_Estado = 1)
		BEGIN
			SELECT 409 AS codeStatus, 'El nombre científico del animal ya existe.' AS messageStatus
		END
		ELSE IF EXISTS (SELECT * FROM zool.tbAnimales WHERE anim_Nombre = @anim_Nombre AND anim_Estado= 0)
		BEGIN
			DECLARE @Id INT = (SELECT anim_Id FROM zool.tbAnimales WHERE anim_Nombre = @anim_Nombre ) 

				UPDATE zool.tbAnimales
				SET
				  anim_Nombre = @anim_Nombre,
				  anim_NombreCientifico = @anim_NombreCientifico,
				  anim_Reino = @anim_Reino,
				  habi_Id = @habi_Id,
				  arzo_Id = @arzo_Id,
				  alim_Id = @alim_Id,
				  espe_Id = @espe_Id,
				  anim_UserModificacion = @anim_UserModificacion,
				  anim_Estado = 1
				WHERE   anim_Id = @Id

				SELECT 200 AS codeStatus, 'El animal ha sido actualizado con éxito.' AS messageStatus
			END

			ELSE --Especie no existe, se realiza la actualización
			BEGIN
				UPDATE zool.tbAnimales
				SET
				  anim_Nombre = @anim_Nombre,
				  anim_NombreCientifico = @anim_NombreCientifico,
				  anim_Reino = @anim_Reino,
				  habi_Id = @habi_Id,
				  arzo_Id = @arzo_Id,
				  alim_Id = @alim_Id,
				  espe_Id = @espe_Id,
				  anim_UserModificacion = @anim_UserModificacion,
				  anim_FechaModificacion = GETDATE()
				WHERE anim_Id = @anim_Id

				SELECT 200 AS codeStatus, 'El animal ha sido actualizado con éxito.' AS messageStatus
			END

			COMMIT
		END TRY
		BEGIN CATCH
			ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE() AS messageStatus
		END CATCH

END
GO

CREATE OR ALTER PROC zool.UDP_tbAnimales_DELETE
@anim_Id INT
AS BEGIN

  	BEGIN TRY
			UPDATE zool.tbAnimales
			SET
				anim_Estado	=	0
				WHERE anim_Id	=	anim_Id

			SELECT 200 AS codeStatus, 'El animal ha sido eliminado con éxito.' AS messageStatus
			
	
	END TRY
	BEGIN CATCH
	ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH


END
GO



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
CREATE OR ALTER PROC bota.UDP_tbAreasBotanicas_CREATE
@arbo_Descripcion NVARCHAR(100),
@arbo_UserCreacion INT
AS BEGIN

BEGIN TRY

	BEGIN TRAN

		-- Si existe
		IF EXISTS (SELECT * FROM bota.tbAreasBotanicas WHERE arbo_Descripcion = @arbo_Descripcion AND arbo_Estado= 1)
		BEGIN
			SELECT 409 AS codeStatus, 'El área botánica ya existe.' AS messageStatus
		END


		ELSE IF EXISTS (SELECT * FROM bota.tbAreasBotanicas WHERE arbo_Descripcion = @arbo_Descripcion AND arbo_Estado = 0)
		BEGIN
			DECLARE @Id INT = (SELECT arbo_Id FROM bota.tbAreasBotanicas WHERE arbo_Descripcion = @arbo_Descripcion ) 

			BEGIN TRAN -- Agregado BEGIN TRAN

			UPDATE bota.tbAreasBotanicas
			SET
				  arbo_Descripcion =  @arbo_Descripcion,
				  arbo_UserCreacion = @arbo_UserCreacion,
				  arbo_UserModificacion = NULL,
				  arbo_Estado = 1
			WHERE arbo_Id = @Id

		    SELECT 200 AS codeStatus, 'El área botánica ha sido creada con éxito.' AS messageStatus

			COMMIT -- Agregado COMMIT
		END


		ELSE IF NOT EXISTS (SELECT * FROM bota.tbAreasBotanicas WHERE arbo_Descripcion = @arbo_Descripcion AND arbo_Estado= 1)
		BEGIN
			INSERT INTO bota.tbAreasBotanicas(arbo_Descripcion , arbo_UserCreacion)
			VALUES (@arbo_Descripcion , @arbo_UserCreacion)

			BEGIN TRAN -- Agregado BEGIN TRAN

			SELECT 200 AS codeStatus, 'El área botánica ha sido creada con éxito.' AS messageStatus

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



CREATE OR ALTER PROC bota.UDP_tbAreasBotanicas_UPDATE
@arbo_Id INT,
@arbo_Descripcion NVARCHAR(100),
@arbo_UserModificacion INT
AS BEGIN

  	BEGIN TRY
		BEGIN TRAN
		IF EXISTS (SELECT * FROM bota.tbAreasBotanicas WHERE arbo_Descripcion = @arbo_Descripcion  AND arbo_Estado = 1)
			BEGIN
				SELECT 409 AS codeStatus, 'El área botánica ya existe.' AS messageStatus
			END
		IF EXISTS (SELECT * FROM bota.tbAreasBotanicas WHERE arbo_Descripcion = @arbo_Descripcion AND arbo_Estado= 0)
			BEGIN
						DECLARE @Id INT = (SELECT arbo_Id FROM bota.tbAreasBotanicas WHERE arbo_Descripcion = @arbo_Descripcion ) 

				UPDATE bota.tbAreasBotanicas
				SET
						arbo_Descripcion =      @arbo_Descripcion,
						arbo_UserModificacion = @arbo_UserModificacion,
						arbo_Estado = 1
				WHERE   arbo_Id = @Id

				SELECT 200 AS codeStatus, 'El área botánica ha sido actualizado con éxito.' AS messageStatus
			END

			ELSE --Área botánica no existe, se realiza la actualización
			BEGIN
				UPDATE bota.tbAreasBotanicas
				SET
					  arbo_Descripcion =      @arbo_Descripcion,
					  arbo_FechaModificacion = GETDATE(),
					  arbo_UserModificacion = @arbo_UserModificacion
				WHERE arbo_Id = @arbo_Id

				SELECT 200 AS codeStatus, 'El área botánica ha sido actualizado con éxito.' AS messageStatus
			END

			COMMIT
		END TRY
		BEGIN CATCH
			ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE() AS messageStatus
		END CATCH

END
GO

CREATE OR ALTER PROC bota.UDP_tbAreasBotanicas_DELETE
@arbo_Id INT
AS BEGIN

  	BEGIN TRY
	BEGIN TRAN
			DECLARE @arbos INT = (SELECT COUNT(*) FROM bota.tbPlantas WHERE arbo_Id = @arbo_Id)
			
			IF @arbos > 0
			BEGIN
			SELECT 202 AS codeStatus, 'El área botánica que desea eliminar está en uso.' AS messageStatus
			END
			ELSE
			BEGIN
			UPDATE bota.tbAreasBotanicas
			SET
				arbo_Estado	=	0
				WHERE arbo_Id	=	@arbo_Id

			SELECT 200 AS codeStatus, 'El área botánica ha sido eliminado con éxito.' AS messageStatus
			END
	COMMIT
	END TRY
	BEGIN CATCH
	ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH


END
GO


--************************************************************/TABLA DE AREAS BOTÁNICAS***********************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*****************************************************************TABLA DE CUIDADOS***************************************************************************--
CREATE OR ALTER PROC bota.UDP_tbCuidados_CREATE
@cuid_Descripcion NVARCHAR(100),
@cuid_Frecuencia NVARCHAR(100),
@cuid_UserCreacion INT
AS BEGIN

BEGIN TRY

	BEGIN TRAN

		-- Si existe
		IF EXISTS (SELECT * FROM bota.tbCuidados WHERE cuid_Descripcion = @cuid_Descripcion AND cuid_Estado= 1)
		BEGIN
			SELECT 409 AS codeStatus, 'El cuidado ya existe.' AS messageStatus
		END


		ELSE IF EXISTS (SELECT * FROM bota.tbCuidados WHERE cuid_Descripcion = @cuid_Descripcion AND cuid_Estado= 0)
		BEGIN
			DECLARE @Id INT = (SELECT cuid_Id FROM bota.tbCuidados WHERE cuid_Descripcion = @cuid_Descripcion ) 

			BEGIN TRAN -- Agregado BEGIN TRAN

			UPDATE bota.tbCuidados
			SET
				  cuid_Descripcion =  @cuid_Descripcion,
				  cuid_Frecuencia = @cuid_Frecuencia,
				  cuid_UserCreacion = @cuid_UserCreacion,
				  cuid_UserModificacion = NULL,
				  cuid_Estado = 1
			WHERE cuid_Id = @Id

		    SELECT 200 AS codeStatus, 'El cuidado ha sido creada con éxito.' AS messageStatus

			COMMIT -- Agregado COMMIT
		END


		ELSE IF NOT EXISTS (SELECT * FROM bota.tbCuidados WHERE cuid_Descripcion = @cuid_Descripcion AND cuid_Estado= 1)
		BEGIN
			INSERT INTO bota.tbCuidados(cuid_Descripcion, cuid_Frecuencia, cuid_UserCreacion)
			VALUES (@cuid_Descripcion, @cuid_Frecuencia, @cuid_UserCreacion)

			BEGIN TRAN -- Agregado BEGIN TRAN

			SELECT 200 AS codeStatus, 'El cuidado ha sido creada con éxito.' AS messageStatus

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



CREATE OR ALTER PROC bota.UDP_tbCuidados_UPDATE
@cuid_Id INT,
@cuid_Descripcion NVARCHAR(100),
@cuid_Frecuencia NVARCHAR(100),
@cuid_UserModificacion INT
AS BEGIN

  	BEGIN TRY
		BEGIN TRAN
		IF EXISTS (SELECT * FROM bota.tbCuidados WHERE cuid_Descripcion = @cuid_Descripcion AND cuid_Estado= 1)
			BEGIN
				SELECT 409 AS codeStatus, 'El cuidado ya existe.' AS messageStatus
			END
		IF EXISTS (SELECT * FROM bota.tbCuidados WHERE cuid_Descripcion = @cuid_Descripcion AND cuid_Estado= 0)
			BEGIN
						DECLARE @Id INT = (SELECT cuid_Id FROM bota.tbCuidados WHERE cuid_Descripcion = @cuid_Descripcion ) 

				UPDATE bota.tbCuidados
				SET
						cuid_Descripcion =      @cuid_Descripcion,
						cuid_Frecuencia = @cuid_Frecuencia,
						cuid_UserModificacion = @cuid_UserModificacion,
						cuid_Estado = 1
				WHERE   cuid_Id = @Id

				SELECT 200 AS codeStatus, 'El cuidado ha sido actualizado con éxito.' AS messageStatus
			END

			ELSE --Cuidado no existe, se realiza la actualización
			BEGIN
				UPDATE bota.tbCuidados
				SET
					  cuid_Descripcion =      @cuid_Descripcion,
					  cuid_Frecuencia = @cuid_Frecuencia,
					  cuid_FechaModificacion = GETDATE(),
					  cuid_UserModificacion = @cuid_UserModificacion
				WHERE cuid_Id = @cuid_Id

				SELECT 200 AS codeStatus, 'El cuidado ha sido actualizado con éxito.' AS messageStatus
			END

			COMMIT
		END TRY
		BEGIN CATCH
			ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE() AS messageStatus
		END CATCH

END
GO

CREATE OR ALTER PROC bota.UDP_tbCuidados_DELETE
@cuid_Id INT
AS BEGIN

  	BEGIN TRY
	BEGIN TRAN
			DECLARE @cuidas INT = (SELECT COUNT(*) FROM bota.tbPlantas WHERE cuid_Id = @cuid_Id)
			
			IF @cuidas > 0
			BEGIN
			SELECT 202 AS codeStatus, 'El cuidado que desea eliminar está en uso.' AS messageStatus
			END
			ELSE
			BEGIN
			UPDATE bota.tbCuidados
			SET
				cuid_Estado	=	0
				WHERE cuid_Id	=	@cuid_Id

			SELECT 200 AS codeStatus, 'El cuidado ha sido eliminado con éxito.' AS messageStatus
			END
	COMMIT
	END TRY
	BEGIN CATCH
	ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH


END
GO


--****************************************************************/TABLA DE CUIDADOS***************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*****************************************************************TABLA DE PLANTAS****************************************************************************--
GO
CREATE OR ALTER PROCEDURE bota.UDP_tbPlantas_FIND
@plan_Id	 int
AS
BEGIN

	/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [plan_Id]
      ,[plan_Nombre]
      ,[plan_NombreCientifico]
      ,[plan_Reino]
      ,[arbo_Id]
      ,[arbo_Descripcion]
      ,[cuid_Id]
      ,[cuid_Descripcion]
      ,[cuid_Frecuencia]
      ,[usua_UserCreaNombre]
      ,[plan_UserCreacion]
      ,[plan_FechaCreacion]
      ,[usua_UserModiNombre]
      ,[plan_UserModificacion]
      ,[plan_FechaModificacion]
      ,[plan_Estado]
  FROM [db_Lancetilla].[bota].[VW_tbPlantas]
WHERE [plan_Id] = @plan_Id

END

go
CREATE OR ALTER PROC bota.UDP_tbPlantas_CREATE 
@plan_Nombre NVARCHAR(100),
@plan_NombreCientifico NVARCHAR(100),
@plan_Reino NVARCHAR(100),
@arbo_Id INT,
@cuid_Id INT,
@plan_UserCreacion INT
AS BEGIN

BEGIN TRY

	BEGIN TRAN
				IF EXISTS (SELECT * FROM bota.tbPlantas WHERE RTRIM(plan_Nombre) = RTRIM(@plan_Nombre) AND RTRIM(plan_NombreCientifico) = RTRIM(@plan_NombreCientifico) AND plan_Estado = 1)
		BEGIN
			SELECT 409 AS codeStatus, 'El nombre y el nombre científico ya existe.' AS messageStatus
		END
		-- Si existe
		ELSE IF EXISTS (SELECT * FROM bota.tbPlantas WHERE RTRIM(plan_Nombre) = RTRIM(@plan_Nombre) AND plan_Estado = 1)
		BEGIN
			SELECT 409 AS codeStatus, 'La planta ya existe.' AS messageStatus
		END
		ELSE IF EXISTS (SELECT * FROM bota.tbPlantas WHERE RTRIM(plan_NombreCientifico) = RTRIM(@plan_NombreCientifico) AND plan_Estado = 1)
		BEGIN
			SELECT 409 AS codeStatus, 'El nombre científico de la planta ya existe.' AS messageStatus
		END

		IF EXISTS (SELECT * FROM bota.tbPlantas WHERE plan_Nombre = @plan_Nombre OR  plan_NombreCientifico = @plan_NombreCientifico AND plan_Estado = 0 )
		BEGIN
			DECLARE @Id INT = (SELECT cuid_Id FROM bota.tbPlantas WHERE plan_Nombre = @plan_Nombre OR plan_NombreCientifico = @plan_NombreCientifico) 

			BEGIN TRAN -- Agregado BEGIN TRAN

			UPDATE bota.tbPlantas
			SET
				  plan_Nombre = @plan_Nombre,
				  plan_NombreCientifico = @plan_NombreCientifico,
				  plan_Reino = @plan_Reino,
				  arbo_Id = @arbo_Id,
				  cuid_Id = @cuid_Id,
				  plan_UserCreacion = @plan_UserCreacion,
				  plan_UserModificacion = NULL,
				  plan_Estado = 1
			WHERE plan_Id = @Id

		    SELECT 200 AS codeStatus, 'La planta ha sido creada con éxito.' AS messageStatus

			COMMIT -- Agregado COMMIT
		END


		ELSE IF NOT EXISTS (SELECT * FROM bota.tbPlantas WHERE plan_Nombre = @plan_Nombre  OR plan_NombreCientifico = @plan_NombreCientifico AND plan_Estado= 1)
		BEGIN
			INSERT INTO bota.tbPlantas(plan_Nombre, plan_NombreCientifico, plan_Reino, arbo_Id, cuid_Id, plan_UserCreacion)
			VALUES (@plan_Nombre, @plan_NombreCientifico, @plan_Reino, @arbo_Id, @cuid_Id, @plan_UserCreacion)

			BEGIN TRAN -- Agregado BEGIN TRAN

			SELECT 200 AS codeStatus, 'La planta ha sido creada con éxito.' AS messageStatus

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



CREATE OR ALTER PROC bota.UDP_tbPlantas_UPDATE
@plan_Id INT,
@plan_Nombre NVARCHAR(100),
@plan_NombreCientifico NVARCHAR(100),
@plan_Reino NVARCHAR(100),
@arbo_Id INT,
@cuid_Id INT,
@plan_UserModificacion INT
AS BEGIN

  	BEGIN TRY
		BEGIN TRAN
		IF EXISTS (SELECT * FROM bota.tbPlantas WHERE RTRIM(plan_Nombre) = RTRIM(@plan_Nombre) AND RTRIM(plan_NombreCientifico) = RTRIM(@plan_NombreCientifico) AND plan_Estado = 1)
BEGIN
    SELECT 409 AS codeStatus, 'El nombre y el nombre científico ya existe.' AS messageStatus
END
-- Si existe
ELSE IF EXISTS (SELECT * FROM bota.tbPlantas WHERE RTRIM(plan_Nombre) = RTRIM(@plan_Nombre) AND plan_Estado = 1)
BEGIN
    SELECT 409 AS codeStatus, 'La planta ya existe.' AS messageStatus
END
ELSE IF EXISTS (SELECT * FROM bota.tbPlantas WHERE RTRIM(plan_NombreCientifico) = RTRIM(@plan_NombreCientifico) AND plan_Estado = 1)
BEGIN
    SELECT 409 AS codeStatus, 'El nombre científico de la planta ya existe.' AS messageStatus
END

		 IF EXISTS (SELECT * FROM bota.tbPlantas WHERE plan_Nombre = @plan_Nombre OR  plan_NombreCientifico = @plan_NombreCientifico AND plan_Estado = 0 )
		BEGIN
			DECLARE @Id INT = (SELECT cuid_Id FROM bota.tbPlantas WHERE plan_Nombre = @plan_Nombre OR plan_NombreCientifico = @plan_NombreCientifico) 

				UPDATE bota.tbPlantas
				SET
						plan_Nombre = @plan_Nombre,
						plan_NombreCientifico = @plan_NombreCientifico,
						plan_Reino = @plan_Reino,
						arbo_Id = @arbo_Id,
						cuid_Id = @cuid_Id,
						plan_UserModificacion = @plan_UserModificacion,
						plan_Estado = 1
				WHERE   plan_Id = @Id

				SELECT 200 AS codeStatus, 'La planta ha sido actualizada con éxito.' AS messageStatus
			END

			ELSE --Planta no existe, se realiza la actualización
			BEGIN
				UPDATE bota.tbPlantas
				SET
						plan_Nombre = @plan_Nombre,
						plan_NombreCientifico = @plan_NombreCientifico,
						plan_Reino = @plan_Reino,
						arbo_Id = @arbo_Id,
						cuid_Id = @cuid_Id,
					  plan_FechaModificacion = GETDATE(),
					  plan_UserModificacion = @plan_UserModificacion
				WHERE plan_Id = @cuid_Id

				SELECT 200 AS codeStatus, 'La planta ha sido actualizado con éxito.' AS messageStatus
			END

			COMMIT
		END TRY
		BEGIN CATCH
			ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE() AS messageStatus
		END CATCH

END
GO

CREATE OR ALTER PROC bota.UDP_tbPlanta_DELETE
@plan_Id INT
AS BEGIN

  	BEGIN TRY
	BEGIN TRAN
	
			UPDATE bota.tbPlantas
			SET
				plan_Estado	=	0
				WHERE plan_Id	=	@plan_Id

			SELECT 200 AS codeStatus, 'La planta ha sido eliminada con éxito.' AS messageStatus
			
	COMMIT
	END TRY
	BEGIN CATCH
	ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH


END
GO

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
CREATE OR ALTER PROC fact.UDP_tbTickets_CREATE
@tick_Descripcion NVARCHAR(100),
@tick_Precio DECIMAL(8,2),
@tick_UserCreacion INT
AS BEGIN

BEGIN TRY

	BEGIN TRAN

		-- Si existe
		IF EXISTS (SELECT * FROM fact.tbTickets WHERE tick_Descripcion = @tick_Descripcion AND tick_Estado= 1)
		BEGIN
			SELECT 409 AS codeStatus, 'El ticket ya existe.' AS messageStatus
		END


		ELSE IF EXISTS (SELECT * FROM fact.tbTickets WHERE tick_Descripcion = @tick_Descripcion AND tick_Estado= 0)
		BEGIN
			DECLARE @Id INT = (SELECT tick_Id FROM fact.tbTickets WHERE tick_Descripcion = tick_Descripcion ) 

			BEGIN TRAN -- Agregado BEGIN TRAN

			UPDATE fact.tbTickets
			SET
				  tick_Descripcion =  @tick_Descripcion,
				  tick_Precio = @tick_Precio,
				  tick_UserCreacion = @tick_UserCreacion,
				  tick_UserModificacion = NULL,
				  tick_Estado = 1
			WHERE tick_Id = @Id

		    SELECT 200 AS codeStatus, 'El ticket ha sido creado con éxito.' AS messageStatus

			COMMIT -- Agregado COMMIT
		END


		ELSE IF NOT EXISTS (SELECT * FROM fact.tbTickets WHERE tick_Descripcion = @tick_Descripcion AND tick_Estado= 1)
		BEGIN
			INSERT INTO fact.tbTickets(tick_Descripcion ,tick_Precio, tick_UserCreacion)
			VALUES (@tick_Descripcion, @tick_Precio,@tick_UserCreacion)

			BEGIN TRAN -- Agregado BEGIN TRAN

			SELECT 200 AS codeStatus, 'El área botánica ha sido creada con éxito.' AS messageStatus

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


--****************************************************************/TABLA DE TICKETS***************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*************************************************************TABLA DE MÉTODOS DE PAGO***********************************************************************--
CREATE OR ALTER PROC fact.UDP_tbMetodosPago_CREATE
@meto_Descripcion NVARCHAR(100),
@meto_UserCreacion INT
AS BEGIN

BEGIN TRY

	BEGIN TRAN

		-- Si existe
		IF EXISTS (SELECT * FROM fact.tbMetodosPago WHERE meto_Descripcion = @meto_Descripcion AND meto_Estado= 1)
		BEGIN
			SELECT 409 AS codeStatus, 'El método de pago ya existe.' AS messageStatus
		END


		ELSE IF EXISTS (SELECT * FROM fact.tbMetodosPago WHERE meto_Descripcion = @meto_Descripcion  AND meto_Estado = 0)
		BEGIN
			DECLARE @Id INT = (SELECT meto_Id FROM fact.tbMetodosPago WHERE meto_Descripcion = @meto_Descripcion ) 

			BEGIN TRAN -- Agregado BEGIN TRAN

			UPDATE fact.tbMetodosPago
			SET
				  meto_Descripcion =  @meto_Descripcion,
				  meto_UserCreacion = @meto_UserCreacion,
				  meto_UserModificacion = NULL,
				  meto_Estado = 1
			WHERE meto_Id = @Id

		    SELECT 200 AS codeStatus, 'El método de pago ha sido creada con éxito.' AS messageStatus

			COMMIT -- Agregado COMMIT
		END


		ELSE IF NOT EXISTS (SELECT * FROM fact.tbMetodosPago WHERE meto_Descripcion = @meto_Descripcion AND meto_Estado= 1)
		BEGIN
			INSERT INTO fact.tbMetodosPago(meto_Descripcion , meto_UserCreacion)
			VALUES (@meto_Descripcion, @meto_UserCreacion)

			BEGIN TRAN -- Agregado BEGIN TRAN

			SELECT 200 AS codeStatus, 'El método de pago ha sido creada con éxito.' AS messageStatus

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



CREATE OR ALTER PROC fact.UDP_tbMetodosPago_UPDATE
@meto_Id INT,
@meto_Descripcion NVARCHAR(100),
@meto_UserModificacion INT
AS BEGIN

  	BEGIN TRY
		BEGIN TRAN
		-- Si existe
		IF EXISTS (SELECT * FROM fact.tbMetodosPago WHERE meto_Descripcion = @meto_Descripcion AND meto_Estado= 1)
		BEGIN
			SELECT 409 AS codeStatus, 'El método de pago ya existe.' AS messageStatus
		END


		ELSE IF EXISTS (SELECT * FROM fact.tbMetodosPago WHERE meto_Descripcion = @meto_Descripcion  AND meto_Estado = 0)
		BEGIN
			DECLARE @Id INT = (SELECT meto_Id FROM fact.tbMetodosPago WHERE meto_Descripcion = @meto_Descripcion ) 
				UPDATE fact.tbMetodosPago
				SET
						meto_Descripcion =      @meto_Descripcion,
						meto_UserModificacion = @meto_UserModificacion,
						meto_Estado = 1
				WHERE   meto_Id = @Id

				SELECT 200 AS codeStatus, 'El método de pago ha sido actualizado con éxito.' AS messageStatus
			END

			ELSE --Métodos de pago no existe, se realiza la actualización
			BEGIN
				UPDATE fact.tbMetodosPago
				SET
					  meto_Descripcion =      @meto_Descripcion,
					  meto_FechaModificacion = GETDATE(),
					  meto_UserModificacion = @meto_UserModificacion
				WHERE meto_Id = @meto_Id

				SELECT 200 AS codeStatus, 'El método de pago ha sido actualizado con éxito.' AS messageStatus
			END

			COMMIT
		END TRY
		BEGIN CATCH
			ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE() AS messageStatus
		END CATCH

END
GO

CREATE OR ALTER PROC fact.UDP_tbMetodosPago_DELETE
@meto_Id INT
AS BEGIN

  	BEGIN TRY
	BEGIN TRAN
			DECLARE @arbos INT = (SELECT COUNT(*) FROM fact.tbFacturas WHERE meto_Id = @meto_Id)
			
			IF @arbos > 0
			BEGIN
			SELECT 202 AS codeStatus, 'El método de pago que desea eliminar está en uso.' AS messageStatus
			END
			ELSE
			BEGIN
			UPDATE fact.tbMetodosPago
			SET
				meto_Estado	=	0
				WHERE meto_Id	=	@meto_Id

			SELECT 200 AS codeStatus, 'El método de pago ha sido eliminado con éxito.' AS messageStatus
			END
	COMMIT
	END TRY
	BEGIN CATCH
	ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH


END
GO



--************************************************************/TABLA DE MÉTODOS DE PAGO***********************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--****************************************************************TABLA DE FACTURAS***************************************************************************--
--***************************************************************/TABLA DE FACTURAS***************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--***********************************************************TABLA DE FACTURAS DETALLE************************************************************************--
CREATE OR ALTER PROC fact.UDP_tbFacturasDetalle_DETALLESPORFACTS
@fact_Id INT
AS BEGIN

SELECT * FROM fact.VW_FacturasDetalle
WHERE fact_Id = @fact_Id

END
--**********************************************************/TABLA DE FACTURAS DETALLE************************************************************************--

--**************************************************************/PROCS DE FACTURACIÓN************************************************************************--

--************************************************************************************************************************************************************--