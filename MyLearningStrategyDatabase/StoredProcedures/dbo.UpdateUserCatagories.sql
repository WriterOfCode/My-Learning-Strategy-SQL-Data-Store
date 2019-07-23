CREATE PROCEDURE [dbo].[UpdateUserCategories]
	@CategoryId  INT,
	@UserProfileId INT,
	@CategoryName NVARCHAR(100) NULL,
	@ImageDevice NVARCHAR(256) NULL, 
	@ImageCloud NVARCHAR(2083) NULL,
	@ImageHash INT NULL, 
	@Originator UNIQUEIDENTIFIER
AS

DECLARE @rowsaffected INT

	IF ([dbo].[IsOriginatorUsers](@UserProfileId,@Originator)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END
		UPDATE [dbo].[Categories] 
		SET CategoryName=@CategoryName,ImageDevice=@ImageDevice,
		ImageCloud=@ImageCloud,ImageHash=@ImageHash,
		LastModifiedOffset=SYSDATETIMEOFFSET()
		WHERE UserProfileId=@UserProfileId and CategoryId=@CategoryId

	SET @rowsaffected = @@ROWCOUNT
RETURN @rowsaffected