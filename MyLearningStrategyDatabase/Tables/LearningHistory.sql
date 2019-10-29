CREATE TABLE [dbo].[LearningHistory]
(
	[StrategyHistoryId] INT IDENTITY (1, 1) NOT NULL , 
    [StrategyId] INT NOT NULL, 
	[BodyOfKnowledgeId] INT NOT NULL, 
	[Name] NVARCHAR(150) NOT NULL, 
    [Description] NVARCHAR(256) NULL, 
    [SortRuleId] INT NULL DEFAULT 0, 
	[QuestionSelection] INT NOT NULL DEFAULT 0, 
	[ResponseSelection] INT NOT NULL DEFAULT 0,  
	[OnlyCorrect] BIT NOT NULL DEFAULT 0, 
	[RecycleIncorrectlyAnswered] BIT NOT NULL DEFAULT 0, 
	[FirstLearningRunDate] DATETIME NOT NULL DEFAULT SYSDATETIME(),
	[NumberOfTimesTried] INT NOT NULL DEFAULT 0, 
    [LastQuestionId] INT NULL, 
    [LastModifiedOffset] DATETIMEOFFSET NULL DEFAULT SYSDATETIMEOFFSET(), 
    [CloudRowId] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
    CONSTRAINT [PK_LearningHistory] PRIMARY KEY ([BodyOfKnowledgeId], [StrategyHistoryId], [StrategyId]), 
)
