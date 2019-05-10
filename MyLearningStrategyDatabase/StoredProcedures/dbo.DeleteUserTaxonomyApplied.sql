CREATE PROCEDURE [dbo].[DeleteUserTaxonomyApplied]
	@BodyOfKnowledgeId INT NULL,
	@UserProfileId INT,
	@AppliedTaxonomyId INT NULL

AS

IF (@BodyOfKnowledgeId IS NULL)
BEGIN
	RAISERROR (15600, 17,-1, 'GetUserTaxonomyApplied.@BodyOfKnowledgeId');   
END
IF (@UserProfileId IS NULL)
BEGIN
	RAISERROR (15600, 17,-1, 'GetUserLPTableOfContent.@UserProfileId');   
END
IF ([dbo].[IsBokUsers](@UserProfileId,@BodyOfKnowledgeId) != 1)
BEGIN
	RAISERROR (13538,14,-1, 'User is not the owner!');   
END

	IF(@AppliedTaxonomyId IS NULL)
	BEGIN
		BEGIN TRANSACTION AppliedBOK;
		BEGIN TRY
			UPDATE [dbo].[Questions]
			SET AppliedTaxonomyId = NULL
			WHERE BodyOfKnowledgeId = @BodyOfKnowledgeId

			DELETE
			FROM [dbo].[TaxonomyApplied]
			WHERE BodyOfKnowledgeId = @BodyOfKnowledgeId
		END TRY
		BEGIN CATCH

		IF @@TRANCOUNT>0
			ROLLBACK TRANSACTION AppliedBOK;
		END CATCH;
		IF @@TRANCOUNT>0
		COMMIT TRANSACTION AppliedBOK;
	END
	ELSE
	BEGIN
		BEGIN TRANSACTION AppliedBOK;
		BEGIN TRY
			UPDATE [dbo].[Questions]
			SET AppliedTaxonomyId = NULL
			WHERE BodyOfKnowledgeId = @BodyOfKnowledgeId
			AND AppliedTaxonomyId = @AppliedTaxonomyId  

			DELETE
			FROM [dbo].[TaxonomyApplied]
			WHERE BodyOfKnowledgeId = @BodyOfKnowledgeId
			AND AppliedTaxonomyId = @AppliedTaxonomyId  
		END TRY
		BEGIN CATCH

		IF @@TRANCOUNT>0
			ROLLBACK TRANSACTION AppliedBOK;
		END CATCH;
		IF @@TRANCOUNT>0
		COMMIT TRANSACTION AppliedBOK;
	END
RETURN 0