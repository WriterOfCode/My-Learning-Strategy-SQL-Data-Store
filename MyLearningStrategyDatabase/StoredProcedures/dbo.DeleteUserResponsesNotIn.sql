CREATE PROCEDURE [dbo].[DeteUserResponsesNotIn]
	@ResponseIds NVARCHAR(MAX)
AS
	DECLARE @Character CHAR(1);
	SET @Character = ',';
		BEGIN TRY
		BEGIN TRANSACTION;
	
		DELETE FROM [dbo].[Responses]
		WHERE ResponseId not in (SELECT Item FROM DBO.SPLITSTRING(@ResponseIds,@Character));
			
		-- If the DELETE statement succeeds, commit the transaction.  
		COMMIT TRANSACTION;  
	END TRY
	BEGIN CATCH  
		-- Execute error retrieval routine.  
		-- Test XACT_STATE:  
			-- If 1, the transaction is committable.  
			-- If -1, the transaction is uncommittable and should   
			--     be rolled back.  
			-- XACT_STATE = 0 means that there is no transaction and  
			--     a commit or rollback operation would generate an error.  

		-- Test whether the transaction is uncommittable.  
		IF (XACT_STATE()) = -1  
		BEGIN  
			ROLLBACK TRANSACTION;  
		END;  

		-- Test whether the transaction is committable.  
		IF (XACT_STATE()) = 1  
		BEGIN  
			COMMIT TRANSACTION;     
		END;  
	END CATCH;
RETURN 0