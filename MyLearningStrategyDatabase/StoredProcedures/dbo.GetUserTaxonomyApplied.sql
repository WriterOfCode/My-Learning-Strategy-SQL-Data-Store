CREATE PROCEDURE [dbo].[dbo.GetUserTaxonomyApplied]
	@BodyOfKnowledgeId INT NULL,
	@TaxonomyId INT NULL
AS
IF (@BodyOfKnowledgeId IS NULL)
BEGIN
	RAISERROR (15600, 17,-1, 'GetUserTaxonomyApplied.@BodyOfKnowledgeId');   
END
	IF(@TaxonomyId IS NULL)
	BEGIN
		SELECT AppliedTaxonomyId,TaxonomyId,BodyOfKnowledgeId
		FROM [dbo].[TaxonomyApplied]
		WHERE BodyOfKnowledgeId = @BodyOfKnowledgeId
	END
	ELSE
	BEGIN
		SELECT AppliedTaxonomyId,TaxonomyId,BodyOfKnowledgeId 
		FROM  [dbo].[TaxonomyApplied]
		WHERE BodyOfKnowledgeId = @BodyOfKnowledgeId
		AND TaxonomyId = @TaxonomyId 
	END
RETURN 0
