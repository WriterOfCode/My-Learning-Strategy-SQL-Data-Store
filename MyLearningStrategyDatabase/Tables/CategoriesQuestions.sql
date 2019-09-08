CREATE TABLE [dbo].[CategoriesQuestions]
(
    [CategoryCloudRowId] UNIQUEIDENTIFIER NOT NULL ,
    [QuestionCloudRowId] UNIQUEIDENTIFIER NOT NULL, 
	[Originator] UNIQUEIDENTIFIER NOT NULL, 
    [LastModifiedOffset] DATETIMEOFFSET NOT NULL DEFAULT SYSDATETIMEOFFSET(), 
    [CloudRowId] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), 
    CONSTRAINT [PK_CategoriesQuestions] PRIMARY KEY ([QuestionCloudRowId], [CategoryCloudRowId])
)