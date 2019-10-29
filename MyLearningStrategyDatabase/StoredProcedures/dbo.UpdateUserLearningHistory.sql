CREATE PROCEDURE [dbo].[UpdateUserLearningHistory]
	@StrategyHistoryId INT , 
	@Originator UNIQUEIDENTIFIER,
	@BodyOfKnowledgeId INT,
	@NumberOfTimesTried INT,
	@LastQuestionId INT
AS

	IF (@BodyOfKnowledgeId IS NULL)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');  
	END
	IF ([dbo].[IsBokOriginator](@Originator,@BodyOfKnowledgeId)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END
	

	UPDATE LearningHistory
	SET NumberOfTimesTried = @NumberOfTimesTried,
	LastQuestionId=@LastQuestionId
	WHERE  StrategyHistoryId= @StrategyHistoryId
	AND BodyOfKnowledgeId =@BodyOfKnowledgeId


RETURN 0
