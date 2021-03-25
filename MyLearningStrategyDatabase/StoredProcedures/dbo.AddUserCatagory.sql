﻿CREATE PROCEDURE [dbo].[AddUserCatagory]
	@CategoryName NVARCHAR(100),
	@ImageDevice NVARCHAR(256) NULL, 
	@ImageCloud NVARCHAR(2083) NULL,
	@ImageHash INT NULL,
	@Originator UNIQUEIDENTIFIER
AS

	DECLARE @IdentityValue INT;
	DECLARE @UserProfileId INT
	SET @UserProfileId = [dbo].[OriginatorToUserId](@Originator)
	IF (@UserProfileId is null)
	BEGIN
		RAISERROR (13538,14,-1, 'User not found!');   
	END
	BEGIN
		INSERT INTO [dbo].[Categories](UserProfileId,CategoryName,ImageDevice,ImageCloud,ImageHash )
		VALUES (@UserProfileId,@CategoryName,@ImageDevice,@ImageCloud,@ImageHash);
 
 		SET @IdentityValue = CAST(SCOPE_IDENTITY() AS INT);
	END

RETURN @IdentityValue