CREATE PROCEDURE [dbo].[DeleteUserBodyOfKnowledge]
	@BodyOfKnowledgeId INT  NULL,
	@Originator UNIQUEIDENTIFIER
AS
	DECLARE @UserProfileId INT
	IF (@Originator IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, 'DeleteUserBodyOfKnowledge.@Originator');   
	END

	IF (@BodyOfKnowledgeId IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, 'DeleteUserBodyOfKnowledge.@BodyOfKnowledgeId');   
	END

	SET @UserProfileId = [dbo].[IsBokOriginator](@Originator,@BodyOfKnowledgeId)
	IF (@UserProfileId=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END

BEGIN


	-- SET XACT_ABORT ON will cause the transaction to be uncommittable  
	-- when the constraint violation occurs.   
	SET XACT_ABORT ON;  

	BEGIN TRY
		BEGIN TRANSACTION;
		--[dbo].[Responses]
		DELETE FROM [dbo].[Responses] 
		WHERE QuestionId in (
		SELECT QuestionId from Questions q
		WHERE q.BodyOfKnowledgeId = @BodyOfKnowledgeId);

		--@QuestionId INT NULL,
		--[dbo].[Questions]
		DELETE from Questions
		WHERE BodyOfKnowledgeId = @BodyOfKnowledgeId;

		--[dbo].[AssessmentDefinitions]
		DELETE FROM [dbo].[AssessmentDefinitions] 
		WHERE BodyOfKnowledgeId=@BodyOfKnowledgeId

		--[dbo].[LearningPlanContentSelections]
		DELETE FROM [dbo].[LearningPlanContentSelections]
		WHERE LearningPlanDefinitionId IN (
		SELECT LearningPlanDefinitionId 
		FROM [dbo].[BodyOfKnowledge]
		WHERE BodyOfKnowledgeId=@BodyOfKnowledgeId
		)
	
		--[dbo].[LearningPlanContent]
		DELETE FROM [dbo].[LearningPlanContent]
		WHERE TableOfContentId IN (SELECT TableOfContentId
		FROM [dbo].[LearningPlanTableOfContents]
		WHERE BodyOfKnowledgeId=@BodyOfKnowledgeId
		)
		--[dbo].[LearningPlanTableOfContents]
		DELETE FROM [dbo].[LearningPlanTableOfContents]
		WHERE BodyOfKnowledgeId=@BodyOfKnowledgeId

		--[dbo].[LearningPlanDefinitions]
		DELETE FROM [dbo].[LearningPlanDefinitions]
		WHERE BodyOfKnowledgeId=@BodyOfKnowledgeId


		--[dbo].[Taxonomy]
		DELETE FROM [dbo].[Taxonomy] 
		WHERE BodyOfKnowledgeId=@BodyOfKnowledgeId

		DELETE
		FROM [BodyOfKnowledge]
		WHERE UserProfileId = @UserProfileId
			AND BodyOfKnowledgeId = @BodyOfKnowledgeId;

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