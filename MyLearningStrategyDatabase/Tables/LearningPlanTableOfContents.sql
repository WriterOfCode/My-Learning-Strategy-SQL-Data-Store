CREATE TABLE [dbo].[LearningPlanTableOfContents]
(
	[TableOfContentId] INT IDENTITY (1, 1) NOT NULL ,
	[BodyOfKnowledgeId] INT NOT NULL ,
	[AppliedTaxonomyId] INT NULL ,
	[OrderBy] INT NOT NULL, 
    [Heading] NVARCHAR(50) NOT NULL, 
    CONSTRAINT [FK_TableOfContents_BodyOfKnowledge] FOREIGN KEY ([BodyOfKnowledgeId]) REFERENCES [BodyOfKnowledge]([BodyOfKnowledgeId]), 
    CONSTRAINT [PK_TableOfContents] PRIMARY KEY ([TableOfContentId]), 
    CONSTRAINT [FK_LearningTableOfContents_TaxonomyApplied] FOREIGN KEY ([AppliedTaxonomyId]) REFERENCES [Taxonomy]([TaxonomyId])
)

GO

CREATE INDEX [IX_TableOfContents_TriColumn] ON [dbo].[LearningPlanTableOfContents] ([TableOfContentId],[BodyOfKnowledgeId],[AppliedTaxonomyId])
