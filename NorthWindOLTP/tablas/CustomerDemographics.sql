CREATE TABLE dbo.CustomerDemographics (
    CustomerTypeID NCHAR(10) NOT NULL,
    CustomerDesc NVARCHAR(MAX),
    rowversion ROWVERSION,

    CONSTRAINT PK_CustomerDemographics 
    PRIMARY KEY NONCLUSTERED (CustomerTypeID)
);
GO