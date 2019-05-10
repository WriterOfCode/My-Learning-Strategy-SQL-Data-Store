CREATE PROCEDURE [dbo].[GetUserProfile]
	@ExternalID NVARCHAR(450) NULL,
	@Originator UNIQUEIDENTIFIER NULL
AS
IF (@ExternalID IS NULL AND @Originator IS NULL)
BEGIN
	RAISERROR (15600, 17,-1, 'Both GetUserProfile profile pramiters can not be null');   
END

IF (@Originator IS NOT NULL)
	BEGIN
		SELECT DisplayName,EmailAddress
		,FirstName,LastName,PostalCode,Originator
		,ImageUrl,HasLoggedIn,IsLocked,IsDisabled
		FROM UserProfiles 
		WHERE Originator = @Originator;
	END
ELSE IF (@ExternalID IS NOT NULL)
	BEGIN
		SELECT DisplayName,EmailAddress
		,FirstName,LastName,PostalCode,Originator
		,ImageUrl,HasLoggedIn,IsLocked,IsDisabled
		FROM UserProfiles 
		WHERE ExternalID = @ExternalID;
	END
RETURN
