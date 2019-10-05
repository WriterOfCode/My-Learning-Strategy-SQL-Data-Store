﻿CREATE TABLE [dbo].[Strategies]
(
	[StrategyId] INT IDENTITY (1, 1) NOT NULL , 
    [UserProfileId] INT NOT NULL, 
	[Name] NVARCHAR(150) NOT NULL,
    [Description] NVARCHAR(256) NOT NULL,
    [SortRuleId] INT NOT NULL DEFAULT 0, 
    [QuestionRandom] BIT NOT NULL DEFAULT 0, 
    [QuestionMax] INT NOT NULL DEFAULT 0, 
    [QuestionMin] INT NOT NULL DEFAULT 0, 
    [ResponseRandom] BIT NOT NULL DEFAULT 0, 
    [ResponseMax] INT NOT NULL DEFAULT 0 , 
    [ResponseMin] INT NOT NULL DEFAULT 0, 
    [ResponseMinCorrect] INT NOT NULL DEFAULT 0, 
    [ResponseMaxCorrect] INT NOT NULL DEFAULT 0, 
	[OnlyCorrect] BIT NOT NULL DEFAULT 1,
	[RecycleIncorrectlyAnswered] BIT NOT NULL DEFAULT 0, 
    [LastModifiedOffset] DATETIMEOFFSET NOT NULL DEFAULT SYSDATETIMEOFFSET(), 
    [CloudRowId] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), 
    CONSTRAINT [PK_Strategies] PRIMARY KEY ([StrategyId], [UserProfileId]), 
)
