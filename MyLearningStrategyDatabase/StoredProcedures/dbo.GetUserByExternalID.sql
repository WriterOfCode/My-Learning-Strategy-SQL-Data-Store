CREATE PROCEDURE [dbo].[GetUserByExternalID]
	@ExternalID  NVARCHAR (450) NULL,
	@DisplayName  NVARCHAR (256) NULL,
    @EmailAddress       NVARCHAR (500) NULL,
    @FirstName   NVARCHAR (256) NULL,
    @LastName    NVARCHAR (256) NULL,
    @PostalCode NCHAR(10) NULL, 
    @IdentityProvider NCHAR(10) NULL,
	@ImageUrl    NVARCHAR(2083) NULL, 
	@HasLoggedIn BIT            NULL,
    @IsLocked    BIT NULL, 
    @IsDisabled  BIT NULL,
	@LastModifiedOffset DATETIMEOFFSET NULL
AS	
IF (@ExternalID IS NULL)
BEGIN
	RAISERROR (15600, 17,-1, 'GetUserByExternalID.@ExternalID');   
END


	IF EXISTS (	SELECT * FROM UserProfiles WHERE ExternalID = @ExternalID)
		BEGIN
			SELECT UserProfileId,ExternalID,DisplayName,EmailAddress
			,FirstName,LastName,PostalCode,IdentityProvider,Originator
			,ImageUrl,HasLoggedIn,IsLocked,IsDisabled,LastModifiedOffset
			FROM UserProfiles 
			WHERE ExternalID = @ExternalID;
		END
	ELSE
		BEGIN
		INSERT INTO UserProfiles
			(ExternalID,DisplayName,EmailAddress,FirstName,LastName
			,PostalCode,IdentityProvider,ImageUrl,HasLoggedIn
			,IsLocked,IsDisabled,LastModifiedOffset)
		VALUES (@ExternalID,@DisplayName,@EmailAddress,@FirstName,@LastName
		,@PostalCode,@IdentityProvider,@ImageUrl,@HasLoggedIn,@IsLocked
		,@IsDisabled,@LastModifiedOffset)

		SELECT UserProfileId,ExternalID,DisplayName,EmailAddress
		,FirstName,LastName,PostalCode,IdentityProvider,Originator
		,ImageUrl,HasLoggedIn,IsLocked,IsDisabled,LastModifiedOffset
		FROM UserProfiles 
		WHERE ExternalID = @ExternalID;
		END
RETURN 0
