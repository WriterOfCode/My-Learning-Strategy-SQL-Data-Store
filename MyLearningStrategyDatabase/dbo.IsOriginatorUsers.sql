CREATE FUNCTION [dbo].[IsOriginatorUsers]
(
	@UserProfileId int,
	@Originator uniqueidentifier
)
RETURNS INT
AS
BEGIN
	DECLARE @bokCount INT

	--INSERT INTO @bokCount
	SELECT @bokCount = COUNT(*)
	FROM [UserProfiles]
	WHERE UserProfileId = @UserProfileId
	AND Originator = @Originator;

	RETURN @bokCount
END
