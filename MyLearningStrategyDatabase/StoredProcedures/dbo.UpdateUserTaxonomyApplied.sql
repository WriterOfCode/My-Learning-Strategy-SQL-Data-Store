CREATE PROCEDURE [dbo].[UpdateUserTaxonomyApplied]
    @AppliedTaxonomyId INT NULL, 
	@TaxonomyId INT NULL,
    @BodyOfKnowledgeId INT NULL,
	@LastModifiedOffset DATETIMEOFFSET NULL, 
	@UserProfileId INT 
AS

IF (@BodyOfKnowledgeId IS NULL)
BEGIN
	RAISERROR (15600, 17,-1, '[UpdateUserTaxonomyApplied].@BodyOfKnowledgeId');   
END
IF ([dbo].[IsBokUsers](@UserProfileId,@BodyOfKnowledgeId) != 1)
BEGIN
	RAISERROR (13538,14,-1, 'User is not the owner!');   
END
	DECLARE @rowsaffected INT 
	BEGIN
		UPDATE [dbo].[TaxonomyApplied] 
		SET TaxonomyId =@TaxonomyId,
		LastModifiedOffset=@LastModifiedOffset
		WHERE AppliedTaxonomyId=@AppliedTaxonomyId
		AND BodyOfKnowledgeId=@BodyOfKnowledgeId;

		SET @rowsaffected = @@ROWCOUNT
	END
RETURN @rowsaffected
