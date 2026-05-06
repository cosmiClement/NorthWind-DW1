CREATE TABLE [dbo].[DIM_DATE] (
    [DateID] INT NOT NULL,
    [FullDate] DATE NOT NULL,
    [Year] INT NOT NULL,
    [Month] INT NOT NULL,
    [MonthName] NVARCHAR(15) NOT NULL,
    [Quarter] INT NOT NULL,
    [Day] INT NOT NULL,

    CONSTRAINT PK_DIM_DATE
        PRIMARY KEY (DateID)
);