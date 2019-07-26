CREATE PROCEDURE [dbo].[AddUserCatagory]
	@CategoryName NVARCHAR(100),
	@ImageDevice NVARCHAR(256) NULL, 
	@ImageCloud NVARCHAR(2083) NULL,
	@ImageHash INT NULL,
	@Originator UNIQUEIDENTIFIER
AS

	--DECLARE @CategoryId INT;
	DECLARE @UserProfileId INT
	SET @UserProfileId = [dbo].[OriginatorToUserId](@Originator)

	BEGIN
		INSERT INTO [dbo].[Categories](UserProfileId,CategoryName,ImageDevice,ImageCloud,ImageHash )
		VALUES (@UserProfileId,@CategoryName,@ImageDevice,@ImageCloud,@ImageHash);
 
 		SELECT CAST(SCOPE_IDENTITY() AS INT) AS IdentiyValue;
	END

RETURN