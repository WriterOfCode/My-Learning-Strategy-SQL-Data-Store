CREATE TABLE [dbo].[TaxonomyApplied]
(
	[AppliedTaxonomyId] INT IDENTITY (1, 1) NOT NULL, 
    [TaxonomyId] INT NOT NULL, 
    [BodyOfKnowledgeId] INT NOT NULL, 
	[LastModifiedOffset] DATETIMEOFFSET NULL, 
    [CloudRowId] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), 
    CONSTRAINT [FK_TaxonomyApplied_Taxonomy] FOREIGN KEY ([TaxonomyId]) REFERENCES [Taxonomy]([TaxonomyId]), 
    CONSTRAINT [PK_TaxonomyApplied] PRIMARY KEY ([AppliedTaxonomyId], [BodyOfKnowledgeId]) 
)

GO


CREATE INDEX [IX_TaxonomyAppliedUnique] ON [dbo].[TaxonomyApplied] ([AppliedTaxonomyId],[TaxonomyId])
