CREATE PROCEDURE [dbo].[AddUserProfile]
	@ExternalID  NVARCHAR (450) NULL,
	@DisplayName  NVARCHAR (256) NULL,
    @EmailAddress       NVARCHAR (500) NULL,
    @FirstName   NVARCHAR (256) NULL,
    @LastName    NVARCHAR (256) NULL,
    @PostalCode NCHAR(10) NULL, 
    @IdentityProvider NCHAR(10) NULL,
	@ImageUrl    NVARCHAR(2083) NULL, 
	@HasLoggedIn BIT NULL,
    @IsLocked    BIT NULL, 
    @IsDisabled  BIT NULL,
	@LastModifiedOffset DATETIMEOFFSET NULL
AS	

DECLARE @UserProfileId INT

IF (@ExternalID IS NULL)
BEGIN
	RAISERROR (15600, 17,-1, '[AddUserProfile].@ExternalID');   
END
BEGIN
	INSERT INTO UserProfiles
		(ExternalID,DisplayName,EmailAddress,FirstName,LastName
		,PostalCode,IdentityProvider,ImageUrl,HasLoggedIn
		,IsLocked,IsDisabled,LastModifiedOffset)
	VALUES (@ExternalID,@DisplayName,@EmailAddress,@FirstName,@LastName
	,@PostalCode,@IdentityProvider,@ImageUrl,@HasLoggedIn,@IsLocked
	,@IsDisabled,@LastModifiedOffset);

	SET @UserProfileId = CAST(SCOPE_IDENTITY() AS INT);

	SELECT Originator
	FROM UserProfiles UP 
	WHERE UP.UserProfileId = @UserProfileId
END
RETURN