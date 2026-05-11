# 🚲 Bike Store Data Warehouse Project
**IS313 – Data Warehouse | Cairo University | Faculty of Computers and Artificial Intelligence**

---

## 👥 Team Members

| Name | ID |
|------|----|
| Mohannad Salah | 20231182 |


---

## 📌 Project Overview

This project builds a full **Data Warehouse (DWH)** for a Bike Store business using a relational dataset sourced from Kaggle. The pipeline covers everything from raw data ingestion to a fully interactive Power BI dashboard — following industry-standard ETL practices using **SQL Server**, **SSIS**, and **Power BI**.

**Dataset:** [Bike Store Relational Database | SQL — Kaggle](https://www.kaggle.com/)

---

## 🗄️ Databases

| Database | Purpose |
|----------|---------|
| `BikeStore_STG` | Staging area — raw CSV data lands here first |
| `BikeStore_DWH` | Final Data Warehouse — cleaned Dim and Fact tables |

---

## 🏗️ Architecture

```
CSV Files → SSIS (Staging Load) → BikeStore_STG → SSIS (Dim/Fact Load) → BikeStore_DWH → Power BI Dashboard
```

---

## 📂 Project Files

| File | Description |
|------|-------------|
| `BikeStore_STG_DWH.sql` | Creates the Staging database and all STG tables |
| `Step1_DWH_Create_DDL.sql` | Creates the DWH database schema — all Dim and Fact tables |
| `Step2_BuildAndPopulateDim.sql` | Populates Dim_Date using a WHILE loop (2016–2018) |
| `Bike_Store_STG.dtsx` | SSIS package — loads all 9 CSV files into Staging |
| `Dim_Date.dtsx` | SSIS package — executes SQL task to populate date dimension |
| `Dim_Customer.dtsx` | SSIS package — SCD Type 1 load for customers |
| `Dim_Geography.dtsx` | SSIS package — SCD Type 1 load for store locations |
| `Dim_Order_Status.dtsx` | SSIS package — static load for order status lookup |
| `Dim_Product.dtsx` | SSIS package — SCD Type 2 load for products |
| `Dim_Staff.dtsx` | SSIS package — SCD Type 2 load for staff |
| `Fact_Sales.dtsx` | SSIS package — loads sales transactions fact table |
| `Fact_Shipping.dtsx` | SSIS package — loads shipping/logistics fact table |
| `Fact_Orders.dtsx` | SSIS package — loads order management fact table |

---

## 🗃️ Staging Tables (BikeStore_STG)

| Table | Description |
|-------|-------------|
| `STG_Brands` | Bicycle manufacturer names |
| `STG_Categories` | Types of bicycles |
| `STG_Customers` | Customer profile and contact info |
| `STG_Order_Items` | Line-item product details per order |
| `STG_Orders` | Order header — status, dates, store, staff |
| `STG_Products` | Master product catalog |
| `STG_Staffs` | Employee records and store assignments |
| `STG_Stocks` | Inventory levels per store |
| `STG_Stores` | Physical retail store locations |

---

## 📐 Dimensional Model (BikeStore_DWH)

### Dimensions

| Table | SCD Type | Description |
|-------|----------|-------------|
| `Dim_Date` | Static | Generated date dimension 2016–2018 |
| `Dim_Customer` | Type 1 | Customer names and contact details |
| `Dim_Product` | Type 2 | Product catalog with full version history |
| `Dim_Geography` | Type 1 | Store and customer locations |
| `Dim_Staff` | Type 2 | Staff records with full version history |
| `Dim_Order_Status` | Static | Fixed lookup — Pending, Processing, Rejected, Completed |

### Fact Tables

| Table | Grain | Type |
|-------|-------|------|
| `Fact_Sales` | One row per order line item | Transactional |
| `Fact_Shipping` | One row per shipment per store | Transactional |
| `Fact_Orders` | One row per unique Order ID | Transactional |

### Schema
**Galaxy Schema** — three fact tables sharing conformed dimensions.

---

## 📊 KPIs

### Fact_Sales
- Total Net Revenue (`SalesAmount - Discount`)
- Discount Rate %
- Top Selling Products by Quantity
- Revenue per Brand

### Fact_Shipping
- Late Shipment Rate %
- Average Fulfillment Time (days)

### Fact_Orders
- Average Order Value
- Order Success Rate %
- Average Basket Size

---

## ▶️ How to Run (Step by Step)

### Step 1 — Create Databases
1. Open **SSMS** and connect to your SQL Server instance
2. Run `BikeStore_STG_DWH.sql` → creates the Staging database
3. Create a new database named `BikeStore_DWH`
4. Select `BikeStore_DWH` and run `Step1_DWH_Create_DDL.sql`
5. Run `Step2_BuildAndPopulateDim.sql` to populate `Dim_Date`

> ⚠️ **Note:** If you get error Msg 544 (IDENTITY_INSERT), drop and recreate `Dim_Date` without the IDENTITY constraint, then re-run Step2.

### Step 2 — Run SSIS Packages (in this exact order)
1. `Bike_Store_STG.dtsx` — load CSVs into Staging
2. `Dim_Date.dtsx`
3. `Dim_Customer.dtsx`
4. `Dim_Geography.dtsx`
5. `Dim_Order_Status.dtsx`
6. `Dim_Product.dtsx`
7. `Dim_Staff.dtsx`
8. `Fact_Sales.dtsx`
9. `Fact_Shipping.dtsx`
10. `Fact_Orders.dtsx`

> ⚠️ **Note:** Update connection managers in each package to point to your local SQL Server instance (`localhost` or `.\YOUR_INSTANCE_NAME`) before running.

### Step 3 — Verify Data in SSMS
```sql
SELECT COUNT(*) FROM Fact_Sales;        -- Should return 4722
SELECT SUM(Net_Revenue) FROM Fact_Sales; -- Should return 7,689,109.71
SELECT COUNT(*) FROM Dim_Date;           -- Should return 1096 (3 years of dates)
```

### Step 4 — Open Power BI Dashboard
1. Open **Power BI Desktop**
2. Get Data → SQL Server → connect to `BikeStore_DWH`
3. Load all Dim and Fact tables
4. Verify relationships in Model view
5. Open the dashboard file

---

## 📈 Power BI Dashboard

**Title:** Business Performance Dashboard

**Page 1 — Sales Performance**
- KPI Cards: Total Net Revenue, Total Units Sold, Total Discount
- Monthly Net Revenue Trend (Line Chart)
- Top 10 Products by Quantity Sold (Bar Chart)
- Total Net Revenue by Brand (Pie Chart)
- Average Discount Rate by Brand (Column Chart)

**Page 2 — Shipping & Logistics**
- KPI Cards: Late Shipment Rate %, Average Fulfillment Days
- Late Shipment Rate per Store (Bar Chart)
- Average Fulfillment Time by Store (Bar Chart)
- Late vs On-Time Shipments (Donut Chart)
- Fulfillment Time Trend by Month (Line Chart)

**Page 3 — Order Management**
- KPI Cards: Average Order Value, Average Basket Size, Order Success Rate %
- Order Success Rate (Donut Chart)
- Average Order Value by Month (Line Chart)
- Total Orders by Staff Member (Bar Chart)
- Total Revenue by Month (Column Chart)

---

## 🛠️ Technologies Used

| Tool | Purpose |
|------|---------|
| SQL Server 2022 | Database engine |
| SSMS | Database management and query execution |
| Visual Studio + SSIS | ETL package development and execution |
| Power BI Desktop | Interactive dashboard and data visualization |

---

## 📝 Notes

- All SSIS packages use **OLE DB connections** to SQL Server
- `Dim_Product` and `Dim_Staff` implement **SCD Type 2** with `StartDate`, `EndDate`, and `IsCurrent` columns
- `Fact_Sales.Net_Revenue` is calculated as `SalesAmount - DiscountAmount`
- `Fact_Shipping.LateRiskFlag` = 1 if `shipped_date > required_date`, else 0
- Scheduling of SSIS packages is done via **SQL Server Agent Jobs**# Analytics-Warehouse