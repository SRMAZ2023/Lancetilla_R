 GO 
CREATE OR ALTER PROC bota.tbTiposCuidados_SELECT
AS
BEGIN

	SELECT TOP (1000) *
	FROM [bota].[VW_tbTiposCuidados]
	where ticu_Estado = 1  
 	
END

GO
CREATE OR ALTER PROC bota.tbTiposCuidados_FIND 
@ticu_Id int
AS
BEGIN

	SELECT TOP (1000) *
	FROM [bota].[VW_tbTiposCuidados]
	where ticu_Estado = 1  
	AND	ticu_Id = @ticu_Id
 	
END

GO
CREATE OR ALTER PROC bota.tbTiposCuidados_CREATE
@ticu_Descripcion nvarchar(100),
@ticu_UserCreacion int 
AS BEGIN

BEGIN TRY
	
	DECLARE @Existe INT =  (SELECT TOP (1000) COUNT(*)
	FROM [bota].[VW_tbTiposCuidados]
	where  ticu_Estado = 1   and  [ticu_Descripcion] = @ticu_Descripcion)

	if @Existe > 0 
	begin
 					
		SELECT 409 AS codeStatus, 'El tipo de cuidado ya existe.' AS messageStatus

	 end else begin

	 INSERT INTO [bota].[tbTiposCuidados]
           ([ticu_Descripcion]
           ,[ticu_UserCreacion])
     VALUES
           (@ticu_Descripcion
           ,@ticu_UserCreacion)

		   SELECT 200 AS codeStatus, 'El tipo cuidado por planta ha sido creado con existe.' AS messageStatus

	end



END TRY

BEGIN CATCH
			SELECT 500 AS codeStatus, ERROR_MESSAGE () AS messageStatus
 END CATCH

END
GO


CREATE OR ALTER PROC bota.tbTiposCuidados_UPDATE
@ticu_Id int,
@ticu_Descripcion nvarchar(100),
@ticu_UserModificacion int 
AS BEGIN
BEGIN TRY


BEGIN TRAN

	DECLARE @Existe INT =  (SELECT TOP (1000) COUNT(*)
	FROM [bota].[VW_tbTiposCuidados]
	where  ticu_Estado = 1   and  [ticu_Descripcion] = @ticu_Descripcion and ticu_Id != @ticu_Id)

	if @Existe > 0 BEGIN  

			SELECT 409 AS codeStatus, 'El tipo de cuidado ya existe.' AS messageStatus

	END ELSE BEGIN
			
			UPDATE	[bota].[tbTiposCuidados]
			SET		[ticu_Descripcion] = @ticu_Descripcion
					,[ticu_UserModificacion] = @ticu_UserModificacion
					,[ticu_FechaModificacion] = GETDATE()
			WHERE	 ticu_Id = @ticu_Id

		   SELECT 200 AS codeStatus, 'El tipo cuidado por planta ha sido editado con exito.' AS messageStatus


	END

 COMMIT	
END TRY

BEGIN CATCH
ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus

END CATCH
END
GO


GO
CREATE OR ALTER PROC bota.tbTiposCuidados_DELETE
@ticu_Id INT
 AS BEGIN

 BEGIN TRY 
 BEGIN TRAN

 
  

	UPDATE  [bota].[tbTiposCuidados]
	   SET  [ticu_Estado] = 0
	  WHERE ticu_Id = @ticu_Id
 
		SELECT 200 AS codeStatus, 'El tipo cuidado ha sido eliminado con exito.' AS messageStatus

 COMMIT
 END TRY

 BEGIN CATCH
 ROLLBACK
 			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus

 END CATCH
 END
 GO

 --------------------------------------------------------------------

 CREATE OR ALTER PROC bota.UDP_tbCuidados_CREATE  
@cuid_Observacion NVARCHAR(200),
@ticu_Id INT,
@cuid_UserCreacion  INT
AS BEGIN 
BEGIN TRY
BEGIN TRAN

		-- Si existe
		IF EXISTS (SELECT * FROM bota.tbCuidados WHERE cuid_Observacion = @cuid_Observacion AND cuid_Estado = 1)
		BEGIN
			SELECT 409 AS codeStatus, 'El mantenimiento ya existe.' AS messageStatus
		END


		ELSE IF EXISTS (SELECT * FROM bota.tbCuidados WHERE cuid_Observacion = @cuid_Observacion AND cuid_Estado = 0)
		BEGIN
			DECLARE @Id INT = (SELECT cuid_Id FROM bota.tbCuidados WHERE cuid_Observacion = @cuid_Observacion) 

			BEGIN TRAN -- Agregado BEGIN TRAN

			UPDATE bota.tbCuidados
			SET
				cuid_Observacion =  @cuid_Observacion,
				ticu_Id = @ticu_Id,
				cuid_UserCreacion = @cuid_UserCreacion,
				[cuid_FechaModificacion]  = NULL,
				cuid_Estado = 1
			WHERE cuid_Id = @Id

		    SELECT 200 AS codeStatus, 'El mantenimiento ha sido creado con exito.' AS messageStatus

			COMMIT -- Agregado COMMIT
		END
 

		ELSE IF NOT EXISTS (SELECT * FROM bota.tbCuidados WHERE cuid_Observacion= @cuid_Observacion AND cuid_Estado = 1)
		BEGIN
			INSERT INTO bota.tbCuidados(cuid_Observacion, ticu_Id, cuid_UserCreacion)
			VALUES (@cuid_Observacion, @ticu_Id, @cuid_UserCreacion)

			BEGIN TRAN -- Agregado BEGIN TRAN

			SELECT 200 AS codeStatus, 'El Cuidado ha sido creado con exito.' AS messageStatus

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




CREATE OR ALTER PROC bota.UDP_tbCuidados_UPDATE
@cuid_Id INT,
@cuid_Observacion NVARCHAR(200),
@ticu_Id INT,
@cuid_UserModificacion  INT
AS BEGIN

BEGIN TRY
BEGIN TRAN 

IF EXISTS (SELECT * FROM bota.tbCuidados WHERE cuid_Observacion = @cuid_Observacion AND cuid_Estado = 1)
			BEGIN
				SELECT 409 AS codeStatus, 'El mantenimiento ya existe.' AS messageStatus
			END
			ELSE IF EXISTS (SELECT * FROM bota.tbCuidados WHERE cuid_Observacion= @cuid_Observacion AND cuid_Estado = 0)
			BEGIN
						DECLARE @Id INT = (SELECT cuid_Id FROM bota.tbCuidados WHERE cuid_Observacion= @cuid_Observacion) 

				UPDATE bota.tbCuidados
				SET
						cuid_Observacion =    @cuid_Observacion,
						ticu_Id = @ticu_Id,
						cuid_UserModificacion = @cuid_UserModificacion,
						cuid_Estado = 1
				WHERE   cuid_Id = @Id

				SELECT 200 AS codeStatus, 'El Cuidado ha sido actualizado con exito.' AS messageStatus
			END

			ELSE -- mantenimiento no existe, se realiza la actualizaci�n
			BEGIN
				UPDATE bota.tbCuidados
				SET
					  cuid_Observacion =    @cuid_Observacion,
					  [ticu_Id] = @ticu_Id,
					  cuid_UserModificacion = @cuid_UserModificacion,
					   [cuid_FechaModificacion] = GETDATE()
				WHERE cuid_Id = @cuid_Id

				SELECT 200 AS codeStatus, 'El Cuidado ha sido actualizado con exito.' AS messageStatus
			END


COMMIT
END TRY

BEGIN CATCH
ROLLBACK
END CATCH 
END
GO




CREATE OR ALTER PROC bota.UDP_tbCuidados_DELETE
@cuid_Id INT
AS BEGIN

	BEGIN TRY
	BEGIN TRAN
			--DECLARE @mantes INT = (SELECT COUNT(*) FROM mant.tbMantenimientoAnimal WHERE mant_Id = @mant_Id)
			
			IF 0 > 1
			BEGIN
			SELECT 202 AS codeStatus, 'El mantenimiento todav�a se usa.' AS messageStatus
			END
			ELSE
			BEGIN
			UPDATE bota.tbCuidados
			SET
				cuid_Estado		=	0
				WHERE cuid_Id	=	@cuid_Id

			SELECT 200 AS codeStatus, 'El cuidado ha sido eliminado con exito.' AS messageStatus
			END
	COMMIT
	END TRY
	BEGIN CATCH
	ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
	END CATCH

END
GO