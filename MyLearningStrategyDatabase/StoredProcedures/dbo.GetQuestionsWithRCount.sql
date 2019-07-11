CREATE PROCEDURE [dbo].[GetQuestionsWithRCount]
    @BodyOfKnowledgeId INT,
	@Originator UNIQUEIDENTIFIER
AS
	IF (@BodyOfKnowledgeId IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, 'GetQuestionsWithRCount.@BodyOfKnowledgeId');   
	END
	IF (@Originator IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, 'GetQuestionsWithRCount.@Originator');   
	END
	IF ([dbo].[IsBokOriginator](@Originator,@BodyOfKnowledgeId)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END
--BodyOfKnowledgeId @QuestionId
	BEGIN
		SELECT QuestionId,
			BodyOfKnowledgeId,
			AppliedTaxonomyId,
			OrderBy,
			Question,
			Image_1_Device, 
			Image_1_Cloud, 
			Image_2_Device, 
			Image_2_Cloud, 
			Image_3_Device, 
			Image_3_Cloud, 
			Hyperlink_1,
			Hyperlink_2,
			Hyperlink_3,
			LastModifiedOffset,
			CloudRowId,
			Mnemonic,
			(SELECT COUNT(*) from Responses RC where RC.QuestionId = Q.QuestionId) AS ResponseCount
		FROM [Questions] Q
		WHERE  BodyOfKnowledgeId = @BodyOfKnowledgeId;
	END

RETURN 0
