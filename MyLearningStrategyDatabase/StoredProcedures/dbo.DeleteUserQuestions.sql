CREATE PROCEDURE [dbo].[DeleteUserQuestions]
    @BodyOfKnowledgeId INT,
	@UserProfileId INT,
	@QuestionId INT NULL
AS

IF (@BodyOfKnowledgeId IS NULL)
BEGIN
	RAISERROR (15600, 17,-1, '[DeleteUserQuestions].@BodyOfKnowledgeId');   
END
IF (@UserProfileId IS NULL)
BEGIN
	RAISERROR (15600, 17,-1, 'GetUserLPTableOfContent.@UserProfileId');   
END
IF ([dbo].[IsBokUsers](@UserProfileId,@BodyOfKnowledgeId) =0)
BEGIN
	RAISERROR (13538,14,-1, 'User is not the owner!');   
END

IF (@QuestionId IS NULL)
BEGIN
	-- SET XACT_ABORT ON will cause the transaction to be uncommittable  
	-- when the constraint violation occurs.   
	SET XACT_ABORT ON;  

	BEGIN TRY
		BEGIN TRANSACTION;

		DELETE FROM [dbo].[Responses]
		WHERE QuestionId IN (SELECT QuestionId FROM [dbo].[Questions]
		WHERE BodyOfKnowledgeId = @BodyOfKnowledgeId)

		DELETE [dbo].[Questions]
		WHERE BodyOfKnowledgeId = @BodyOfKnowledgeId
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
ELSE
BEGIN
	-- SET XACT_ABORT ON will cause the transaction to be uncommittable  
	-- when the constraint violation occurs.   
	SET XACT_ABORT ON;  

	BEGIN TRY
		BEGIN TRANSACTION;

		DELETE FROM [dbo].[Responses]
		WHERE QuestionId= @QuestionId

		DELETE [dbo].[Questions]
		WHERE BodyOfKnowledgeId = @BodyOfKnowledgeId
		AND QuestionId = @QuestionId
			
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

RETURN 0
