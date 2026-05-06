CREATE TABLE dbo.Suppliers (
    SupplierID INT IDENTITY(1,1) NOT NULL,
    CompanyName NVARCHAR(40) NOT NULL,
    ContactName NVARCHAR(30),
    ContactTitle NVARCHAR(30),
    Address NVARCHAR(60),
    City NVARCHAR(15),
    Region NVARCHAR(15),
    PostalCode NVARCHAR(10),
    Country NVARCHAR(15),
    Phone NVARCHAR(24),
    Fax NVARCHAR(24),
    HomePage NVARCHAR(MAX),
    rowversion ROWVERSION,

    CONSTRAINT PK_Suppliers 
    PRIMARY KEY CLUSTERED (SupplierID)
);
GO