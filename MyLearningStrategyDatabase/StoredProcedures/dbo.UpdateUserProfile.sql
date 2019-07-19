CREATE PROCEDURE [dbo].[UpdateUserProfile]
	@ExternalID  NVARCHAR (450)NULL,
	@DisplayName  NVARCHAR (256) NULL,
	@EmailAddress       NVARCHAR (500) NULL,
	@FirstName   NVARCHAR (256) NULL,
	@LastName    NVARCHAR (256) NULL,
	@PostalCode NCHAR(10) NULL, 
	@IdentityProvider NVARCHAR(2083) NULL, 
	@Originator  UNIQUEIDENTIFIER, 
	@ImageDevice NVARCHAR(256) NULL, 
	@ImageCloud NVARCHAR(2083) NULL,
	@ImageHash INT NULL, 
	@HasLoggedIn BIT NULL,
	@IsLocked    BIT NULL, 
	@IsDisabled  BIT NULL, 
	@IsDeleted BIT NULL, 
	@LastModifiedOffset DATETIMEOFFSET NULL
AS	

DECLARE @rowsaffected INT 
IF (@Originator IS NULL)
BEGIN
	RAISERROR (15600, 17,-1, '[UpdateUserProfile].@Originator');   
END

	UPDATE UserProfiles
	SET ExternalID=@ExternalID,
		DisplayName=@DisplayName,
		EmailAddress=@EmailAddress,
		FirstName=@FirstName,
		LastName=@LastName,
		PostalCode=@PostalCode,
		IdentityProvider=@IdentityProvider,
		ImageDevice=@ImageDevice,
		ImageCloud=@ImageCloud,
		ImageHash=@ImageHash,
		HasLoggedIn=@HasLoggedIn,
		IsLocked=@IsLocked,
		IsDisabled=@IsDisabled,
		IsDeleted=@IsDeleted,
		LastModifiedOffset=SYSDATETIMEOFFSET()
	WHERE Originator =@Originator;
	
	SET @rowsaffected = @@ROWCOUNT
RETURN @rowsaffected
