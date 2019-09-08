CREATE TABLE [dbo].[Categories]
(
	[CategoryId]  INT IDENTITY (1, 1) NOT NULL,
	[UserProfileId] INT NOT NULL,
	[CategoryName] NVARCHAR(100) NOT NULL,
	[ImageDevice] NVARCHAR(256) NULL, 
	[ImageCloud] NVARCHAR(2083) NULL,
	[ImageHash] INT NULL, 
	[LastModifiedOffset] DATETIMEOFFSET NULL DEFAULT SYSDATETIMEOFFSET(), 
    [CloudRowId] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), 
    [Originator] UNIQUEIDENTIFIER NULL, 
    CONSTRAINT [PK_Categories] PRIMARY KEY ([CategoryId], [UserProfileId])
)
