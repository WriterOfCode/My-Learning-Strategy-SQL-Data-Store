﻿CREATE PROCEDURE [dbo].[GetSubjectCategories]
    @BodyOfKnowledgeId INT NULL,
	@CategoryId INT NULL,
	@Originator UNIQUEIDENTIFIER
AS
	  IF (@CategoryId IS NULL AND @BodyOfKnowledgeId IS NULL) 
		BEGIN
			SELECT 
			bokc.BodyOfKnowledgeId, 
			c.CategoryId as Id, 
			c.CategoryName,
			c.ImageDevice, 
			c.ImageCloud,
			c.ImageHash
			FROM [dbo].[BodyOfKnowledgeCategories] bokc
			JOIN [dbo].[Categories] c on c.CategoryId = bokc.CategoryId AND c.UserProfileId = bokc.UserProfileId
			JOIN [dbo].[UserProfiles] u on u.UserProfileId = bokc.UserProfileId
			WHERE u.Originator = @Originator
		END
	ELSE  IF (@CategoryId IS NULL) 
		BEGIN
			SELECT
			bokc.BodyOfKnowledgeId, 
			c.CategoryId as Id, 
			c.CategoryName,
			c.ImageDevice, 
			c.ImageCloud,
			c.ImageHash
			FROM [dbo].[BodyOfKnowledgeCategories] bokc
			JOIN [dbo].[Categories] c on c.CategoryId = bokc.CategoryId AND c.UserProfileId = bokc.UserProfileId
			JOIN [dbo].[UserProfiles] u on u.UserProfileId = bokc.UserProfileId
			WHERE u.Originator = @Originator
			AND bokc.BodyOfKnowledgeId=@BodyOfKnowledgeId 
		END
	ELSE 
		BEGIN
			SELECT
			bokc.BodyOfKnowledgeId, 
			c.CategoryId as Id, 
			c.CategoryName,
			c.ImageDevice, 
			c.ImageCloud,
			c.ImageHash
			FROM [dbo].[BodyOfKnowledgeCategories] bokc
			JOIN [dbo].[Categories] c on c.CategoryId = bokc.CategoryId AND c.UserProfileId = bokc.UserProfileId
			JOIN [dbo].[UserProfiles] u on u.UserProfileId = bokc.UserProfileId
			WHERE   bokc.BodyOfKnowledgeId=@BodyOfKnowledgeId 
			AND u.Originator = @Originator
			AND c.CategoryId=@CategoryId
		END
	
RETURN 0