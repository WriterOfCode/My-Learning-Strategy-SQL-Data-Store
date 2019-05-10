CREATE PROCEDURE [dbo].[DeleteUserAssessmentDefinitions]
    @BodyOfKnowledgeId INT NULL,
	@AssessmentDefinitionId INT NULL,
	@Originator UNIQUEIDENTIFIER
AS
IF (@BodyOfKnowledgeId IS NULL)
BEGIN
	RAISERROR (15600, 17,-1, 'DeleteUserAssessmentDefinitions.@BodyOfKnowledgeId');   
END
IF (@Originator IS NULL)
BEGIN
	RAISERROR (15600, 17,-1, 'DeleteUserAssessmentDefinitions.@Originator');   
END
IF ([dbo].[IsBokOriginator](@Originator,@BodyOfKnowledgeId) =0)
BEGIN
	RAISERROR (13538,14,-1, 'User is not the owner!');   
END

	IF (@AssessmentDefinitionId IS NULL)
	BEGIN
		DELETE
		FROM [dbo].[AssessmentDefinitions]
		WHERE BodyOfKnowledgeId = @BodyOfKnowledgeId
	END 
	ELSE
	BEGIN
		DELETE
		FROM [dbo].[AssessmentDefinitions]
		WHERE BodyOfKnowledgeId = @BodyOfKnowledgeId
		AND AssessmentDefinitionId = @AssessmentDefinitionId
	END

RETURN 0

	