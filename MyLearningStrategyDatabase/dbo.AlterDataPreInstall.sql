UPDATE [dbo].[LearningStrategies] 
SET [Description] =''
WHERE [Description] IS NULL;
GO
UPDATE [dbo].[LearningStrategies] 
SET [Name] =''
WHERE [Name] IS NULL;
GO