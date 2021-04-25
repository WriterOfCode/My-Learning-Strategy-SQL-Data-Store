CREATE PROCEDURE [dbo].[DeleteUserQuestionsNotIn]
	@QuestionIds NVARCHAR(MAX)
AS

BEGIN
	-- SET XACT_ABORT ON will cause the transaction to be uncommittable  
	-- when the constraint violation occurs.   
	SET XACT_ABORT ON;  

	BEGIN TRY
		BEGIN TRANSACTION;

		--[dbo].[LearningHistoryProgress]
		DELETE FROM [dbo].[LearningHistoryProgress]
		WHERE QuestionId not in (SELECT QuestionId FROM DBO.SPLITSTRING(@QuestionIds));

		--[dbo].[QuestionCategories]
		DELETE FROM [dbo].[QuestionCategories]
		WHERE QuestionId  not in (SELECT QuestionId FROM DBO.SPLITSTRING(@QuestionIds));

		DELETE FROM [dbo].[Responses]
		WHERE QuestionId  not in (SELECT QuestionId FROM DBO.SPLITSTRING(@QuestionIds));

		DELETE [dbo].[Questions]
		WHERE QuestionId  not in (SELECT QuestionId FROM DBO.SPLITSTRING(@QuestionIds));
			
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
END


RETURN
