CREATE TABLE [dbo].[Libraries]
(
	[LibraryId] INT NOT NULL IDENTITY, 
	[UserProfileId] INT NOT NULL,
    [Name] NVARCHAR(150) NULL, 
    [Acronym] NVARCHAR(50) NULL, 
    [Keywords] NVARCHAR(100) NULL, 
    [IsShared] BIT NULL DEFAULT 0, 
    [HasBeenShared] BIT NULL DEFAULT 0, 
	[LastModifiedOffset] DATETIMEOFFSET NULL, 
    [CloudRowId] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), 
    CONSTRAINT [FK_Libraries_UserProfiles] FOREIGN KEY ([UserProfileId]) REFERENCES [UserProfiles]([UserProfileId]), 
    CONSTRAINT [PK_Libraries] PRIMARY KEY NONCLUSTERED ([LibraryId]) 
)

GO


CREATE UNIQUE CLUSTERED INDEX [IX_BodyOfKnowledge_UserProfileId] ON [dbo].[Libraries] ([BodyOfKnowledgeId],[UserProfileId])

GO
