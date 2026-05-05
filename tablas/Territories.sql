CREATE TABLE dbo.Territories (
    TerritoryID NVARCHAR(20) NOT NULL,
    TerritoryDescription NCHAR(50) NOT NULL,
    RegionID INT NOT NULL,
    rowversion ROWVERSION,

    CONSTRAINT PK_Territories 
    PRIMARY KEY NONCLUSTERED (TerritoryID)
);
GO