CREATE PROCEDURE [dbo].[GetUserByExternalID]
	@ExternalID  NVARCHAR (450),
	@IdentityProvider NVARCHAR(2083),
	@DisplayName  NVARCHAR (256),
	@FirstName NVARCHAR (256)
AS	


	IF NOT EXISTS (	SELECT * FROM UserProfiles WHERE ExternalID = @ExternalID AND IdentityProvider=@IdentityProvider)
	BEGIN
		Declare @UserProfileId int;

		INSERT INTO UserProfiles (ExternalID,DisplayName,IdentityProvider,FirstName)
		VALUES (@ExternalID,@DisplayName,@IdentityProvider,@FirstName);
		SET @UserProfileId = CAST(SCOPE_IDENTITY() AS INT);

		commit;
		
		INSERT INTO [dbo].[Categories](UserProfileId,CategoryName,ImageDevice,ImageCloud,ImageHash )
		VALUES (@UserProfileId,'Default','Default','Default',0);
 	
		INSERT INTO [dbo].[Strategies]
			(Name,
			UserProfileId, 
			Description, 
			SortRuleId,  
			QuestionSelection,
			ResponseSelection,
			OnlyCorrect,
			RecycleIncorrectlyAnswered)
		VALUES ('Default',@UserProfileId, 'Default', 0, 0, 0, 0,0);


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
