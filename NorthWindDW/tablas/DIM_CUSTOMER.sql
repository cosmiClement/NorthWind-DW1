CREATE TABLE [dbo].[DIM_CUSTOMER] (
    [CustomerID] NVARCHAR(5) NOT NULL,
    [CompanyName] NVARCHAR(40) NOT NULL,
    [ContactName] NVARCHAR(30) NULL,
    [City] NVARCHAR(15) NULL,
    [Region] NVARCHAR(15) NULL,
    [Country] NVARCHAR(15) NULL,

    CONSTRAINT PK_DIM_CUSTOMER
        PRIMARY KEY (CustomerID)
);