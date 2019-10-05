--UPDATE [dbo].[LearningStrategies] 
--SET [Description] ='Default'
--WHERE [Description] IS NULL;

--GO
--UPDATE [dbo].[LearningStrategies] 
--SET [Name] ='Default'
--WHERE [Name] IS NULL;
IF OBJECT_ID (N'LearningStrategies',N'U') IS NOT NULL
BEGIN
	DELETE FROM [LearningStrategies]
	DROP TABLE [LearningStrategies]
END 
GO
UPDATE [dbo].[BodyOfKnowledge]
SET [Name] = 'Default'
WHERE [Name] IS NULL;
GO
