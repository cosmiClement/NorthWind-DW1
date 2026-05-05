CREATE TABLE dbo.Region (
    RegionID INT NOT NULL,
    RegionDescription NCHAR(50) NOT NULL,
    rowversion ROWVERSION,

    CONSTRAINT PK_Region 
    PRIMARY KEY NONCLUSTERED (RegionID)
);
GO