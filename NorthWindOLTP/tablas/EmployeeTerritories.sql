CREATE TABLE dbo.EmployeeTerritories (
    EmployeeID INT NOT NULL,
    TerritoryID NVARCHAR(20) NOT NULL,
    rowversion ROWVERSION,

    CONSTRAINT PK_EmployeeTerritories 
    PRIMARY KEY NONCLUSTERED (EmployeeID, TerritoryID)
);
GO