﻿CREATE PROCEDURE [dbo].[GetUserLPContentSeletions]
	@LearningPlanContentSelectionsId INT NULL,
	@LearningPlanDefinitionId int NULL,
	@Originator UNIQUEIDENTIFIER

AS
	DECLARE @LearningPlanDefinitionLookup INT

	IF (@Originator IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, '[AddUserContentSelections].@Originator');   
	END
	IF (@LearningPlanContentSelectionsId IS NULL AND @LearningPlanDefinitionId IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, 'Both [GetUserLPContentSeletions].@LearningPlanDefinitionId and @LearningPlanContentSelectionsId can not be null');   
	END

	IF (@LearningPlanDefinitionId IS NOT NULL)
	BEGIN
  		IF ([dbo].[IsLPDUsers](@Originator,@LearningPlanDefinitionId)=0)
		BEGIN
			RAISERROR (13538,14,-1, 'User is not the owner!');   
		END 
	END
	ELSE 
		BEGIN
			SELECT @LearningPlanDefinitionLookup = MAX(LearningPlanDefinitionId)
			FROM [dbo].[LearningPlanContentSelections]
			WHERE LearningPlanContentSelectionsId = @LearningPlanContentSelectionsId 

			IF (@LearningPlanDefinitionLookup > 0)
			BEGIN
	  			IF ([dbo].[IsLPDUsers](@Originator,@LearningPlanDefinitionLookup)=0)
				BEGIN
					RAISERROR (13538,14,-1, 'User is not the owner!');   
				END 
			END
		END
	
	IF (@LearningPlanContentSelectionsId IS NOT NULL)
	BEGIN
		SELECT 
		LearningPlanContentSelectionsId,
		LearningPlanDefinitionId,
		TableOfContentId,LearningContentId,
		LastModifiedOffset,CloudRowId
		FROM [dbo].[LearningPlanContentSelections]
		WHERE LearningPlanContentSelectionsId = @LearningPlanContentSelectionsId
		AND LearningPlanDefinitionId = @LearningPlanDefinitionId
	END
	ELSE
	BEGIN
		SELECT 
		LearningPlanContentSelectionsId,
		LearningPlanDefinitionId,
		TableOfContentId,LearningContentId,
		LastModifiedOffset,CloudRowId
		FROM [dbo].[LearningPlanContentSelections]
		WHERE LearningPlanDefinitionId = @LearningPlanDefinitionId
	END
RETURN 0
