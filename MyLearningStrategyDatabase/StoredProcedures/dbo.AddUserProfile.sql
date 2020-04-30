CREATE PROCEDURE [dbo].[AddUserProfile]
	@ExternalID  NVARCHAR (450),
	@DisplayName  NVARCHAR (256) NULL,
	@EmailAddress NVARCHAR (500) NULL,
	@FirstName    NVARCHAR (256) NULL,
	@LastName     NVARCHAR (256) NULL,
	@PostalCode   NCHAR(10) NULL, 
	@IdentityProvider NVARCHAR(2083), 
	@ImageDevice  NVARCHAR(256) NULL, 
	@ImageCloud   NVARCHAR(2083) NULL,
	@ImageHash   INT NULL, 
	@HasLoggedIn BIT NULL,
	@IsLocked    BIT NULL, 
	@IsDisabled  BIT NULL, 
	@IsDeleted   BIT NULL
AS	

DECLARE @Originator uniqueidentifier

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
				t.IsDeleted = s.IsDeleted,
				t.LastModifiedOffset=SYSDATETIMEOFFSET()
	WHEN NOT MATCHED BY TARGET 
		THEN INSERT(ExternalID,DisplayName,EmailAddress,FirstName,LastName,
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