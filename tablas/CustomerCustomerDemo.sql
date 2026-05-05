CREATE TABLE dbo.CustomerCustomerDemo (
    CustomerID NCHAR(5) NOT NULL,
    CustomerTypeID NCHAR(10) NOT NULL,
    rowversion ROWVERSION,

    CONSTRAINT PK_CustomerCustomerDemo 
    PRIMARY KEY NONCLUSTERED (CustomerID, CustomerTypeID)
);
GO