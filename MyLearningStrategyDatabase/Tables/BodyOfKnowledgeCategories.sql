CREATE TABLE [dbo].[BodyOfKnowledgeCategories]
(
    [BodyOfKnowledgeId] INT NOT NULL,
	[CategoryId] INT NOT NULL,
	[UserProfileId] INT NOT NULL,
	[LastModifiedOffset] DATETIMEOFFSET NULL DEFAULT SYSDATETIMEOFFSET(), 
    [CloudRowId] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), 
    [Id] INT NOT NULL IDENTITY, 
    CONSTRAINT [PK_BokCategories] PRIMARY KEY ([UserProfileId], [BodyOfKnowledgeId], [CategoryId]), 
    CONSTRAINT [FK_BokCategories_ToBok] FOREIGN KEY ([BodyOfKnowledgeId]) REFERENCES [BodyOfKnowledge]([BodyOfKnowledgeId]), 
    CONSTRAINT [FK_BokCategories_ToCategories] FOREIGN KEY ([CategoryId],[UserProfileId]) REFERENCES [Categories]([CategoryId],[UserProfileId])
)
