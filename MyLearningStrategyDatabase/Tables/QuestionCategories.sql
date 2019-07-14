CREATE TABLE [dbo].[QuestionCategories]
(
    [QuestionId] INT NOT NULL, 
    [CategoryId] INT NOT NULL,
	[UserProfileId] INT NOT NULL,
	[LastModifiedOffset] DATETIMEOFFSET NULL DEFAULT SYSDATETIMEOFFSET(), 
    [CloudRowId] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), 
    CONSTRAINT [PK_QuestionCategories] PRIMARY KEY ([UserProfileId], [QuestionId], [CategoryId]), 
    CONSTRAINT [FK_QuestionCategories_ToQuestion] FOREIGN KEY ([QuestionId]) REFERENCES [Questions]([QuestionId]),
	CONSTRAINT [FK_QuestionCategories_ToCategories] FOREIGN KEY ([CategoryId],[UserProfileId]) REFERENCES [Categories]([CategoryId],[UserProfileId])
)
