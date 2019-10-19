CREATE TABLE [dbo].[Strategies]
(
	[StrategyId] INT IDENTITY (1, 1) NOT NULL , 
    [UserProfileId] INT NOT NULL, 
	[Name] NVARCHAR(150) NOT NULL,
    [Description] NVARCHAR(256) NOT NULL,
	[SortRuleId] INT NOT NULL DEFAULT 0, 
	[QuestionSelection] INT NOT NULL DEFAULT 0, 
	[ResponseSelection] INT NOT NULL DEFAULT 0,  
	[RecycleIncorrectlyAnswered] BIT NOT NULL DEFAULT 0, 
    [LastModifiedOffset] DATETIMEOFFSET NOT NULL DEFAULT SYSDATETIMEOFFSET(), 
    [CloudRowId] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), 
    CONSTRAINT [PK_Strategies] PRIMARY KEY ([StrategyId], [UserProfileId]), 
)
