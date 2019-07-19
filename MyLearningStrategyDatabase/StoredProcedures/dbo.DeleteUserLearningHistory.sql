CREATE PROCEDURE [dbo].[DeleteUserLearningHistory]
	@StrategyHistoryId INT NULL, 
	@StrategyId INT NULL,
	@BodyOfKnowledgeId INT NULL,
	@Originator uniqueidentifier
AS
    DECLARE @BodyOfKnowledge_Id INT

	IF (@StrategyHistoryId IS NULL AND @StrategyId IS NULL AND @BodyOfKnowledgeId IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, '[DeleteUserLearningHistory].@BodyOfKnowledgeId');   
	END

	IF (@BodyOfKnowledgeId IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, '[DeleteUserLearningHistory].@BodyOfKnowledgeId');   
	END

	IF ([dbo].[IsBokOriginator](@Originator,@BodyOfKnowledgeId)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END
	
BEGIN

	-- SET XACT_ABORT ON will cause the transaction to be uncommittable  
	-- when the constraint violation occurs.   
	SET XACT_ABORT ON;  

	BEGIN TRY
		IF (@StrategyHistoryId IS NOT NULL )
		BEGIN 
				BEGIN TRANSACTION;
				--[dbo].[LearningHistoryProgress]
				DELETE FROM [dbo].[LearningHistoryProgress]
				WHERE StrategyHistoryId = @StrategyHistoryId

				--[dbo].[LearningHistory]
				DELETE FROM [dbo].[LearningHistory]
				WHERE StrategyHistoryId =@StrategyHistoryId
				COMMIT TRANSACTION;  
		END
		ELSE IF(@StrategyId IS NOT NULL )
		BEGIN 
				BEGIN TRANSACTION;
				--[dbo].[LearningHistoryProgress]
				DELETE FROM [dbo].[LearningHistoryProgress]
				WHERE StrategyHistoryId IN (SELECT StrategyHistoryId
				FROM LearningHistory 
				WHERE StrategyId=@StrategyId 
				AND BodyOfKnowledgeId=@BodyOfKnowledgeId)
				

				--[dbo].[LearningHistory]
				DELETE FROM [dbo].[LearningHistory]
				WHERE StrategyId=@StrategyId

				COMMIT TRANSACTION;  
		END 
		ELSE
		BEGIN
				BEGIN TRANSACTION;
				--[dbo].[LearningHistoryProgress]
				DELETE FROM [dbo].[LearningHistoryProgress]
				WHERE StrategyHistoryId IN (SELECT StrategyHistoryId
				FROM LearningHistory 
				WHERE BodyOfKnowledgeId=@BodyOfKnowledgeId)
				

				--[dbo].[LearningHistory]
				DELETE FROM [dbo].[LearningHistory]
				WHERE  BodyOfKnowledgeId=@BodyOfKnowledgeId

				COMMIT TRANSACTION;  
		END

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
return 	@StrategyHistoryId