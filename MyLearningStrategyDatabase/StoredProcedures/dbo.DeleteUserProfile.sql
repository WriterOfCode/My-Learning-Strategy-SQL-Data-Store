CREATE PROCEDURE [dbo].[DeleteUserProfile]
	@Originator UNIQUEIDENTIFIER
AS
IF (@Originator IS NULL)
BEGIN
	RAISERROR (15600, 17,-1, 'GetUserLPTableOfContent.@Originator');   
END


	DELETE UserProfiles 
	WHERE Originator = @Originator; 

RETURN 0
