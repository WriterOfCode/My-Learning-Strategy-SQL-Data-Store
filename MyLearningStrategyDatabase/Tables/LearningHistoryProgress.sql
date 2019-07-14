CREATE TABLE [dbo].[LearningHistoryProgress]
(
	[LearningHistoryProgressId] INT IDENTITY (1, 1) NOT NULL,
	[StrategyHistoryId] INT NOT NULL , 
	[QuestionId] INT NOT NULL , 
	[AnsweredIncorrectlyCount] INT NULL DEFAULT 0 , 
	[AnsweredCorrectlyCount] INT NULL DEFAULT 0, 
    CONSTRAINT [PK_LearningHistoryProgress] PRIMARY KEY ([LearningHistoryProgressId], [StrategyHistoryId], [QuestionId]) , 
)
