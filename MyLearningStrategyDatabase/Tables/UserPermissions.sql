CREATE TABLE [dbo].[UserPermissions] (
    [PermissionsId] INT IDENTITY (1, 1) NOT NULL,
    [UserProfileId] INT NOT NULL,
	[ClaimType]     NVARCHAR (250) NOT NULL,
    [ClaimValue]    NVARCHAR (250) NOT NULL,
    CONSTRAINT [FK_UserPermissions_UserProfiles] FOREIGN KEY ([UserProfileId]) REFERENCES [UserProfiles]([UserProfileId]), 
    CONSTRAINT [PK_UserPermissions] PRIMARY KEY ([PermissionsId], [UserProfileId])
);
GO


CREATE UNIQUE INDEX [IX_UserPermissions_UniqueClaim] ON [dbo].[UserPermissions] ([UserProfileId], [ClaimType], [ClaimValue])
