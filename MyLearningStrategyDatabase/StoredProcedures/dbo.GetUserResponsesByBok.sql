CREATE PROCEDURE [dbo].[GetUserResponsesByBok]
	@BodyOfKnowledgeId int,
    @Originator uniqueidentifier
AS

	IF ([dbo].[IsBokOriginator](@Originator,@BodyOfKnowledgeId)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END
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
		where b.BodyOfKnowledgeId = @BodyOfKnowledgeId and u.Originator = @Originator
RETURN 0
