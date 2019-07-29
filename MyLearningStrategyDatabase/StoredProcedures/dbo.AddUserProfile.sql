﻿CREATE PROCEDURE [dbo].[AddUserProfile]
	@ExternalID  NVARCHAR (450),
	@DisplayName  NVARCHAR (256) NULL,
	@EmailAddress NVARCHAR (500) NULL,
	@FirstName    NVARCHAR (256) NULL,
	@LastName     NVARCHAR (256) NULL,
	@PostalCode   NCHAR(10) NULL, 
	@IdentityProvider NVARCHAR(2083) NULL, 
	@ImageDevice  NVARCHAR(256) NULL, 
	@ImageCloud   NVARCHAR(2083) NULL,
	@ImageHash   INT NULL, 
	@HasLoggedIn BIT NULL,
	@IsLocked    BIT NULL, 
	@IsDisabled  BIT NULL, 
	@IsDeleted   BIT NULL
AS	

DECLARE @UserProfileId INT

BEGIN

	MERGE UserProfiles t
		USING (select @ExternalID as ExternalID,
				@DisplayName as DisplayName, 
				@EmailAddress as EmailAddress , 
				@FirstName as FirstName, 
				@LastName as LastName,
				@PostalCode as PostalCode,
				@IdentityProvider as IdentityProvider,
				@ImageDevice as ImageDevice,
				@ImageCloud as ImageCloud,
				@ImageHash as ImageHash,
				@HasLoggedIn as HasLoggedIn,
				@IsLocked as IsLocked,
				@IsDisabled as IsDisabled,
				@IsDeleted as IsDeleted) s
		ON (t.ExternalID=s.ExternalID 
				AND t.IdentityProvider =s.IdentityProvider)
	WHEN MATCHED
		THEN UPDATE SET t.ExternalID = s.ExternalID,
				t.DisplayName = s.DisplayName, 
				t.EmailAddress = s.EmailAddress, 
				t.FirstName = s.FirstName, 
				t.LastName = s.LastName,
				t.PostalCode = s.PostalCode,
				t.IdentityProvider = s.IdentityProvider,
				t.ImageDevice = s.ImageDevice,
				t.ImageCloud = s.ImageCloud,
				t.ImageHash = s.ImageHash,
				t.HasLoggedIn = s.HasLoggedIn,
				t.IsLocked = s.IsLocked,
				t.IsDisabled = s.IsDisabled,
				t.IsDeleted = s.IsDeleted
	WHEN NOT MATCHED BY TARGET 
		THEN INSERT(ExternalID,DisplayName,EmailAddress,FirstName,LastName,
		PostalCode,IdentityProvider,ImageDevice,ImageCloud,ImageHash,HasLoggedIn,
		IsLocked,IsDisabled,IsDeleted)
		VALUES (@ExternalID,@DisplayName,@EmailAddress,@FirstName,
		@LastName,@PostalCode,@IdentityProvider,
		@ImageDevice,@ImageCloud,@ImageHash,@HasLoggedIn,
		@IsLocked,@IsDisabled,@IsDeleted);

	SET @UserProfileId = CAST(SCOPE_IDENTITY() AS INT);




	if (@UserProfileId is not null)
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM BodyOfKnowledge where UserProfileId = @UserProfileId)
		BEGIN
			DECLARE @IdentityValue INT
			BEGIN
			INSERT INTO [dbo].[BodyOfKnowledge](UserProfileId,Name)
				 VALUES (@UserProfileId ,'Default');

			SET @IdentityValue = CAST(SCOPE_IDENTITY() AS INT);

			INSERT INTO [dbo].[LearningStrategies](BodyOfKnowledgeId, Name)
			VALUES (@IdentityValue,'Default')
			END
		END

		SELECT Originator
		FROM UserProfiles UP 
		WHERE UP.UserProfileId = @UserProfileId
	END
	ELSE
	BEGIN
		SELECT Originator
		FROM UserProfiles UP 
		WHERE UP.ExternalID= @ExternalID
	END




END
RETURN