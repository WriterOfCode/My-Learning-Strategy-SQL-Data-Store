CREATE TABLE [dbo].[LearningStrategies]
(
	[StrategyId] INT IDENTITY (1, 1) NOT NULL , 
    [BodyOfKnowledgeId] INT NOT NULL, 
	[Name] NVARCHAR(150) NULL,
    [Description] NVARCHAR(256) NOT NULL, 
    [SortRuleId] INT NULL DEFAULT 0, 
    [QuestionRandom] BIT NULL DEFAULT 0, 
    [QuestionMax] INT NULL DEFAULT 0, 
    [QuestionMin] INT NULL DEFAULT 0, 
    [ResponseRandom] BIT NULL DEFAULT 0, 
    [ResponseMax] INT NULL DEFAULT 0 , 
    [ResponseMin] INT NULL DEFAULT 0, 
    [ResponseMinCorrect] INT NULL DEFAULT 0, 
    [ResponseMaxCorrect] INT NULL DEFAULT 0, 
    [LastModifiedOffset] DATETIMEOFFSET NULL DEFAULT SYSDATETIMEOFFSET(), 
    [CloudRowId] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), 
    CONSTRAINT [PK_LearningStrategies] PRIMARY KEY ([StrategyId], [BodyOfKnowledgeId]), 
)
