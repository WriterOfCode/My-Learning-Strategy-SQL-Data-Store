CREATE PROCEDURE [dbo].[UpdateUserProfile]
	@ExternalID  NVARCHAR (450),
	@DisplayName  NVARCHAR (256),
	@EmailAddress       NVARCHAR (500) NULL,
	@FirstName   NVARCHAR (256) NULL,
	@LastName    NVARCHAR (256) NULL,
	@PostalCode NCHAR(10) NULL, 
	@IdentityProvider NVARCHAR(2083), 
	@ImageDevice NVARCHAR(256) NULL, 
	@ImageCloud NVARCHAR(2083) NULL,
	@ImageHash INT NULL, 
	@HasLoggedIn BIT NULL,
	@IsLocked    BIT NULL, 
	@IsDisabled  BIT NULL, 
	@IsDeleted BIT NULL,
	@Originator  UNIQUEIDENTIFIER NULL
AS

DECLARE @rowsaffected INT 

IF NOT EXISTS (SELECT * FROM UserProfiles 
	WHERE ExternalID = @ExternalID
	AND IdentityProvider=@IdentityProvider)
BEGIN
	 INSERT INTO UserProfiles (ExternalID,DisplayName,EmailAddress,FirstName,LastName,
		PostalCode,IdentityProvider,ImageDevice,ImageCloud,ImageHash,HasLoggedIn,
		IsLocked,IsDisabled,IsDeleted)
		VALUES (@ExternalID,@DisplayName,@EmailAddress,@FirstName,
		@LastName,@PostalCode,@IdentityProvider,
		@ImageDevice,@ImageCloud,@ImageHash,@HasLoggedIn,
		@IsLocked,@IsDisabled,@IsDeleted);
END

	SELECT UserProfileId,ExternalID,DisplayName,EmailAddress,
	FirstName,LastName,PostalCode,IdentityProvider,
	Originator,ImageDevice,ImageCloud,ImageHash,
	HasLoggedIn,IsLocked,IsDisabled,IsDeleted,
	LastModifiedOffset
	FROM UserProfiles 
	WHERE ExternalID = @ExternalID
	AND IdentityProvider=@IdentityProvider;

RETURN
