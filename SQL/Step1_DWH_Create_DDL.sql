
-- 1. DIMENSIONS

CREATE TABLE Dim_Date ( 
    DateKey INT IDENTITY(1,1) PRIMARY KEY, 
    FullDate DATE NOT NULL,
    [Year] INT NOT NULL,
    [Quarter] INT NOT NULL,
    [Month] INT NOT NULL,
    [MonthName] NVARCHAR(20) NOT NULL,
    [Day] INT NOT NULL,
    [DayOfWeekName] NVARCHAR(20) NOT NULL,
    [IsWeekend] BIT NOT NULL
);

CREATE TABLE Dim_Customer (
    CustomerKey INT IDENTITY(1,1) PRIMARY KEY,
    Customer_Source_ID INT, 
    First_Name NVARCHAR(100),
    Last_Name NVARCHAR(100),
    Email NVARCHAR(150),
    Phone NVARCHAR(50)
);

CREATE TABLE Dim_Product (
    ProductKey INT IDENTITY(1,1) PRIMARY KEY,
    Product_Source_ID INT, 
    Product_Name NVARCHAR(255),
    Category_Name NVARCHAR(100), 
    Brand_Name NVARCHAR(100),    
    Model_Year INT
);

CREATE TABLE Dim_Geography (
    LocationKey INT IDENTITY(1,1) PRIMARY KEY,
    Store_Source_ID INT, 
    Store_Name NVARCHAR(100),
    City NVARCHAR(100),
    State NVARCHAR(50),
    Zip_Code NVARCHAR(20)
);

CREATE TABLE Dim_Staff (
    StaffKey INT IDENTITY(1,1) PRIMARY KEY,
    Staff_Source_ID INT, 
    Staff_Name NVARCHAR(200), 
    Staff_Email NVARCHAR(150),
    Active_Status INT
);

CREATE TABLE Dim_Order_Status (
    StatusKey INT IDENTITY(1,1) PRIMARY KEY,
    Status_ID_Source INT, 
    Status_Description NVARCHAR(50) 
);

-- 2. FACT TABLES 

CREATE TABLE Fact_Sales (
    SalesKey INT IDENTITY(1,1) PRIMARY KEY,
    CustomerKey INT FOREIGN KEY REFERENCES Dim_Customer(CustomerKey),
    ProductKey INT FOREIGN KEY REFERENCES Dim_Product(ProductKey),
    LocationKey INT FOREIGN KEY REFERENCES Dim_Geography(LocationKey),
    DateKey INT FOREIGN KEY REFERENCES Dim_Date(DateKey),
    SalesAmount DECIMAL(18,2), 
    Quantity INT,
    DiscountAmount DECIMAL(18,2)
);


CREATE TABLE Fact_Shipping (
    ShipFactKey INT IDENTITY(1,1) PRIMARY KEY,
    ProductKey INT FOREIGN KEY REFERENCES Dim_Product(ProductKey),
    LocationKey INT FOREIGN KEY REFERENCES Dim_Geography(LocationKey),
    DateKey INT FOREIGN KEY REFERENCES Dim_Date(DateKey),
    ActualDays INT,    
    ScheduledDays INT, 
    LateRiskFlag INT   
);

CREATE TABLE Fact_Orders (
    OrderFactKey INT IDENTITY(1,1) PRIMARY KEY,
    CustomerKey INT FOREIGN KEY REFERENCES Dim_Customer(CustomerKey),
    StatusKey INT FOREIGN KEY REFERENCES Dim_Order_Status(StatusKey),
    StaffKey INT FOREIGN KEY REFERENCES Dim_Staff(StaffKey),
    DateKey INT FOREIGN KEY REFERENCES Dim_Date(DateKey), 
    Order_Total_Value DECIMAL(18,2),
    Item_Count INT
);


ALTER TABLE Dim_Product ADD
    StartDate DATE NOT NULL DEFAULT GETDATE(),
    EndDate   DATE NULL,
    IsCurrent BIT  NOT NULL DEFAULT 1;

ALTER TABLE Dim_Staff ADD
    StartDate DATE NOT NULL DEFAULT GETDATE(),
    EndDate   DATE NULL,
    IsCurrent BIT  NOT NULL DEFAULT 1;

    SELECT* FROM Dim_Staff

ALTER TABLE Fact_Sales
ADD Net_Revenue DECIMAL(18, 2) NULL;
