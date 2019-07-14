CREATE PROCEDURE [dbo].[GetUsersCategories]
	@CategoryId INT NULL,
	@UserProfileId INT,
	@Originator UNIQUEIDENTIFIER
AS

	IF ([dbo].[IsOriginatorUsers](@UserProfileId,@Originator)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END
	    
	IF ( @CategoryId IS NULL)
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
			WHERE 	CategoryId= @CategoryId
		END
RETURN