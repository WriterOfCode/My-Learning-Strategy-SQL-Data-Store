CREATE TABLE [dbo].[LearningPlanContent]
(
	[LearningContentId] INT IDENTITY (1, 1) NOT NULL , 
    [TableOfContentId] INT NOT NULL, 
	[OrderBy] INT NOT NULL DEFAULT 0, 
    [Heading] NVARCHAR(50) NULL, 
    [LearningContent] NVARCHAR(MAX) NULL, 
    [ImageUrl] VARCHAR(2083) NULL, 
    [Hyperlink_1] VARCHAR(2083) NULL, 
    [Hyperlink_2] VARCHAR(2083) NULL, 
    [Hyperlink_3] VARCHAR(2083) NULL, 
    CONSTRAINT [FK_LearningContent_TableOfContents] FOREIGN KEY ([TableOfContentId]) REFERENCES [LearningPlanTableOfContents]([TableOfContentId]), 
    CONSTRAINT [PK_LearningContent] PRIMARY KEY NONCLUSTERED ([LearningContentId]) 
)

GO

CREATE INDEX [IX_LearningPlanContent_TableOfContent] ON [dbo].[LearningPlanContent] ([LearningContentId],[TableOfContentId])
