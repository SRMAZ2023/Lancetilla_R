GO
USE db_Lancetilla
GO 
CREATE OR ALTER PROC bota.tbCuidadoPlanta_SELECT
AS
BEGIN

	SELECT TOP (1000) *
	FROM [bota].[VW_tbCuidadoPlanta]
	where cupl_Estado = 1
 	

END

GO 
CREATE OR ALTER PROC bota.tbCuidadoPlanta_FINDArea 
@arbo int
AS
BEGIN

	SELECT TOP (1000) *
	FROM [bota].[VW_tbCuidadoPlanta]
	where cupl_Estado = 1
	and arbo_Id = @arbo
 	

END

GO 
CREATE OR ALTER PROC bota.tbCuidadoPlanta_FINDArea2
@arbo int
AS
BEGIN

	SELECT TOP (1000) *
	FROM [bota].VW_tbPlantas
	where arbo_Id = @arbo
	  
 	

END

GO
CREATE OR ALTER PROC bota.tbCuidadoPlanta_CREATE  
@plan_Id int,
@ticu_Id int,
@cupl_Fecha varchar(30),
@cupl_UserCreacion int
AS BEGIN

BEGIN TRY


INSERT INTO [bota].[tbCuidadoPlanta]
           ([plan_Id]
           ,[ticu_Id]
           ,[cupl_Fecha]
           ,[cupl_UserCreacion])
         VALUES
           (@plan_Id
           ,@ticu_Id
           ,@cupl_Fecha
           ,@cupl_UserCreacion)



			SELECT 200 AS codeStatus,  SCOPE_IDENTITY() AS messageStatus
END TRY

BEGIN CATCH
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus
 END CATCH

END
GO


CREATE OR ALTER PROC bota.tbCuidadoPlanta_UPDATE 
@cupl_Id int,
@plan_Id int,
@ticu_Id int,
@cupl_Fecha  varchar(30),
@cupl_UserModificacion int
AS BEGIN
BEGIN TRY


BEGIN TRAN
			
UPDATE [bota].[tbCuidadoPlanta]
   SET [plan_Id] = @plan_Id
      ,[ticu_Id] = @ticu_Id
      ,[cupl_Fecha] = @cupl_Fecha
      ,[cupl_UserModificacion]  =@cupl_UserModificacion
      ,[cupl_FechaModificacion] = GETDATE()
  WHERE  cupl_Id = @cupl_Id

			SELECT 200 AS codeStatus, 'El cuidado por planta ha sido editado con éxito.' AS messageStatus
COMMIT
			
END TRY

BEGIN CATCH
ROLLBACK
			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus

END CATCH
END
GO


GO
CREATE OR ALTER PROC bota.tbCuidadoPlanta_DELETE
@cupl_Id INT
 AS BEGIN

 BEGIN TRY 
 BEGIN TRAN

 

UPDATE [bota].[tbCuidadoPlanta]
   SET  [cupl_Estado] = 0
  WHERE  cupl_Id = @cupl_Id
 

 			SELECT 200 AS codeStatus, 'El Cuidado ha sido eliminado con éxito.' AS messageStatus

 COMMIT
 END TRY

 BEGIN CATCH
 ROLLBACK
 			SELECT 500 AS codeStatus, ERROR_MESSAGE ( ) AS messageStatus

 END CATCH
 END
 GO





