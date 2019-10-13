CREATE PROCEDURE [dbo].[GetUserQuestions]
    @BodyOfKnowledgeId INT NULL,
	@QuestionId INT NULL,
	@Originator UNIQUEIDENTIFIER
AS

IF @QuestionId IS NULL AND @BodyOfKnowledgeId IS NULL
	BEGIN
		SELECT q.QuestionId,
				q.BodyOfKnowledgeId,
				q.OrderBy,
				q.Question,		
				q.Image_1_Device, 
				q.Image_1_Cloud, 
				q.Image_1_Hash,
				q.Image_2_Device, 
				q.Image_2_Cloud, 
				q.Image_2_Hash,
				q.Image_3_Device, 
				q.Image_3_Cloud, 
				q.Image_3_Hash,
				q.Hyperlink_1,
				q.Hyperlink_2,
				q.Hyperlink_3,
				q.LastModifiedOffset,
				q.CloudRowId,
				q.Mnemonic
		  FROM Questions q
		  Join BodyOfKnowledge k on q.BodyOfKnowledgeId = k.BodyOfKnowledgeId
		  JOIN UserProfiles u on u.UserProfileId = k.UserProfileId
		  WHERE u.Originator = @Originator;
	END
ELSE IF @QuestionId IS NULL
	BEGIN 
		SELECT q.QuestionId,
				q.BodyOfKnowledgeId,
				q.OrderBy,
				q.Question,		
				q.Image_1_Device, 
				q.Image_1_Cloud, 
				q.Image_1_Hash,
				q.Image_2_Device, 
				q.Image_2_Cloud, 
				q.Image_2_Hash,
				q.Image_3_Device, 
				q.Image_3_Cloud, 
				q.Image_3_Hash,
				q.Hyperlink_1,
				q.Hyperlink_2,
				q.Hyperlink_3,
				q.LastModifiedOffset,
				q.CloudRowId,
				q.Mnemonic
		  FROM Questions q
		  Join BodyOfKnowledge k on q.BodyOfKnowledgeId = k.BodyOfKnowledgeId
		  JOIN UserProfiles u on u.UserProfileId = k.UserProfileId
		  WHERE k.BodyOfKnowledgeId = @BodyOfKnowledgeId
		  and u.Originator = @Originator;
	END
ELSE 
	BEGIN 
		SELECT q.QuestionId,
				q.BodyOfKnowledgeId,
				q.OrderBy,
				q.Question,		
				q.Image_1_Device, 
				q.Image_1_Cloud, 
				q.Image_1_Hash,
				q.Image_2_Device, 
				q.Image_2_Cloud, 
				q.Image_2_Hash,
				q.Image_3_Device, 
				q.Image_3_Cloud, 
				q.Image_3_Hash,
				q.Hyperlink_1,
				q.Hyperlink_2,
				q.Hyperlink_3,
				q.LastModifiedOffset,
				q.CloudRowId,
				q.Mnemonic
		  FROM Questions q
		  Join BodyOfKnowledge k on q.BodyOfKnowledgeId = k.BodyOfKnowledgeId
		  JOIN UserProfiles u on u.UserProfileId = k.UserProfileId
		  WHERE k.BodyOfKnowledgeId = @BodyOfKnowledgeId
		  AND q.QuestionId = @QuestionId
		  and u.Originator = @Originator;
	END 
RETURN 