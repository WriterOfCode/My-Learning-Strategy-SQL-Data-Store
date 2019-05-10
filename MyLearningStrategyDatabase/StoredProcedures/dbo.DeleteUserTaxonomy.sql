CREATE PROCEDURE [dbo].[DeleteUserTaxonomy]
	@BodyOfKnowledgeId INT,
	@TaxonomyId INT NULL,
	@Originator UNIQUEIDENTIFIER
AS

	IF (@Originator IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, 'GetUserLPTableOfContent.@Originator');   
	END

	IF ([dbo].[IsBokOriginator](@Originator,@BodyOfKnowledgeId)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END

	IF (@BodyOfKnowledgeId IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, 'DeleteUserTaxonomy.@BodyOfKnowledgeId');   
	END

	IF(@TaxonomyId IS NOT NULL)
	BEGIN
		DELETE
		FROM  [dbo].[Taxonomy]
		WHERE BodyOfKnowledgeId = @BodyOfKnowledgeId
		AND TaxonomyId = @TaxonomyId
	END
	ELSE
	BEGIN
		DELETE
		FROM  [dbo].[Taxonomy]
		WHERE BodyOfKnowledgeId = @BodyOfKnowledgeId
	END


RETURN 0