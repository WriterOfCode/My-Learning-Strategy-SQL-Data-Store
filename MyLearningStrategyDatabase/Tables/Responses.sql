CREATE TABLE [dbo].[Responses]
(
	[ResponseId] INT IDENTITY (1, 1) NOT NULL , 
    [QuestionId] INT NOT NULL, 
    [OrderBy] INT NOT NULL DEFAULT 1, 
	[IsCorrect] BIT NULL, 
    [Response] NVARCHAR(2083) NULL,
	[Image_1_Device] NVARCHAR(256) NULL, 
	[Image_1_Cloud] NVARCHAR(2083) NULL, 
	[Image_2_Device] NVARCHAR(256) NULL, 
	[Image_2_Cloud] NVARCHAR(2083) NULL, 
	[Image_3_Device] NVARCHAR(256) NULL, 
	[Image_3_Cloud] NVARCHAR(2083) NULL, 
	[Hyperlink_1] VARCHAR(2083) NULL, 
    [Hyperlink_2] VARCHAR(2083) NULL, 
    [Hyperlink_3] VARCHAR(2083) NULL, 
	[Mnemonic] VARCHAR(300) NULL,
	[LastModifiedOffset] DATETIMEOFFSET NULL, 
    [CloudRowId] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), 
    CONSTRAINT [PK_Responses] PRIMARY KEY ([ResponseId], [QuestionId]), 
    CONSTRAINT [FK_Responses_Questions] FOREIGN KEY ([QuestionId]) REFERENCES [Questions]([QuestionId])
)

GO

CREATE INDEX [IX_Responses_OrderBy] ON [dbo].[Responses] ([OrderBy])
