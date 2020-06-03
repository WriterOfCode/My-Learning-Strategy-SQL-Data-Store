CREATE PROCEDURE [dbo].[GetUserByExternalID]
	@ExternalID  NVARCHAR (450),
	@IdentityProvider NVARCHAR(2083),
	@DisplayName  NVARCHAR (256),
	@FirstName NVARCHAR (256)
AS	


	IF NOT EXISTS (	SELECT * FROM UserProfiles WHERE ExternalID = @ExternalID AND IdentityProvider=@IdentityProvider)
	BEGIN
		INSERT INTO UserProfiles (ExternalID,DisplayName,IdentityProvider,FirstName)
		VALUES (@ExternalID,@DisplayName,@IdentityProvider,@FirstName);
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
