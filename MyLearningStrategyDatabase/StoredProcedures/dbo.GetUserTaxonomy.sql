CREATE PROCEDURE [dbo].[GetUserTaxonomy]
	@BodyOfKnowledgeId INT,
	@TaxonomyId INT NULL,
	@Originator UNIQUEIDENTIFIER
AS
	IF (@BodyOfKnowledgeId IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, 'GetUserTaxonomy.@BodyOfKnowledgeId');   
	END
	IF ([dbo].[IsBokOriginator](@Originator,@BodyOfKnowledgeId)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END

	IF(@TaxonomyId IS NOT NULL)
	BEGIN
		SELECT 
		[TaxonomyId],
		[ParentId],
		[BodyOfKnowledgeId],
		[TaxonomyName],
		[ImageUrl]
		FROM  [dbo].[Taxonomy]
		WHERE BodyOfKnowledgeId = @BodyOfKnowledgeId
		AND TaxonomyId = @TaxonomyId
	END
	ELSE
	BEGIN
		SELECT 
		[TaxonomyId],
		[ParentId],
		[BodyOfKnowledgeId],
		[TaxonomyName],
		[ImageUrl]
		FROM  [dbo].[Taxonomy]
		WHERE BodyOfKnowledgeId = @BodyOfKnowledgeId
	END


RETURN 0
