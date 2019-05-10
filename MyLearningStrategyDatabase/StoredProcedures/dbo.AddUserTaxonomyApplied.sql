CREATE PROCEDURE [dbo].[AddUserTaxonomyApplied]
    @BodyOfKnowledgeId INT NULL,
	@UserProfileId INT,
	@TaxonomyId INT NULL
AS
IF (@BodyOfKnowledgeId IS NULL)
BEGIN
	RAISERROR (15600, 17,-1, '[AddUserTaxonomyApplied].@BodyOfKnowledgeId');   
END
IF ([dbo].[IsBokUsers](@UserProfileId,@BodyOfKnowledgeId) != 1)
BEGIN
	RAISERROR (13538,14,-1, 'User is not the owner!');   
END
	DECLARE @AppliedTaxonomyId INT;
	BEGIN
		INSERT INTO [dbo].[TaxonomyApplied] (TaxonomyId,BodyOfKnowledgeId)
		VALUES (@TaxonomyId,@BodyOfKnowledgeId)
		SET @AppliedTaxonomyId = CAST(SCOPE_IDENTITY() AS INT)
	END
RETURN @AppliedTaxonomyId
