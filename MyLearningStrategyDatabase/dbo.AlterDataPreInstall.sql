--UPDATE [dbo].[LearningStrategies] 
--SET [Description] ='Default'
--WHERE [Description] IS NULL;

--GO
--UPDATE [dbo].[LearningStrategies] 
--SET [Name] ='Default'
--WHERE [Name] IS NULL;
--IF OBJECT_ID (N'LearningStrategies',N'U') IS NOT NULL
--BEGIN
--	DELETE FROM [LearningStrategies]
--	DROP TABLE [LearningStrategies]
--END 
--GO
--UPDATE [dbo].[BodyOfKnowledge]
--SET [Name] = 'Default'
--WHERE [Name] IS NULL;
--GO


/****** Object:  Table [dbo].[CategoriesBodyOfKnowledge]    Script Date: 11/16/2019 11:33:23 PM ******/
DROP TABLE [dbo].[CategoriesBodyOfKnowledge]
GO

DROP TABLE [dbo].[CategoriesQuestions]
GO
