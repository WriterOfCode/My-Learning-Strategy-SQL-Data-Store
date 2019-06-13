CREATE TABLE [dbo].[UserProfiles] (
    [UserProfileId] INT IDENTITY (1, 1) NOT NULL,
	[ExternalID]  NVARCHAR (450) NULL,
	[DisplayName]  NVARCHAR (256) NULL,
    [EmailAddress]       NVARCHAR (500) NULL,
    [FirstName]   NVARCHAR (256) NULL,
    [LastName]    NVARCHAR (256) NULL,
    [PostalCode] NCHAR(10) NULL, 
    [IdentityProvider] NVARCHAR(2083) NULL, 
	[Originator]  UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), 
	[ImageUrl]    NVARCHAR(2083) NULL, 
	[HasLoggedIn] BIT            NULL DEFAULT 0,
    [IsLocked]    BIT NULL DEFAULT 0, 
    [IsDisabled]  BIT NULL DEFAULT 0, 
    [IsDeleted] BIT NULL DEFAULT 0, 
	[LastModifiedOffset] DATETIMEOFFSET NULL, 
    CONSTRAINT [PK_UserProfiles] PRIMARY KEY NONCLUSTERED ([UserProfileId] ASC)
);
GO

CREATE UNIQUE CLUSTERED INDEX [IX_UserProfiles_ExternalId] ON [dbo].[UserProfiles] ([UserProfileId],[ExternalID],[Originator])
