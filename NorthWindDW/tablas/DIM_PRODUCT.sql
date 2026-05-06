CREATE TABLE [dbo].[DIM_PRODUCT] (
    [ProductID] INT NOT NULL,
    [ProductName] NVARCHAR(40) NOT NULL,
    [CategoryName] NVARCHAR(15) NULL,
    [SupplierName] NVARCHAR(40) NULL,
    [UnitPrice] DECIMAL(10,2) NOT NULL,
    [Discontinued] BIT NOT NULL,

    CONSTRAINT PK_DIM_PRODUCT
        PRIMARY KEY (ProductID)
);