CREATE TABLE [dbo].[BodyOfKnowledge]
(
	[BodyOfKnowledgeId] INT NOT NULL IDENTITY, 
	[UserProfileId] INT NOT NULL,
    [Name] NVARCHAR(150) NULL, 
    [Acronym] NVARCHAR(50) NULL, 
    [Keywords] NVARCHAR(100) NULL, 
	[ImageDevice] NVARCHAR(256) NULL, 
	[ImageCloud] NVARCHAR(2083) NULL,
	[ImageHash] INT NULL, 
    [IsShared] BIT NULL DEFAULT 0, 
    [HasBeenShared] BIT NULL DEFAULT 0, 
	[CategoryAppliedId] INT NULL, 
	[LastModifiedOffset] DATETIMEOFFSET NULL DEFAULT SYSDATETIMEOFFSET(), 
    [CloudRowId] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), 
    CONSTRAINT [FK_BodyOfKnowledge_UserProfiles] FOREIGN KEY ([UserProfileId]) REFERENCES [UserProfiles]([UserProfileId]), 
    CONSTRAINT [PK_BodyOfKnowledge] PRIMARY KEY NONCLUSTERED ([BodyOfKnowledgeId]) 
)

GO


CREATE UNIQUE CLUSTERED INDEX [IX_BodyOfKnowledge_UserProfileId] ON [dbo].[BodyOfKnowledge] ([BodyOfKnowledgeId],[UserProfileId])

GO
