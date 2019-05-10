CREATE TABLE [dbo].[Taxonomy](
	[TaxonomyId] INT IDENTITY (1, 1) NOT NULL,
	[ParentId] INT NULL,
	[BodyOfKnowledgeId] INT NOT NULL,
	[TaxonomyName] [nvarchar](50) NOT NULL,
    [ImageUrl] NVARCHAR(2083) NULL, 
    CONSTRAINT [FK_Taxonomy_BodyOfKnowledge] FOREIGN KEY ([BodyOfKnowledgeId]) REFERENCES [BodyOfKnowledge]([BodyOfKnowledgeId]), 
    CONSTRAINT [PK_Taxonomy] PRIMARY KEY ([TaxonomyId]), 
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Taxonomy] ADD CONSTRAINT [FK_SelfRefTaxonomy] FOREIGN KEY ([ParentId]) REFERENCES [dbo].[Taxonomy] ([TaxonomyId]) 
GO


CREATE INDEX [IX_BOK] ON [dbo].[Taxonomy] ([BodyOfKnowledgeId],[TaxonomyId])
GO
