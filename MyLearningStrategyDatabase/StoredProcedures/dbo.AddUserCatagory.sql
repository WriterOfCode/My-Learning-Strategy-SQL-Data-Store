CREATE PROCEDURE [dbo].[AddUserCatagory]
	@UserProfileId INT,
	@CategoryName NVARCHAR(100),
	@ImageDevice NVARCHAR(256) NULL, 
	@ImageCloud NVARCHAR(2083) NULL,
	@ImageHash INT NULL,
	@Originator UNIQUEIDENTIFIER
AS

	DECLARE @CategoryId INT;
	IF ([dbo].[IsOriginatorUsers](@UserProfileId,@Originator)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END

	BEGIN
		INSERT INTO [dbo].[Categories](UserProfileId,CategoryName,ImageDevice,ImageCloud,ImageHash )
		VALUES (@UserProfileId,@CategoryName,@ImageDevice,@ImageCloud,@ImageHash);
 
 		--SET @CategoryId = CAST(SCOPE_IDENTITY() AS INT)
		SELECT CAST(SCOPE_IDENTITY() AS INT) AS CategoryId;
	END

RETURN @CategoryId