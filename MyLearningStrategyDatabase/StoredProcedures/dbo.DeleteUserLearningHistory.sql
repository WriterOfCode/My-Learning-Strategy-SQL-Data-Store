CREATE PROCEDURE [dbo].[DeleteUserLearningHistory]
	@StrategyHistoryId INT, 
	@Originator uniqueidentifier
AS
    DECLARE @BodyOfKnowledgeId INT

	SELECT @BodyOfKnowledgeId = MAX(ls.BodyOfKnowledgeId)
	FROM LearningStrategies ls
	join LearningHistory lp
	on ls.StrategyId=lp.StrategyId
	WHERE @StrategyHistoryId=@StrategyHistoryId

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
		BEGIN TRANSACTION;

		--[dbo].[LearningHistoryProgress]
		DELETE FROM [dbo].[LearningHistoryProgress]
		WHERE StrategyHistoryId =@StrategyHistoryId

		--[dbo].[LearningHistory]
		DELETE FROM [dbo].[LearningHistory]
		WHERE StrategyHistoryId =@StrategyHistoryId

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
return 	@StrategyHistoryId