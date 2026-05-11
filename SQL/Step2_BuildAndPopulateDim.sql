-- 1. Build the Table (DML)
CREATE TABLE Dim_Date ( 
    DateKey INT PRIMARY KEY, -- Format: YYYYMMDD
    FullDate DATE NOT NULL,
    [Year] INT NOT NULL,
    [Quarter] INT NOT NULL,
    [Month] INT NOT NULL,
    [MonthName] NVARCHAR(20) NOT NULL,
    [Day] INT NOT NULL,
    [DayOfWeekName] NVARCHAR(20) NOT NULL,
    [IsWeekend] BIT NOT NULL
);


-- 2. Populate the Table (DML)
-- The Bike Store dataset primarily spans 2016-2018. 
-- We start at 2016 and go to 2019 to cover all transaction dates.
DECLARE @StartDate DATE = '2016-01-01'; 
DECLARE @EndDate DATE = '2019-12-31';   

WHILE @StartDate <= @EndDate
BEGIN
    INSERT INTO Dim_Date (
        DateKey, 
        FullDate, 
        [Year], 
        [Quarter], 
        [Month], 
        [MonthName], 
        [Day], 
        [DayOfWeekName], 
        [IsWeekend]
    )
    SELECT 
        CAST(FORMAT(@StartDate, 'yyyyMMdd') AS INT), -- Creates the integer ID (e.g., 20160101)
        @StartDate,                                   -- The actual date value
        YEAR(@StartDate),                             -- Extracts the year
        DATEPART(QUARTER, @StartDate),                -- Extracts 1, 2, 3, or 4
        MONTH(@StartDate),                            -- Extracts 1 through 12
        DATENAME(MONTH, @StartDate),                  -- Converts 1 to 'January', etc.
        DAY(@StartDate),                              -- Extracts the day number
        DATENAME(WEEKDAY, @StartDate),                -- Converts date to 'Monday', etc.
        CASE 
            WHEN DATENAME(WEEKDAY, @StartDate) IN ('Saturday', 'Sunday') THEN 1 
            ELSE 0 
        END;                                          -- Checks if it's a weekend

    SET @StartDate = DATEADD(DAY, 1, @StartDate);     -- Increments the loop by 1 day
END;
GO