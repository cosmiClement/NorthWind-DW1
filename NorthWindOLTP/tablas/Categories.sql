CREATE TABLE dbo.Categories (
    CategoryID INT IDENTITY(1,1) NOT NULL,
    CategoryName NVARCHAR(15) NOT NULL,
    Description NVARCHAR(MAX),
    Picture VARBINARY(MAX),
    rowversion ROWVERSION,

    CONSTRAINT PK_Categories PRIMARY KEY CLUSTERED (CategoryID)
);
GO