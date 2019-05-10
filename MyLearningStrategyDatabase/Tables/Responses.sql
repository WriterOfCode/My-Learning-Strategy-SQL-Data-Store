CREATE TABLE [dbo].[Responses]
(
	[ResponseId] INT IDENTITY (1, 1) NOT NULL , 
    [QuestionId] INT NOT NULL, 
    [OrderBy] INT NOT NULL, 
    [Response] NVARCHAR(MAX) NULL, 
    [IsCorrect] BIT NULL, 
	[ImageUrl] NVARCHAR(2083) NULL, 
	[Hyperlink_1] VARCHAR(2083) NULL, 
    [Hyperlink_2] VARCHAR(2083) NULL, 
    [Hyperlink_3] VARCHAR(2083) NULL, 
    CONSTRAINT [PK_Responses] PRIMARY KEY ([ResponseId], [QuestionId]), 
    CONSTRAINT [FK_Responses_Questions] FOREIGN KEY ([QuestionId]) REFERENCES [Questions]([QuestionId])
)

GO

CREATE INDEX [IX_Responses_OrderBy] ON [dbo].[Responses] ([OrderBy])
