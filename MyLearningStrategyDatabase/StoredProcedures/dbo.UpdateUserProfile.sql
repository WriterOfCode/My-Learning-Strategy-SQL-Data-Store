CREATE PROCEDURE [dbo].[UpdateUserProfile]
	@DisplayName  NVARCHAR (256) NULL,
    @EmailAddress       NVARCHAR (500) NULL,
    @FirstName   NVARCHAR (256) NULL,
    @LastName    NVARCHAR (256) NULL,
    @PostalCode NCHAR(10) NULL, 
	@Originator  UNIQUEIDENTIFIER NULL,
	@ImageUrl    NVARCHAR(2083) NULL, 
	@HasLoggedIn BIT NULL,
    @IsLocked    BIT NULL, 
    @IsDisabled  BIT NULL
AS	

DECLARE @rowsaffected INT 
IF (@Originator IS NULL)
BEGIN
	RAISERROR (15600, 17,-1, '[UpdateUserProfile].@Originator');   
END

	UPDATE UserProfiles
	SET DisplayName=@DisplayName,
	EmailAddress=@EmailAddress,
	FirstName=@FirstName,
	LastName=@LastName,
	PostalCode=@PostalCode,
	ImageUrl=@ImageUrl,
	HasLoggedIn=@HasLoggedIn,
	IsLocked=@IsLocked,
	IsDisabled=@IsDisabled
	WHERE Originator =@Originator;
	
	SET @rowsaffected = @@ROWCOUNT
RETURN @rowsaffected
