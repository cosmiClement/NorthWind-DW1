CREATE TABLE dbo.OrderDetails (
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    Quantity SMALLINT NOT NULL,
    Discount DECIMAL(4,2) NOT NULL,
    rowversion ROWVERSION,

    CONSTRAINT PK_OrderDetails 
    PRIMARY KEY CLUSTERED (OrderID, ProductID)
);
GO