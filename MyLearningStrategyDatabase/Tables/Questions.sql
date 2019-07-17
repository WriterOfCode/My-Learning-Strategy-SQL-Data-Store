CREATE TABLE [dbo].[Questions]
(
	[QuestionId] INT IDENTITY (1, 1) NOT NULL , 
    [BodyOfKnowledgeId] INT NOT NULL, 
	[OrderBy] INT NOT NULL DEFAULT 1, 
    [Question] NVARCHAR(4000) NULL, 
	[Image_1_Device] NVARCHAR(256) NULL, 
	[Image_1_Cloud] NVARCHAR(2083) NULL, 
	[Image_1_Hash] INT NULL, 
	[Image_2_Device] NVARCHAR(256) NULL, 
	[Image_2_Cloud] NVARCHAR(2083) NULL, 
	[Image_2_Hash] INT NULL, 
	[Image_3_Device] NVARCHAR(256) NULL, 
	[Image_3_Cloud] NVARCHAR(2083) NULL, 
	[Image_3_Hash] INT NULL, 
	[Hyperlink_1] VARCHAR(2083) NULL, 
    [Hyperlink_2] VARCHAR(2083) NULL, 
    [Hyperlink_3] VARCHAR(2083) NULL, 
	[Mnemonic] NVARCHAR(300) NULL, 
	[LastModifiedOffset] DATETIMEOFFSET NULL DEFAULT SYSDATETIMEOFFSET(), 
    [CloudRowId] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), 
    CONSTRAINT [PK_Questions] PRIMARY KEY NONCLUSTERED ([QuestionId]),
	CONSTRAINT [FK_Questions_BodyOfKnowledge] FOREIGN KEY ([BodyOfKnowledgeId]) REFERENCES [BodyOfKnowledge]([BodyOfKnowledgeId])
)

GO

CREATE INDEX [IX_Questions_OrderBy] ON [dbo].[Questions] ([OrderBy])

GO

CREATE CLUSTERED INDEX [IX_Questions_BodyOfKnowledgeId] ON [dbo].[Questions] ([BodyOfKnowledgeId])

GO