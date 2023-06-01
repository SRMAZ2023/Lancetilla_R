

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
 					
		SELECT 409 AS codeStatus, 'El tipo de cuidado ya éxiste.' AS messageStatus

	 end else begin

	 INSERT INTO [bota].[tbTiposCuidados]
           ([ticu_Descripcion]
           ,[ticu_UserCreacion])
     VALUES
           (@ticu_Descripcion
           ,@ticu_UserCreacion)

		   SELECT 200 AS codeStatus, 'El tipo cuidado por planta ha sido creado con éxito.' AS messageStatus

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

			SELECT 409 AS codeStatus, 'El tipo de cuidado ya éxiste.' AS messageStatus

	END ELSE BEGIN
			
			UPDATE	[bota].[tbTiposCuidados]
			SET		[ticu_Descripcion] = @ticu_Descripcion
					,[ticu_UserModificacion] = @ticu_UserModificacion
					,[ticu_FechaModificacion] = GETDATE()
			WHERE	 ticu_Id = @ticu_Id

		   SELECT 200 AS codeStatus, 'El tipo cuidado por planta ha sido editado con éxito.' AS messageStatus


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
 
		SELECT 200 AS codeStatus, 'El tipo cuidado ha sido eliminado con éxito.' AS messageStatus

 COMMIT
 END TRY

 BEGIN CATCH
 ROLLBACK
 			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus

 END CATCH
 END
 GO