CREATE PROCEDURE [dbo].[UpdateUserCategories]
	@CategoryId  INT,
	@CategoryName NVARCHAR(100) NULL,
	@ImageDevice NVARCHAR(256) NULL, 
	@ImageCloud NVARCHAR(2083) NULL,
	@ImageHash INT NULL, 
	@Originator UNIQUEIDENTIFIER
AS

DECLARE @rowsaffected INT
	DECLARE @UserProfileId INT
	SET @UserProfileId = [dbo].[OriginatorToUserId](@Originator)

	UPDATE [dbo].[Categories] 
	SET CategoryName=@CategoryName,ImageDevice=@ImageDevice,
	ImageCloud=@ImageCloud,ImageHash=@ImageHash,
	LastModifiedOffset=SYSDATETIMEOFFSET()
	WHERE UserProfileId=@UserProfileId and CategoryId=@CategoryId

	SET @rowsaffected = @@ROWCOUNT
RETURN @rowsaffected