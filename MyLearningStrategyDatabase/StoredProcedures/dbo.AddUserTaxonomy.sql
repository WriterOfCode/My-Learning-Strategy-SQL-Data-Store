CREATE PROCEDURE [dbo].[AddUserTaxonomy]
	@BodyOfKnowledgeId INT NULL,
	@Originator UNIQUEIDENTIFIER,
	@ParentId INT NULL,
	@TaxonomyName NVARCHAR(50) NULL,
    @ImageUrl NVARCHAR(2083) NULL,
	@LastModifiedOffset DATETIMEOFFSET NULL

AS
	DECLARE @TaxonomyId INT;

	IF (@BodyOfKnowledgeId IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, '[AddUserTaxonomy].@BodyOfKnowledgeId');   
	END

	IF ([dbo].[IsBokOriginator](@Originator,@BodyOfKnowledgeId)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END

	BEGIN
		INSERT INTO [dbo].[Taxonomy] (ParentId,BodyOfKnowledgeId,TaxonomyName,ImageUrl,LastModifiedOffset )
		VALUES(@ParentId,@BodyOfKnowledgeId,@TaxonomyName,@ImageUrl,@LastModifiedOffset );

		SELECT CAST(SCOPE_IDENTITY() AS INT) AS TaxonomyId;
	END

RETURN @TaxonomyId
