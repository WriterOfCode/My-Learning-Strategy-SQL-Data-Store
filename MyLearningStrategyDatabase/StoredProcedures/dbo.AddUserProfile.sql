CREATE PROCEDURE [dbo].[AddUserProfile]
	@ExternalID  NVARCHAR (450),
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
	@IsDeleted BIT NULL
AS	

DECLARE @UserProfileId INT


BEGIN
	INSERT INTO UserProfiles
		(ExternalID,DisplayName,EmailAddress,FirstName,LastName,
		PostalCode,IdentityProvider,Originator,ImageDevice,
		ImageCloud,ImageHash,HasLoggedIn,IsLocked,IsDisabled,
		IsDeleted)
	VALUES (@ExternalID,@DisplayName,@EmailAddress,@FirstName,
    @LastName,@PostalCode,@IdentityProvider,@Originator,
	@ImageDevice,@ImageCloud,@ImageHash,@HasLoggedIn,
    @IsLocked,@IsDisabled,@IsDeleted);

	SET @UserProfileId = CAST(SCOPE_IDENTITY() AS INT);

	SELECT Originator
	FROM UserProfiles UP 
	WHERE UP.UserProfileId = @UserProfileId
END
RETURN