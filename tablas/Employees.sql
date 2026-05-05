CREATE TABLE dbo.Employees (
    EmployeeID INT IDENTITY(1,1) NOT NULL,
    LastName NVARCHAR(20) NOT NULL,
    FirstName NVARCHAR(10) NOT NULL,
    Title NVARCHAR(30),
    TitleOfCourtesy NVARCHAR(25),
    BirthDate DATETIME,
    HireDate DATETIME,
    Address NVARCHAR(60),
    City NVARCHAR(15),
    Region NVARCHAR(15),
    PostalCode NVARCHAR(10),
    Country NVARCHAR(15),
    HomePhone NVARCHAR(24),
    Extension NVARCHAR(4),
    Photo VARBINARY(MAX),
    Notes NVARCHAR(MAX),
    ReportsTo INT,
    PhotoPath NVARCHAR(255),
    rowversion ROWVERSION,

    CONSTRAINT PK_Employees 
    PRIMARY KEY CLUSTERED (EmployeeID)
);
GO