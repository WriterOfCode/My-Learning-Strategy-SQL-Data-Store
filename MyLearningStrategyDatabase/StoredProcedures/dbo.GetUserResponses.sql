CREATE PROCEDURE [dbo].[GetUserResponses]
	@ResponseId INT NULL,
	@BodyOfKnowledgeId INT NULL,
    @QuestionId INT NULL,
	@Originator UNIQUEIDENTIFIER
AS

IF (@Originator IS NOT NULL AND  @BodyOfKnowledgeId IS NOT NULL AND @QuestionId IS NOT NULL AND @ResponseId IS NOT NULL )
BEGIN
	SELECT r.ResponseId
			,r.QuestionId
			,r.OrderBy
			,r.IsCorrect
			,r.Response
			,r.Image_1_Device
			,r.Image_1_Cloud
			,r.Image_1_Hash
			,r.Image_2_Device
			,r.Image_2_Cloud
			,r.Image_2_Hash
			,r.Image_3_Device
			,r.Image_3_Cloud
			,r.Image_3_Hash
			,r.Hyperlink_1
			,r.Hyperlink_2
			,r.Hyperlink_3
			,r.Mnemonic
			,r.LastModifiedOffset
			,r.CloudRowId
		FROM dbo.Responses r
		join Questions q on r.QuestionId = q.QuestionId
		join BodyOfKnowledge b on b.BodyOfKnowledgeId = q.BodyOfKnowledgeId
		join UserProfiles u on b.UserProfileId = u.UserProfileId
		WHERE  u.Originator = @Originator
	    AND b.BodyOfKnowledgeId = @BodyOfKnowledgeId
		AND R.QuestionId= @QuestionId
	    AND R.ResponseId= @ResponseId;
END 
ELSE IF (@Originator IS NOT NULL AND  @BodyOfKnowledgeId IS NOT NULL AND @QuestionId IS NOT NULL AND @ResponseId IS NULL )
BEGIN

	SELECT r.ResponseId
			,r.QuestionId
			,r.OrderBy
			,r.IsCorrect
			,r.Response
			,r.Image_1_Device
			,r.Image_1_Cloud
			,r.Image_1_Hash
			,r.Image_2_Device
			,r.Image_2_Cloud
			,r.Image_2_Hash
			,r.Image_3_Device
			,r.Image_3_Cloud
			,r.Image_3_Hash
			,r.Hyperlink_1
			,r.Hyperlink_2
			,r.Hyperlink_3
			,r.Mnemonic
			,r.LastModifiedOffset
			,r.CloudRowId
		FROM dbo.Responses r
		join Questions q on r.QuestionId = q.QuestionId
		join BodyOfKnowledge b on b.BodyOfKnowledgeId = q.BodyOfKnowledgeId
		join UserProfiles u on b.UserProfileId = u.UserProfileId
		WHERE  u.Originator = @Originator
	    AND b.BodyOfKnowledgeId = @BodyOfKnowledgeId
		AND R.QuestionId= @QuestionId;
END 
ELSE IF (@Originator IS NOT NULL AND  @BodyOfKnowledgeId IS NOT NULL AND @QuestionId IS NULL AND @ResponseId IS NULL )
BEGIN
	SELECT r.ResponseId
			,r.QuestionId
			,r.OrderBy
			,r.IsCorrect
			,r.Response
			,r.Image_1_Device
			,r.Image_1_Cloud
			,r.Image_1_Hash
			,r.Image_2_Device
			,r.Image_2_Cloud
			,r.Image_2_Hash
			,r.Image_3_Device
			,r.Image_3_Cloud
			,r.Image_3_Hash
			,r.Hyperlink_1
			,r.Hyperlink_2
			,r.Hyperlink_3
			,r.Mnemonic
			,r.LastModifiedOffset
			,r.CloudRowId
		FROM dbo.Responses r
		join Questions q on r.QuestionId = q.QuestionId
		join BodyOfKnowledge b on b.BodyOfKnowledgeId = q.BodyOfKnowledgeId
		join UserProfiles u on b.UserProfileId = u.UserProfileId
		WHERE  u.Originator = @Originator
	    AND b.BodyOfKnowledgeId = @BodyOfKnowledgeId
END
ELSE IF (@Originator IS NOT NULL AND  @BodyOfKnowledgeId IS NULL AND @QuestionId IS NULL AND @ResponseId IS NULL )
BEGIN
	SELECT r.ResponseId
			,r.QuestionId
			,r.OrderBy
			,r.IsCorrect
			,r.Response
			,r.Image_1_Device
			,r.Image_1_Cloud
			,r.Image_1_Hash
			,r.Image_2_Device
			,r.Image_2_Cloud
			,r.Image_2_Hash
			,r.Image_3_Device
			,r.Image_3_Cloud
			,r.Image_3_Hash
			,r.Hyperlink_1
			,r.Hyperlink_2
			,r.Hyperlink_3
			,r.Mnemonic
			,r.LastModifiedOffset
			,r.CloudRowId
		FROM dbo.Responses r
		join Questions q on r.QuestionId = q.QuestionId
		join BodyOfKnowledge b on b.BodyOfKnowledgeId = q.BodyOfKnowledgeId
		join UserProfiles u on b.UserProfileId = u.UserProfileId
		WHERE  u.Originator = @Originator;
END
IF (@Originator IS NOT NULL AND  @BodyOfKnowledgeId IS NULL AND @QuestionId IS NULL AND @ResponseId IS NOT NULL )
BEGIN
	SELECT r.ResponseId
			,r.QuestionId
			,r.OrderBy
			,r.IsCorrect
			,r.Response
			,r.Image_1_Device
			,r.Image_1_Cloud
			,r.Image_1_Hash
			,r.Image_2_Device
			,r.Image_2_Cloud
			,r.Image_2_Hash
			,r.Image_3_Device
			,r.Image_3_Cloud
			,r.Image_3_Hash
			,r.Hyperlink_1
			,r.Hyperlink_2
			,r.Hyperlink_3
			,r.Mnemonic
			,r.LastModifiedOffset
			,r.CloudRowId
		FROM dbo.Responses r
		join Questions q on r.QuestionId = q.QuestionId
		join BodyOfKnowledge b on b.BodyOfKnowledgeId = q.BodyOfKnowledgeId
		join UserProfiles u on b.UserProfileId = u.UserProfileId
		WHERE  u.Originator = @Originator
	    AND R.ResponseId= @ResponseId;
END 
RETURN 0
