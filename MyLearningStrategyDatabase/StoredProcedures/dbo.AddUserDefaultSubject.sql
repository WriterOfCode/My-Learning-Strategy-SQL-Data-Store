CREATE PROCEDURE [dbo].[AddUserDefaultSubject]
	@UserProfileId int
AS
		DECLARE @IdentityValue INT
		IF NOT EXISTS (SELECT 1 FROM BodyOfKnowledge where UserProfileId = @UserProfileId)
		BEGIN
			
				INSERT INTO [dbo].[BodyOfKnowledge](UserProfileId,Name)
					 VALUES (@UserProfileId ,'Default');

				SET @IdentityValue = CAST(SCOPE_IDENTITY() AS INT);

				INSERT INTO [dbo].[Strategies](UserProfileId, Name)
				VALUES (@UserProfileId,'Default')

		END
		IF NOT EXISTS (SELECT 1 FROM Strategies where UserProfileId = @UserProfileId)
		BEGIN
			INSERT INTO [dbo].[Strategies](UserProfileId, Name)
			VALUES (@UserProfileId,'Default')
			
		END
RETURN @IdentityValue