CREATE PROCEDURE [dbo].[GetCategories]
	@CategoryId INT NULL,
	@Originator UNIQUEIDENTIFIER
AS
	DECLARE @UserProfileId INT

	SET @UserProfileId = [dbo].[OriginatorToUserId](@Originator)

	IF @CategoryId IS NULL
	BEGIN
		SELECT CategoryId as Id,UserProfileId,CategoryName,
		ImageDevice,ImageCloud,ImageHash,LastModifiedOffset,CloudRowId
		FROM [dbo].[Categories]
		WHERE UserProfileId=@UserProfileId
	END
	ELSE
	BEGIN
		SELECT CategoryId as Id,UserProfileId,CategoryName,
		ImageDevice,ImageCloud,ImageHash,LastModifiedOffset,CloudRowId
		FROM [dbo].[Categories]
		WHERE UserProfileId=@UserProfileId AND CategoryId=@CategoryId
	END
RETURN