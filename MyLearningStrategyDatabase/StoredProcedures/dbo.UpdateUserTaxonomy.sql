CREATE PROCEDURE [dbo].[UpdateUserTaxonomy]
	@TaxonomyId INT,
	@ParentId INT NULL,
	@BodyOfKnowledgeId INT,
	@TaxonomyName NVARCHAR(50) NULL,
    @ImageUrl NVARCHAR(2083) NULL,
	@LastModifiedOffset DATETIMEOFFSET NULL,
	@Originator UNIQUEIDENTIFIER
AS

	DECLARE @rowsaffected INT 

	IF (@BodyOfKnowledgeId IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, '[UpdateUserTaxonomy].@BodyOfKnowledgeId');   
	END
	IF ([dbo].[IsBokOriginator](@Originator,@BodyOfKnowledgeId)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END

	BEGIN
		UPDATE [dbo].[Taxonomy] 
		SET ParentId=@ParentId,
		TaxonomyName=@TaxonomyName,
		ImageUrl=@ImageUrl,
		LastModifiedOffset=@LastModifiedOffset
		WHERE TaxonomyId = @TaxonomyId
		AND BodyOfKnowledgeId=@BodyOfKnowledgeId;
		
		SET @rowsaffected = @@ROWCOUNT
	END
RETURN @rowsaffected
