CREATE PROCEDURE [dbo].[GetUsersCategories]
	@CategoryId INT NULL,
	@Originator UNIQUEIDENTIFIER
AS
	DECLARE @UserProfileId INT

	SET @UserProfileId = [dbo].[OriginatorToUserId](@Originator)

	IF @CategoryId IS NULL
	BEGIN
		SELECT CategoryId,UserProfileId,CategoryName,
		ImageDevice,ImageCloud,ImageHash,LastModifiedOffset,CloudRowId
		FROM [dbo].[Categories]
		WHERE UserProfileId=@UserProfileId
	END
	ELSE
	BEGIN
		SELECT CategoryId,UserProfileId,CategoryName,
		ImageDevice,ImageCloud,ImageHash,LastModifiedOffset,CloudRowId
		FROM [dbo].[Categories]
		WHERE UserProfileId=@UserProfileId AND CategoryId=@CategoryId
	END
RETURN