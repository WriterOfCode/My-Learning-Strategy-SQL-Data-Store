CREATE TABLE [dbo].[BodyOfKnowledge]
(
	[BodyOfKnowledgeId] INT NOT NULL IDENTITY, 
	[UserProfileId] INT NOT NULL,
    [Name] NVARCHAR(50) NULL, 
    [Acronym] NVARCHAR(20) NULL, 
    [Keywords] NVARCHAR(MAX) NULL, 
    [IsShared] BIT NOT NULL DEFAULT 0, 
    [HasBeenShared] BIT NOT NULL DEFAULT 0, 
    CONSTRAINT [FK_BodyOfKnowledge_UserProfiles] FOREIGN KEY ([UserProfileId]) REFERENCES [UserProfiles]([UserProfileId]), 
    CONSTRAINT [PK_BodyOfKnowledge] PRIMARY KEY NONCLUSTERED ([BodyOfKnowledgeId]) 
)

GO


CREATE UNIQUE CLUSTERED INDEX [IX_BodyOfKnowledge_UserProfileId] ON [dbo].[BodyOfKnowledge] ([BodyOfKnowledgeId],[UserProfileId])

GO
