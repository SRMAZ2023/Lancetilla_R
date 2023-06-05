USE MASTER 
GO
USE db_Lancetilla
GO

--************************************************************************************************************************************************************--

--**************************************************************PROCS DE ACCESO******************************************************************************--

--*************************************************************TABLA DE USUARIOS******************************************************************************--

CREATE OR ALTER PROCEDURE Acce.UDP_tbUsuarios_DDLempleadosTieneusuario
AS
BEGIN
	SELECT t2.empl_Id, 
		   t2.empl_Nombre +' '+  t2.empl_Apellido as empl_Nombre 		  
	  FROM Acce. tbUsuarios  t1 
 FULL JOIN mant.tbEmpleados  t2  
		ON t1.empl_Id = t2.empl_Id 
	 WHERE t1.usua_Id IS NULL 
	   AND t2. empl_Estado  = 1 
END

GO

CREATE OR ALTER PROCEDURE acce.UDP_tbUsuarios_INSERT
@usua_NombreUsuario			NVARCHAR(200),
@empl_Id					INT,
@usua_Clave			VARCHAR(150),
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
			
			DECLARE @Pass AS VARCHAR(MAX);
	        SET @Pass = CONVERT(VARCHAR(MAX), HASHBYTES('sha2_512', @usua_Clave), 2);
		

			INSERT INTO acce.tbUsuarios
			(usua_NombreUsuario,empl_Id, usua_Clave, usua_Admin,role_Id,usua_UserCreacion)
			VALUES
			(@usua_NombreUsuario,@empl_Id,@Pass,@usua_Admin,@role_Id,@usua_UserCreacion)

			SELECT 200 AS codeStatus, 'Usuario creado con éxito.' AS messageStatus
		END

	END TRY
	BEGIN CATCH
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH
END
GO


CREATE OR ALTER PROCEDURE acce.UDP_tbUsuarios_UPDATE
@usua_NombreUsuario			NVARCHAR(200),
@usua_Id					INT,
@empl_Id					INT,
@usua_Admin					BIT,
@role_Id					INT,
@usua_UserModificacion		INT
AS
BEGIN
	BEGIN TRY
	BEGIN TRAN
			
			
			IF EXISTS (SELECT * FROM acce.tbUsuarios WHERE usua_NombreUsuario = @usua_NombreUsuario AND  usua_Id <> @usua_Id)
			BEGIN
			  SELECT 409 AS codeStatus, 'El nombre de usuario no esta disponible.' AS messageStatus
			END
			ELSE IF (@usua_Id = 1)
			BEGIN 
			   	SELECT 409 AS codeStatus, 'No se puede modificar al admin' AS messageStatus
			END
			ELSE
			BEGIN
			UPDATE acce.tbUsuarios
			SET
			    usua_NombreUsuario  =   @usua_NombreUsuario,
				empl_Id				=	@empl_Id,
				usua_Admin			=	@usua_Admin,
				role_Id				=	@role_Id,
				usua_UserModificacion	=	@usua_UserModificacion
				WHERE [usua_Id]		=	@usua_Id

			SELECT 200 AS codeStatus, 'Usuario modificado con éxito.' AS messageStatus
			COMMIT
			END
			
			
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

	BEGIN TRY
	BEGIN TRAN

	IF(@usua_Id = 1)
	BEGIN 
	  SELECT 200 AS codeStatus, 'No se puede eliminar al admin.' AS messageStatus
	END
	ELSE
	BEGIN 
	 
DELETE FROM acce.tbUsuarios WHERE usua_Id = @usua_Id

SELECT 200 AS codeStatus, 'Usuario eliminado con éxito.' AS messageStatus
			COMMIT

	END


	END TRY
	BEGIN CATCH
	ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH


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
@role_Descripcion NVARCHAR(100),
@role_UserCreacion INT
AS 
BEGIN
BEGIN TRY
	BEGIN TRANSACTION
	
	-- Verificar si el rol ya existe
	IF EXISTS (SELECT * FROM acce.tbRoles WHERE role_Descripcion = @role_Descripcion)
	BEGIN
		SELECT 200 AS role_UserCreacion, 'El rol ya existe.' AS role_Descripcion 
	END
	ELSE
	BEGIN
		-- Insertar el nuevo rol
		INSERT INTO acce.tbRoles (role_Descripcion, role_UserCreacion)
		VALUES (@role_Descripcion, @role_UserCreacion)
		
		-- Obtener el último ID de rol insertado
		DECLARE @role_Id INT
		SET @role_Id = SCOPE_IDENTITY()
		
		SELECT @role_Id AS role_Id, 200 AS role_UserCreacion, 'Rol creado con éxito.' AS role_Descripcion
	END
	
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
	
	SELECT 500 AS role_UserCreacion, ERROR_MESSAGE() AS role_Descripcion
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
		IF EXISTS (SELECT * FROM acce.tbRoles WHERE role_Descripcion = @role_Descripcion AND role_Id <> @role_Id)
	     BEGIN
            SELECT 409 AS codeStatus, 'El Rol ya existe.' AS messageStatus
         END
	--si no existe
		 ELSE
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

			DELETE FROM acce.tbRolesPantallas WHERE role_Id = @role_Id
			
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


CREATE OR ALTER PROC acce.UDP_tbRolesPantalla_Eliminar
@role_Id INT,
@pant_Id INT

AS BEGIN
BEGIN TRY
BEGIN TRAN

DELETE FROM acce.tbRolesPantallas WHERE role_Id = @role_Id AND pant_Id = @pant_Id

	SELECT 200 AS codeStatus, 'Pantalla eliminada.' AS messageStatus

COMMIT
END TRY

BEGIN CATCH
ROLLBACK
		SELECT 500 AS codeStatus, ERROR_MESSAGE() AS messageStatus

END CATCH
END
GO

CREATE OR ALTER PROC acce.UDP_tbRolesPantallas_PantallasNoTiene 
@role_Id INT
AS 
BEGIN
    SELECT T2.pant_Id, T2.pant_Descripcion
    FROM acce.tbPantallas T2
    LEFT JOIN acce.tbRolesPantallas T1 ON T1.pant_Id = T2.pant_Id AND T1.role_Id = @role_Id
    WHERE T1.role_Id IS NULL
END

GO
CREATE OR ALTER PROC acce.UDP_tbRolesPantallas_PANTALLAROL 
@role_Id INT
AS BEGIN

SELECT T1.pant_Id, T2.pant_Descripcion FROM acce.tbRolesPantallas T1
INNER JOIN ACCE.tbPantallas T2 ON T1.pant_Id = T2.pant_Id
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
@dept_Id  CHAR(2),
@dept_Descripcion  NVARCHAR(100),
@dept_UserCreacion INT
AS BEGIN

	BEGIN TRY
		BEGIN TRAN

		-- Si existe
		IF EXISTS (SELECT * FROM mant.tbDepartamentos WHERE dept_Descripcion = @dept_Descripcion OR dept_Id = @dept_Id AND dept_Estado = 1)
		BEGIN
			SELECT 409 AS codeStatus, 'El departamento ya existe.' AS messageStatus
		END
		ELSE IF EXISTS (SELECT * FROM mant.tbDepartamentos WHERE  dept_Id = @dept_Id AND dept_Estado = 1)
		BEGIN
			SELECT 409 AS codeStatus, 'Codigo de departamento no disponible.' AS messageStatus
		END
		
		ELSE IF EXISTS (SELECT * FROM mant.tbDepartamentos WHERE dept_Descripcion = @dept_Descripcion AND dept_Estado = 0)
		BEGIN
			DECLARE @Id INT = (SELECT dept_Id FROM mant.tbDepartamentos WHERE dept_Descripcion = @dept_Descripcion) 

			BEGIN TRAN -- Agregado BEGIN TRAN

			UPDATE mant.tbDepartamentos
			SET
				dept_Id          = @dept_Id,
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
			INSERT INTO mant.tbDepartamentos (dept_Id,dept_Descripcion, dept_UserCreacion)
			VALUES (@dept_Id, @dept_Descripcion, @dept_UserCreacion)

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
@dept_Id CHAR(2),
@dept_Descripcion NVARCHAR(100),
@dept_UserModificacion INT
AS BEGIN

  	BEGIN TRY
		BEGIN TRAN
			IF EXISTS (SELECT * FROM mant.tbDepartamentos WHERE dept_Descripcion = @dept_Descripcion AND dept_Id <> @dept_Id AND dept_Estado = 1)
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
@dept_Id CHAR(2)
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
	@muni_Id CHAR(4),
	@muni_Descripcion NVARCHAR(100),
	@dept_Id CHAR(2),
	@muni_UserCreacion INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN

		-- Si existe
		IF EXISTS (SELECT * FROM mant.tbMunicipios WHERE muni_Descripcion = @muni_Descripcion  AND muni_Estado = 1 AND dept_Id = @dept_Id)
		BEGIN
			SELECT 409 AS codeStatus, 'El municipio ya existe.' AS messageStatus
		END
		ELSE IF EXISTS (SELECT * FROM mant.tbMunicipios WHERE muni_Id = @muni_Id AND muni_Estado = 1)
		BEGIN
			SELECT 409 AS codeStatus, 'Codigo de municipio ocupado.' AS messageStatus
		END
		ELSE IF EXISTS (SELECT * FROM mant.tbMunicipios WHERE muni_Descripcion = @muni_Descripcion AND muni_Id = @muni_Id AND dept_Id = @dept_Id AND muni_Estado = 0)
		BEGIN
			DECLARE @Id INT = (SELECT muni_Id FROM mant.tbMunicipios WHERE muni_Descripcion = @muni_Descripcion) 

			BEGIN TRAN -- Agregado BEGIN TRAN

			UPDATE mant.tbMunicipios
			SET
				muni_Id = @muni_Id,
				muni_Descripcion = @muni_Descripcion,
				dept_Id = @dept_Id,
				muni_UserCreacion = @muni_UserCreacion,
				muni_UserModificacion = NULL,
				muni_Estado = 1
			WHERE muni_Id = @muni_Id

			SELECT 200 AS codeStatus, 'El municipio ha sido creado con éxito.' AS messageStatus

			COMMIT -- Agregado COMMIT
		END
		ELSE IF EXISTS (SELECT * FROM mant.tbMunicipios WHERE muni_Descripcion = @muni_Descripcion AND dept_Id <> @dept_Id  AND muni_Estado = 1)
		BEGIN
			INSERT INTO mant.tbMunicipios (muni_Id, muni_Descripcion, dept_Id, muni_UserCreacion)
			VALUES (@muni_Id, @muni_Descripcion, @dept_Id, @muni_UserCreacion)

			BEGIN TRAN -- Agregado BEGIN TRAN

			SELECT 200 AS codeStatus, 'El municipio ha sido creado con éxito.' AS messageStatus

			COMMIT -- Agregado COMMIT
		END
		ELSE IF NOT EXISTS (SELECT * FROM mant.tbMunicipios WHERE muni_Descripcion = @muni_Descripcion AND dept_Id <> @dept_Id  AND muni_Estado = 1)
		BEGIN
			INSERT INTO mant.tbMunicipios (muni_Id, muni_Descripcion, dept_Id, muni_UserCreacion)
			VALUES (@muni_Id, @muni_Descripcion, @dept_Id, @muni_UserCreacion)

			BEGIN TRAN -- Agregado BEGIN TRAN

			SELECT 200 AS codeStatus, 'El municipio ha sido creado con éxito.' AS messageStatus

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



CREATE OR ALTER PROC mant.UDP_tbMunicipios_UPDATE
@muni_Id CHAR(4),
@muni_Descripcion NVARCHAR(100),
@muni_UserModificacion INT
AS BEGIN

  	BEGIN TRY
		BEGIN TRAN
			IF EXISTS (SELECT * FROM mant.tbMunicipios WHERE muni_Descripcion = @muni_Descripcion  AND muni_Id <> @muni_Id AND muni_Estado = 1)
			BEGIN
				SELECT 409 AS codeStatus, 'El municipio ya existe.' AS messageStatus
			END
			ELSE IF EXISTS (SELECT * FROM mant.tbMunicipios WHERE  muni_Descripcion = @muni_Descripcion AND muni_Id = @muni_Id  AND muni_Estado = 1)
			BEGIN
				SELECT 200 AS codeStatus, 'El muniçipio ha sido actualizado con éxito.' AS messageStatus
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
@dept_Id CHAR(2)
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
			IF EXISTS (SELECT * FROM mant.tbEstadosCiviles WHERE estc_Descripcion = @estc_Descripcion AND estc_Id <> @estc_Id AND estc_Estado = 1)
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
			IF EXISTS (SELECT * FROM mant.tbCargos WHERE carg_Descripcion = @carg_Descripcion AND carg_Id <> @carg_Id AND carg_Estado = 1)
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
@muni_Id CHAR(4),
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
@muni_Id CHAR(4),
@empl_UserModificacion INT
AS BEGIN

  	BEGIN TRY
		BEGIN TRAN
			IF EXISTS (SELECT * FROM mant.tbEmpleados WHERE empl_Identidad = @empl_Identidad AND empl_Id <> @empl_Id AND empl_Estado = 1)
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

				SELECT 200 AS codeStatus, 'El empleado ha sido actualizado con éxito.' AS messageStatus
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
			SELECT 500 AS codeStatus, 'El empleado ha sido actualizado con éxito.' AS messageStatus
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
		
		
		SELECT  409 AS visi_UserCreacion, 'El visitante ya existe.' AS visi_Apellido
		
				
		END

		ELSE IF NOT EXISTS (SELECT * FROM mant.tbVisitantes WHERE visi_RTN = @visi_RTN)
		BEGIN

		
			
			
			INSERT INTO mant.tbVisitantes(visi_Nombres, visi_Apellido, visi_RTN, visi_Sexo, visi_UserCreacion)
			VALUES (@visi_Nombres, @visi_Apellido, @visi_RTN, @visi_Sexo, @visi_UserCreacion)

			BEGIN TRAN -- Agregado BEGIN TRAN
				DECLARE @visi_Id INT
		    SET @visi_Id = SCOPE_IDENTITY()
			SELECT @visi_Id AS visi_Id, 200 AS visi_UserCreacion, 'Todo Perfecto' AS visi_Apellido

			COMMIT -- Agregado COMMIT
		
		END
		
COMMIT
END TRY

BEGIN CATCH
ROLLBACK
END CATCH
END
GO



GO

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
			IF EXISTS (SELECT * FROM mant.tbVisitantes WHERE visi_RTN = @visi_RTN AND visi_Id <> @visi_Id )
			BEGIN
				SELECT 409 AS codeStatus, 'El visitante ya existe.' AS messageStatus
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


CREATE OR ALTER PROCEDURE fact.UDP_FacturasPorVisitante 
    @visi_Id INT
AS
BEGIN
    SELECT T1.fact_Id,
           T4.meto_Descripcion,
           MAX(CASE WHEN T5.tick_Descripcion = 'Ticket de entrada al zoológico' THEN T5.tick_Descripcion + ' (' + CONVERT(VARCHAR(10), T3.fade_Cantidad) + ' x ' + CONVERT(VARCHAR(10), T3.fade_Total) + ')' END) AS Ticket_Zoologico,
           MAX(CASE WHEN T5.tick_Descripcion = 'Ticket de entrada al jardín botánico' THEN T5.tick_Descripcion + ' (' + CONVERT(VARCHAR(10), T3.fade_Cantidad) + ' x ' + CONVERT(VARCHAR(10), T3.fade_Total) + ')' END) AS Ticket_JardinBotanico,
           SUM(T3.fade_Cantidad * T3.fade_Total) AS fade_Total,
		   t1.fact_Fecha
    FROM fact.tbFacturas T1
    INNER JOIN mant.tbVisitantes T2 ON T1.visi_Id = T2.visi_Id
    INNER JOIN fact.tbFacturasDetalles T3 ON T1.fact_Id = T3.fact_Id
    INNER JOIN fact.tbMetodosPago T4 ON T1.meto_Id = T4.meto_Id
    INNER JOIN fact.tbTickets T5 ON T3.tick_Id = T5.tick_Id
    WHERE T1.visi_Id = @visi_Id
    GROUP BY T1.fact_Id, T4.meto_Descripcion,t1.fact_Fecha
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
			IF EXISTS (SELECT * FROM mant.tbTiposMantenimientos WHERE tima_Descripcion= @tima_Descripcion AND tima_Id <> @tima_Id AND tima_Estado= 1)
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

				SELECT 200 AS codeStatus,  'El tipo de mantenimiento ha sido actualizado con éxito.' AS messageStatus
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
			DECLARE @mantes INT = (SELECT COUNT(*) FROM mant.tbMantenimientoAnimal WHERE tima_Id = @tima_Id)

			
			IF @tiposmants > 0 or @mantes > 0
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

IF EXISTS (SELECT * FROM mant.tbMantenimientos WHERE mant_Observaciones = @mant_Observaciones AND mant_Id <> @mant_Id AND mant_Estado = 1)
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
			--DECLARE @mantes INT = (SELECT COUNT(*) FROM mant.tbMantenimientoAnimal WHERE mant_Id = @mant_Id)
			
			IF 0 > 1
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

	SELECT TOP (1000) *
	FROM [db_Lancetilla].[mant].[VW_MantenimientoAnimales]
	where maan_Estado = 1
 	
	--SELECT TOP (1000) [anim_Id], [anim_Nombre]
	--FROM [db_Lancetilla].[mant].[VW_MantenimientoAnimales]
	--where maan_Estado = 1
	--GROUP BY [anim_Id], [anim_Nombre]

END


GO 
CREATE OR ALTER PROC mant.UDP_tbMantenimientosAnimal_SELECTMOMENT 
@maan_UserCreacion INT 
AS
BEGIN
	
	    DECLARE @FechaActual DATE = CONVERT(DATE, GETDATE())


	 SELECT *
    FROM mant.VW_MantenimientoAnimales
    WHERE maan_Estado = 1
        AND CONVERT(DATE, maan_FechaCreacion) = @FechaActual 
		and maan_UserCreacion = @maan_UserCreacion

END


GO 
CREATE OR ALTER PROC mant.UDP_tbMantenimientosAnimal_FIND 
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
	 SELECT *,@ExisteHoy as hoy
    FROM mant.VW_MantenimientoAnimales
    WHERE maan_Estado = 1
        AND anim_Id = @anim_Id
        AND CONVERT(DATE, maan_FechaCreacion) = @FechaActual
  	END
   
   IF @ExisteHoy = 0 
	BEGIN
	 SELECT * ,@ExisteHoy as hoy
    FROM mant.VW_MantenimientoAnimales
    WHERE maan_Estado = 1
        AND anim_Id = @anim_Id
 	END

	--SELECT 200 AS codeStatus, @ExisteHoy AS messageStatus


			
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
@tima_Id INT,
@maan_Fecha DATE,
@maan_UserCreacion INT
AS BEGIN

BEGIN TRY

			INSERT INTO mant.tbMantenimientoAnimal(anim_Id, tima_Id, maan_Fecha,maan_UserCreacion)
			VALUES  (@anim_Id, @tima_Id,@maan_Fecha, @maan_UserCreacion)

			SELECT 200 AS codeStatus, SCOPE_IDENTITY() AS messageStatus
END TRY

BEGIN CATCH
 END CATCH

END
GO


CREATE OR ALTER PROC mant.UDP_tbMantenimientosAnimal_UPDATE
@maan_Id INT,
@anim_Id INT,
@tima_Id INT,
@maan_Fecha DATE,
@maan_UserModificacion INT
AS BEGIN
BEGIN TRY


BEGIN TRAN
UPDATE mant.tbMantenimientoAnimal

SET anim_Id = @anim_Id,
tima_Id = @tima_Id,
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
		IF EXISTS (SELECT * FROM zool.tbAreasZoologico WHERE arzo_Descripcion= @arzo_Descripcion AND arzo_Id <> @arzo_Id  AND arzo_Estado = 1)
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
		IF EXISTS (SELECT * FROM zool.tbHabitat WHERE habi_Descripcion = @habi_Descripcion AND habi_Id <> @habi_Id AND habi_Estado= 1)
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
			DECLARE @habis INT = (SELECT COUNT(*) FROM zool.tbRazas WHERE habi_Id = @habi_Id)
			
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
		IF EXISTS (SELECT * FROM zool.tbEspecies WHERE espe_Descripcion = @espe_Descripcion AND espe_Id <> @espe_Id AND espe_Estado= 1)
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
			DECLARE @especies INT = (SELECT COUNT(*) FROM zool.tbRazas WHERE espe_Id = @espe_Id)
			
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

--*****************************************************************TABLA DE RAZAS*****************************************************************************--
CREATE OR ALTER PROC zool.UDP_tbRazas_CREATE
@raza_Descripcion NVARCHAR(100),
@raza_NombreCientifico NVARCHAR(100),
@rein_Id INT,
@habi_Id INT,
@espe_Id INT,
@raza_UserCreacion INT
AS BEGIN

BEGIN TRY

	BEGIN TRAN

		-- Si existe
		IF EXISTS (SELECT * FROM zool.tbRazas WHERE raza_Descripcion = @raza_Descripcion AND raza_Estado = 1)
		BEGIN
			SELECT 409 AS codeStatus, 'La raza ya existe.' AS messageStatus
		END

		ELSE IF EXISTS (SELECT * FROM zool.tbRazas WHERE raza_NombreCientifico  = @raza_NombreCientifico  AND raza_Estado = 1)
		BEGIN
			SELECT 409 AS codeStatus, 'El nombre científico de la raza ya existe.' AS messageStatus
		END

		ELSE IF EXISTS (SELECT * FROM zool.tbRazas WHERE raza_NombreCientifico  = @raza_NombreCientifico OR  raza_Descripcion = @raza_Descripcion AND raza_Estado = 1)
		BEGIN
			SELECT 409 AS codeStatus, 'La raza y el nombre científico ya existe.' AS messageStatus
		END


		ELSE IF EXISTS (SELECT * FROM zool.tbRazas WHERE  raza_NombreCientifico  = @raza_NombreCientifico OR  raza_Descripcion = @raza_Descripcion AND raza_Estado= 0)
		BEGIN
			DECLARE @Id INT = (SELECT raza_Id FROM zool.tbRazas WHERE raza_NombreCientifico  = @raza_NombreCientifico OR  raza_Descripcion = @raza_Descripcion) 

			BEGIN TRAN -- Agregado BEGIN TRAN

			UPDATE zool.tbRazas
			SET
				  raza_Descripcion =  @raza_Descripcion,
				  raza_NombreCientifico = @raza_NombreCientifico,
				  rein_Id = @rein_Id,
				  habi_Id = @habi_Id,
				  espe_Id = @espe_Id,
				  raza_UserCreacion = @raza_UserCreacion,
				  raza_UserModificacion = NULL,
				  raza_Estado = 1
			WHERE raza_Id = @Id

		    SELECT 200 AS codeStatus, 'La raza ha sido creada con éxito.' AS messageStatus

			COMMIT -- Agregado COMMIT
		END


		ELSE IF NOT EXISTS (SELECT * FROM zool.tbRazas WHERE raza_NombreCientifico  = @raza_NombreCientifico OR  raza_Descripcion = @raza_Descripcion AND raza_Estado= 1)
		BEGIN
			INSERT INTO zool.tbRazas(raza_Descripcion, raza_NombreCientifico, habi_Id, rein_Id, espe_Id)
			VALUES (@raza_Descripcion, @raza_NombreCientifico, @habi_Id, @rein_Id, @espe_Id)

			BEGIN TRAN -- Agregado BEGIN TRAN

			SELECT 200 AS codeStatus, 'La raza ha sido creada con éxito.' AS messageStatus

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


CREATE OR ALTER PROC zool.UDP_tbRazas_UPDATE 
@raza_Id INT,
@raza_Descripcion NVARCHAR(100),
@raza_NombreCientifico NVARCHAR(100),
@rein_Id INT,
@habi_Id INT,
@espe_Id INT,
@raza_UserModificacion INT
AS BEGIN

  	BEGIN TRY
		BEGIN TRAN
		-- Si existe
		IF EXISTS (SELECT * FROM zool.tbRazas WHERE raza_Estado = 1 AND  raza_Descripcion = @raza_Descripcion AND raza_Id <> @raza_Id AND raza_Id != @raza_Id)
		BEGIN
			SELECT 409 AS codeStatus, 'La raza ya existe.' AS messageStatus
		END

		ELSE IF EXISTS (SELECT * FROM zool.tbRazas WHERE  raza_Estado = 1 AND raza_NombreCientifico  = @raza_NombreCientifico  AND raza_Id != @raza_Id)
		BEGIN
			SELECT 409 AS codeStatus, 'El nombre científico de la raza ya existe.' AS messageStatus
		END

		ELSE IF EXISTS (SELECT * FROM zool.tbRazas WHERE raza_NombreCientifico  = @raza_NombreCientifico  AND  raza_Descripcion = @raza_Descripcion AND raza_Estado = 1 AND raza_Id != @raza_Id )
		BEGIN
			SELECT 409 AS codeStatus, 'La raza y el nombre científico ya existe.' AS messageStatus
		END
		ELSE IF EXISTS (SELECT * FROM zool.tbRazas WHERE  raza_NombreCientifico  = @raza_NombreCientifico OR  raza_Descripcion = @raza_Descripcion AND raza_Estado = 0)
		BEGIN
			DECLARE @Id INT = (SELECT raza_Id FROM zool.tbRazas WHERE raza_NombreCientifico  = @raza_NombreCientifico OR  raza_Descripcion = @raza_Descripcion) 

			BEGIN TRAN -- Agregado BEGIN TRAN

			UPDATE zool.tbRazas
			SET
				  raza_Descripcion =  @raza_Descripcion,
				  raza_NombreCientifico = @raza_NombreCientifico,
				  rein_Id = @rein_Id,
				  habi_Id = @habi_Id,
				  espe_Id = @espe_Id,
				  raza_UserCreacion = @raza_UserModificacion,
				  raza_UserModificacion = NULL,
				  raza_Estado = 1
			WHERE raza_Id = @Id

		    SELECT 200 AS codeStatus, 'La raza ha sido creada con éxito.' AS messageStatus

			COMMIT -- Agregado COMMIT
		END

			ELSE --Especie no existe, se realiza la actualización
			BEGIN
				UPDATE zool.tbRazas
				SET
					  raza_Descripcion =  @raza_Descripcion,
					  raza_NombreCientifico = @raza_NombreCientifico,
					  rein_Id = @rein_Id,
					  habi_Id = @habi_Id,
					  espe_Id = @espe_Id,
					  raza_FechaModificacion = GETDATE(),
					  raza_UserModificacion = @raza_UserModificacion
				WHERE raza_Id = @raza_Id

				SELECT 200 AS codeStatus, 'La raza ha sido actualizado con éxito.' AS messageStatus
			END

			COMMIT
		END TRY
		BEGIN CATCH
			ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE() AS messageStatus
		END CATCH

END
GO


CREATE OR ALTER PROC zool.UDP_tbRazas_DELETE
@raza_Id INT
AS BEGIN

  	BEGIN TRY
	BEGIN TRAN
			DECLARE @razas INT = (SELECT COUNT(*) FROM zool.tbAnimales WHERE raza_Id = @raza_Id)
			
			IF @razas > 0
			BEGIN
			SELECT 202 AS codeStatus, 'La raza que desea eliminar está en uso.' AS messageStatus
			END
			ELSE
			BEGIN
			UPDATE zool.tbRazas
			SET
				raza_Estado	=	0
				WHERE raza_Id	=	@raza_Id

			SELECT 200 AS codeStatus, 'La raza ha sido eliminado con éxito.' AS messageStatus
			END
	COMMIT
	END TRY
	BEGIN CATCH
	ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH


END
GO


--****************************************************************/TABLA DE RAZAS*****************************************************************************--

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
		IF EXISTS (SELECT * FROM zool.tbAlimentacion WHERE alim_Descripcion = @alim_Descripcion AND alim_Id <> @alim_Id AND alim_Estado= 1)
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
			SELECT 202 AS codeStatus, 'La alimentación que desea eliminar está en uso.' AS messageStatus
			END
			ELSE
			BEGIN
			UPDATE zool.tbAlimentacion
			SET
				alim_Estado	=	0
				WHERE alim_Id	=	@alim_Id

			SELECT 200 AS codeStatus, 'La alimentación ha sido eliminada con éxito.' AS messageStatus
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
CREATE OR ALTER PROC zool.UDP_tbAnimales_RAZAS 
@raza_Id INT
AS BEGIN

SELECT * FROM zool.VW_tbAnimales
WHERE raza_Id = @raza_Id
AND anim_Estado = 1;

END
GO

CREATE OR ALTER PROC zool.UDP_tbAnimales_CREATE
@anim_Codigo NVARCHAR(100),
@anim_Nombre NVARCHAR(100),
@raza_Id INT,
@arzo_Id INT,
@alim_Id INT,
@anim_UserCreacion INT
AS BEGIN

BEGIN TRY

	BEGIN TRAN

		-- Si existe
		IF EXISTS (SELECT * FROM zool.tbAnimales WHERE anim_Codigo = @anim_Codigo AND anim_Estado = 1)
		BEGIN
			SELECT 409 AS codeStatus, 'El código del animal ya existe.' AS messageStatus
		END
		ELSE IF EXISTS (SELECT * FROM zool.tbAnimales WHERE anim_Codigo = @anim_Codigo AND anim_Estado= 0)
		BEGIN
			DECLARE @Id INT = (SELECT anim_Id FROM zool.tbAnimales WHERE anim_Codigo = @anim_Codigo ) 

			BEGIN TRAN -- Agregado BEGIN TRAN

			UPDATE zool.tbAnimales
			SET
				  anim_Codigo = @anim_Codigo,
				  anim_Nombre = @anim_Nombre,
				  arzo_Id = @arzo_Id,
				  alim_Id = @alim_Id,
				  anim_UserModificacion = NULL,
				  anim_Estado = 1
			WHERE anim_Id = @Id

		    SELECT 200 AS codeStatus, 'El animal ha sido creada con éxito.' AS messageStatus

			COMMIT -- Agregado COMMIT
		END


		ELSE IF NOT EXISTS (SELECT * FROM zool.tbAnimales WHERE anim_Codigo = @anim_Codigo AND anim_Estado= 1)
		BEGIN
			INSERT INTO zool.tbAnimales(anim_Codigo, anim_Nombre, raza_Id, arzo_Id, alim_Id, anim_UserCreacion)
			VALUES (@anim_Codigo, @anim_Nombre,@raza_Id, @arzo_Id, @alim_Id, @anim_UserCreacion)

			BEGIN TRAN -- Agregado BEGIN TRAN

			SELECT 200 AS codeStatus, 'El animal ha sido creado con éxito.' AS messageStatus

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
@anim_Codigo NVARCHAR(100),
@anim_Nombre NVARCHAR(100),
@raza_Id INT,
@arzo_Id INT,
@alim_Id INT,
@anim_UserModificacion INT
AS BEGIN

  	BEGIN TRY
		BEGIN TRAN
		IF EXISTS (SELECT * FROM zool.tbAnimales WHERE anim_Codigo = @anim_Codigo AND anim_Estado = 1 AND anim_Codigo != @anim_Codigo)
		BEGIN
			SELECT 409 AS codeStatus, 'El código del animal ya existe.' AS messageStatus
		END
		ELSE IF EXISTS (SELECT * FROM zool.tbAnimales WHERE anim_Codigo  = @anim_Codigo  AND anim_Estado= 0 )
		BEGIN
			DECLARE @Id INT = (SELECT anim_Id FROM zool.tbAnimales WHERE anim_Codigo  = @anim_Codigo  ) 

				UPDATE zool.tbAnimales
				SET
				  anim_Codigo = @anim_Codigo,
				  anim_Nombre = @anim_Nombre,
				  raza_Id = @raza_Id,
				  arzo_Id = @arzo_Id,
				  alim_Id = @alim_Id,
				  anim_UserModificacion = @anim_UserModificacion,
				  anim_Estado = 1
				WHERE   anim_Id = @Id

				SELECT 200 AS codeStatus, 'El animal ha sido actualizado con éxito.' AS messageStatus
			END

			ELSE --Especie no existe, se realiza la actualización
			BEGIN
				UPDATE zool.tbAnimales
				SET
				  anim_Codigo = @anim_Codigo,
				  anim_Nombre = @anim_Nombre,
				  raza_Id = @raza_Id,
				  arzo_Id = @arzo_Id,
				  alim_Id = @alim_Id,
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
				WHERE anim_Id	=	@anim_Id

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
		IF EXISTS (SELECT * FROM bota.tbAreasBotanicas WHERE arbo_Descripcion = @arbo_Descripcion AND arbo_Id <> @arbo_Id AND arbo_Estado = 1)
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
/*
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

			UPDATE bota.tbCuidados
			SET
				cuid_Estado	=	0
				WHERE cuid_Id	=	@cuid_Id

			SELECT 200 AS codeStatus, 'El cuidado ha sido eliminado con éxito.' AS messageStatus
			
	COMMIT
	END TRY
	BEGIN CATCH
	ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH


END
GO

*/
--****************************************************************/TABLA DE CUIDADOS***************************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*************************************************************TABLA DE TIPOS DE PLANTAS************************************************************************--
GO
CREATE OR ALTER PROC bota.UDP_tbTiposPlantas_Find
@tipl_Id INT
AS BEGIN

SELECT * FROM bota.VW_tbPlantas
WHERE tipl_Id = @tipl_Id
AND plan_Estado = 1;

END
GO

CREATE OR ALTER PROC bota.UDP_tbTiposPlantas_CREATE  
@tipl_NombreComun NVARCHAR(100),
@tipl_NombreCientifico NVARCHAR(100),
@rein_Id INT,
@tipl_UserCreacion INT
AS BEGIN

BEGIN TRY

	BEGIN TRAN
		IF EXISTS (SELECT * FROM bota.tbTiposPlantas WHERE RTRIM(tipl_NombreComun) = RTRIM(@tipl_NombreComun)  AND tipl_Estado = 1)
		BEGIN
			SELECT 409 AS codeStatus, 'El nombre común de la planta ya existe.' AS messageStatus
		END
		ELSE IF EXISTS (SELECT * FROM bota.tbTiposPlantas WHERE RTRIM(tipl_NombreCientifico) = RTRIM(@tipl_NombreCientifico)  AND tipl_Estado = 1)
		BEGIN
			SELECT 409 AS codeStatus, 'El nombre científico de la planta ya existe.' AS messageStatus
		END

		ELSE IF EXISTS (SELECT * FROM bota.tbTiposPlantas WHERE tipl_NombreComun = @tipl_NombreComun OR tipl_NombreCientifico = @tipl_NombreCientifico  AND tipl_Estado = 1)
		BEGIN
			SELECT 409 AS codeStatus, 'El nombre común y el nombre científico de la planta ya existe.' AS messageStatus
		END

		IF EXISTS (SELECT * FROM bota.tbTiposPlantas WHERE  RTRIM(tipl_NombreComun) = RTRIM(@tipl_NombreComun) OR RTRIM(tipl_NombreCientifico) = RTRIM(@tipl_NombreCientifico)  AND tipl_Estado = 0 )
		BEGIN
			DECLARE @Id INT = (SELECT tipl_Id FROM bota.tbTiposPlantas WHERE  RTRIM(tipl_NombreComun) = RTRIM(@tipl_NombreComun) OR RTRIM(tipl_NombreCientifico) = RTRIM(@tipl_NombreCientifico)) 

			BEGIN TRAN -- Agregado BEGIN TRAN

			UPDATE bota.tbTiposPlantas
			SET
				  tipl_NombreComun = @tipl_NombreComun,
				  tipl_NombreCientifico = @tipl_NombreCientifico,
				  rein_Id = @rein_Id,
				  tipl_UserCreacion = @tipl_UserCreacion,
				  tipl_UserModificacion = NULL,
				  tipl_Estado = 1
			WHERE tipl_Id = @Id

		    SELECT 200 AS codeStatus, 'El tipo de planta ha sido creada con éxito.' AS messageStatus

			COMMIT -- Agregado COMMIT
		END


		ELSE IF NOT EXISTS (SELECT * FROM bota.tbTiposPlantas WHERE RTRIM(tipl_NombreComun) = RTRIM(@tipl_NombreComun) OR RTRIM(tipl_NombreCientifico) = RTRIM(@tipl_NombreCientifico) AND tipl_Estado= 1)
		BEGIN
			INSERT INTO bota.tbTiposPlantas(tipl_NombreComun, tipl_NombreCientifico, rein_Id, tipl_UserCreacion)
			VALUES (@tipl_NombreComun, @tipl_NombreCientifico, @rein_Id, @tipl_UserCreacion)

			BEGIN TRAN -- Agregado BEGIN TRAN

			SELECT 200 AS codeStatus, 'El tipo de planta ha sido creada con éxito.' AS messageStatus

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



CREATE OR ALTER PROC bota.UDP_tbTiposPlantas_UPDATE 
@tipl_Id INT,
@tipl_NombreComun NVARCHAR(100),
@tipl_NombreCientifico NVARCHAR(100),
@rein_Id INT,
@tipl_UserModificacion INT
AS BEGIN

  	BEGIN TRY
		BEGIN TRAN
		IF EXISTS (SELECT * FROM bota.tbTiposPlantas WHERE RTRIM(tipl_NombreComun) = RTRIM(@tipl_NombreComun)  AND tipl_Estado = 1 AND tipl_Id != @tipl_Id)
		BEGIN
			SELECT 409 AS codeStatus, 'El nombre común de la planta ya existe.' AS messageStatus
		END
		ELSE IF EXISTS (SELECT * FROM bota.tbTiposPlantas WHERE RTRIM(tipl_NombreCientifico) = RTRIM(@tipl_NombreCientifico)  AND tipl_Estado = 1 AND tipl_Id != @tipl_Id)
		BEGIN
			SELECT 409 AS codeStatus, 'El nombre científico de la planta ya existe.' AS messageStatus
		END

		ELSE IF EXISTS (SELECT * FROM bota.tbTiposPlantas WHERE RTRIM(tipl_NombreComun) = RTRIM(@tipl_NombreComun) AND RTRIM(tipl_NombreCientifico) = RTRIM(@tipl_NombreCientifico)  AND tipl_Estado = 1 AND tipl_Id != @tipl_Id)
		BEGIN
			SELECT 409 AS codeStatus, 'El nombre y el nombre científico de la planta ya existe.' AS messageStatus
		END

		IF EXISTS (SELECT * FROM bota.tbTiposPlantas WHERE  RTRIM(tipl_NombreComun) = RTRIM(@tipl_NombreComun) OR RTRIM(tipl_NombreCientifico) = RTRIM(@tipl_NombreCientifico)  AND tipl_Estado = 0 )
		BEGIN
			DECLARE @Id INT = (SELECT tipl_Id FROM bota.tbTiposPlantas WHERE  RTRIM(tipl_NombreComun) = RTRIM(@tipl_NombreComun) OR RTRIM(tipl_NombreCientifico) = RTRIM(@tipl_NombreCientifico)) 
				UPDATE bota.tbTiposPlantas
				SET
						tipl_NombreComun = @tipl_NombreComun,
						tipl_NombreCientifico = @tipl_NombreCientifico,
						rein_Id = @rein_Id,
						tipl_UserModificacion = @tipl_UserModificacion,
						tipl_Estado = 1
				WHERE   tipl_Id = @Id

				SELECT 200 AS codeStatus, 'La planta ha sido actualizada con éxito.' AS messageStatus
			END

			ELSE --Planta no existe, se realiza la actualización
			BEGIN
				UPDATE bota.tbTiposPlantas
				SET
						tipl_NombreComun = @tipl_NombreComun,
						tipl_NombreCientifico = @tipl_NombreCientifico,
						rein_Id = @rein_Id,
						tipl_FechaModificacion = GETDATE(),
						tipl_UserModificacion = @tipl_UserModificacion
				WHERE	tipl_Id = @tipl_Id

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

CREATE OR ALTER PROC bota.UDP_tbTiposPlantas_DELETE
@tipl_Id INT
AS BEGIN

  	BEGIN TRY
	BEGIN TRAN
	
			UPDATE bota.tbTiposPlantas
			SET
				tipl_Estado	=	0
				WHERE tipl_Id	=	@tipl_Id

			SELECT 200 AS codeStatus, 'El tipo de plantas ha sido eliminada con éxito.' AS messageStatus
			
	COMMIT
	END TRY
	BEGIN CATCH
	ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH


END
GO

--************************************************************/TABLA DE TIPOS DE PLANTAS***********************************************************************--

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--*****************************************************************TABLA DE PLANTAS****************************************************************************--
GO

CREATE OR ALTER PROC bota.UDP_tbPlantas_CREATE 
@plan_Codigo NVARCHAR(100),
@arbo_Id INT,
@tipl_Id INT,
@plan_UserCreacion INT
AS BEGIN

BEGIN TRY

	BEGIN TRAN
				IF EXISTS (SELECT * FROM bota.tbPlantas WHERE RTRIM(plan_Codigo) = RTRIM(@plan_Codigo)  AND plan_Estado = 1)
		BEGIN
			SELECT 409 AS codeStatus, 'El código de la planta ya existe.' AS messageStatus
		END
		IF EXISTS (SELECT * FROM bota.tbPlantas WHERE RTRIM(plan_Codigo) = RTRIM(@plan_Codigo)  AND plan_Estado = 0 )
		BEGIN
			DECLARE @Id INT = (SELECT plan_Id FROM bota.tbPlantas WHERE plan_Codigo = @plan_Codigo) 

			BEGIN TRAN -- Agregado BEGIN TRAN

			UPDATE bota.tbPlantas
			SET
				  plan_Codigo = @plan_Codigo,
				  tipl_Id = @tipl_Id,
				  arbo_Id = @arbo_Id,
				  plan_UserCreacion = @plan_UserCreacion,
				  plan_UserModificacion = NULL,
				  plan_Estado = 1
			WHERE plan_Id = @Id

		    SELECT 200 AS codeStatus, 'La planta ha sido creada con éxito.' AS messageStatus

			COMMIT -- Agregado COMMIT
		END


		ELSE IF NOT EXISTS (SELECT * FROM bota.tbPlantas WHERE  RTRIM(plan_Codigo) = RTRIM(@plan_Codigo) AND plan_Estado= 1)
		BEGIN
			INSERT INTO bota.tbPlantas(plan_Codigo, tipl_Id, arbo_Id, plan_UserCreacion)
			VALUES (@plan_Codigo, @tipl_Id, @arbo_Id, @plan_UserCreacion)

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
@plan_Codigo NVARCHAR(100),
@arbo_Id INT,
@tipl_Id INT,
@plan_UserModificacion INT
AS BEGIN

  	BEGIN TRY
		BEGIN TRAN
		IF EXISTS (SELECT * FROM bota.tbPlantas WHERE RTRIM(plan_Codigo) = RTRIM(@plan_Codigo) AND plan_Id <> @plan_Id  AND plan_Estado = 1 AND RTRIM(plan_Codigo) != RTRIM(@plan_Codigo))
BEGIN
    SELECT 409 AS codeStatus, 'El código de la planta ya existe.' AS messageStatus
END



		 IF EXISTS (SELECT * FROM bota.tbPlantas WHERE RTRIM(plan_Codigo) = RTRIM(@plan_Codigo) AND RTRIM(plan_Codigo) != RTRIM(@plan_Codigo) AND plan_Estado = 0 )
		BEGIN
			DECLARE @Id INT = (SELECT plan_Id FROM bota.tbPlantas WHERE RTRIM(plan_Codigo) = RTRIM(@plan_Codigo)) 

				UPDATE bota.tbPlantas
				SET
						plan_Codigo = @plan_Codigo,
						tipl_Id = @tipl_Id,
						arbo_Id = @arbo_Id,
						plan_UserModificacion = @plan_UserModificacion,
						plan_Estado = 1
				WHERE   plan_Id = @Id

				SELECT 200 AS codeStatus, 'La planta ha sido actualizada con éxito.' AS messageStatus
			END

			ELSE --Planta no existe, se realiza la actualización
			BEGIN
				UPDATE bota.tbPlantas
				SET
						plan_Codigo = @plan_Codigo,
						tipl_Id = @tipl_Id,
						arbo_Id = @arbo_Id,
					  plan_FechaModificacion = GETDATE(),
					  plan_UserModificacion = @plan_UserModificacion
				WHERE plan_Id = @plan_Id

				SELECT 200 AS codeStatus, 'La planta ha sido actualizada con éxito.' AS messageStatus
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
CREATE OR ALTER PROC fact.UDP_tbTickets_EditarPrecio
@tick_Precio DECIMAL(8,2),
@tick_Id  INT

AS BEGIN

BEGIN TRY

	BEGIN TRAN
	
		    UPDATE fact.tbTickets
			SET tick_Precio = @tick_Precio					
			WHERE tick_Id = @tick_Id

			  SELECT 200 AS codeStatus, 'El ticket ha sido creado con éxito.' AS messageStatus

	

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
		IF EXISTS (SELECT * FROM fact.tbMetodosPago WHERE meto_Id <> @meto_Id AND meto_Descripcion = @meto_Descripcion AND meto_Estado= 1)
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

CREATE OR ALTER PROCEDURE fact.UDP_InsertarFactura 
(
    @empl_Id INT,
    @visi_Id INT,
    @fact_UserCreacion INT

)
AS
BEGIN
    BEGIN TRY
	BEGIN TRAN

    -- Insertar la factura
    INSERT INTO fact.tbFacturas (empl_Id , visi_Id, fact_Fecha, meto_Id, fact_UserCreacion)
    VALUES (@empl_Id, @visi_Id,  GETDATE(), 1, @fact_UserCreacion);

    -- Obtener el ID de la factura recién insertada
    DECLARE @fact_Id INT;
    SET @fact_Id = SCOPE_IDENTITY();

	SELECT @fact_Id AS fact_Id

	COMMIT
	END TRY
	BEGIN CATCH
	ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH

END

GO
CREATE OR ALTER PROCEDURE fact.UDP_InsertarFacturaMetodoDePago 
(
      @fact_Id INT,
	  @meto_Id INT
)
AS
BEGIN
    BEGIN TRY
	BEGIN TRAN

   UPDATE fact.tbFacturas
   SET    meto_Id = @meto_Id
   WHERE  fact_Id = @fact_Id
    
	SELECT 200 AS codeStatus, 'Todo correcto' AS messageStatus

	COMMIT
	END TRY
	BEGIN CATCH
	ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH

END


GO
CREATE OR ALTER PROCEDURE fact.UDP_InsertarFacturaDetalle
    @fact_Id INT,
    @tick_Id INT,
    @fade_Cantidad INT,
    @fade_UserCreacion INT
 
AS
BEGIN
  
    BEGIN TRY
	BEGIN TRAN
    	
	DECLARE @Precio DECIMAL(8,2) = (SELECT T1.tick_Precio FROM fact.tbTickets T1 WHERE tick_Id = @tick_Id)
	DECLARE @TOTAL DECIMAL(8,2) = (@Precio * @fade_Cantidad)

	INSERT INTO fact.tbFacturasDetalles (fact_Id, tick_Id, fade_Cantidad, fade_Total, fade_UserCreacion)
    VALUES (@fact_Id, @tick_Id, @fade_Cantidad, @TOTAL, @fade_UserCreacion);
    
    SELECT 200 AS codeStatus, 'Todo correcto' AS messageStatus
    
   COMMIT
	END TRY
	BEGIN CATCH
	ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH
END

GO


CREATE OR ALTER PROCEDURE fact.UPD_CargarInformacionDelEncabezado_Factura 
@visi_Id  INT
AS
BEGIN

SELECT  T1.fact_Id,
        T1.fact_Fecha,

       T2.visi_Nombres + ' ' + T2.visi_Apellido AS visi_Nombres,
       T2.visi_RTN,
	   T2.visi_Sexo,

	   T3.empl_Nombre + ' ' + T3.empl_Apellido AS empl_Nombre,

	   T4.meto_Descripcion
	   

FROM fact.tbFacturas T1     INNER JOIN mant.tbVisitantes T2
ON T1.visi_Id = T2.visi_Id  INNER JOIN mant.tbEmpleados T3
ON T1.empl_Id = T3.empl_Id  INNER JOIN fact.tbMetodosPago T4
ON T1.meto_Id = T4.meto_Id

WHERE T2.visi_Id = @visi_Id  

END



GO

CREATE OR ALTER PROCEDURE fact.UPD_CargarInformacionTabla_Factura  
@fact_Id  INT
AS
BEGIN

SELECT  T2.tick_Descripcion,
        T2.tick_Precio,
		T1.fade_Cantidad,
		T1.fade_Total
		
        	  
FROM fact.tbFacturasDetalles T1   INNER JOIN fact.tbTickets T2
ON T1.tick_Id = T2.tick_Id
WHERE T1.fact_Id = @fact_Id  

END

go

CREATE OR ALTER PROC fact.UDP_tbFacturasDetalle_DETALLESPORFACTS
@fact_Id INT
AS BEGIN

SELECT * FROM fact.VW_FacturasDetalle
WHERE fact_Id = @fact_Id

END
--**********************************************************/TABLA DE FACTURAS DETALLE************************************************************************--

--**************************************************************/PROCS DE FACTURACIÓN************************************************************************--

--************************************************************************************************************************************************************--











 





















            
            
            
            
            
            
            
            
            
         
            
            
            
            
            
            
           
            
          
            
            
            
            
         
            
            
            
          
            
            