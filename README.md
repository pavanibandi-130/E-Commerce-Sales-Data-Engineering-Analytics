
# E-Commerce Sales Data Engineering & Analytics

## Project Overview
An end-to-end E-Commerce Sales Data Engineering and Analytics project built using Databricks and SQL. This project transforms raw sales data into structured analytical datasets through Bronze, Silver, and Gold layers and presents business insights through an interactive dashboard.

## Objectives
- Build a structured data processing workflow.
- Clean and standardize raw sales data.
- Handle missing values, invalid records, and duplicates.
- Create business-ready aggregated datasets.
- Analyze sales, products, cities, payments, and order statuses.

## Technology Stack
- Databricks
- SQL
- Data Engineering
- Data Cleaning & Transformation
- Data Quality
- Dashboard & Data Visualization

## Data Architecture

Raw Data → Bronze Layer → Silver Layer → Gold Layer → Dashboard

### Bronze Layer
- Ingested raw E-Commerce sales data.
- Stored source records for further processing.
- Table: `bronze_orders`

### Silver Layer
- Cleaned and standardized data.
- Removed duplicate records.
- Handled invalid and missing values.
- Table: `silver_orders`

### Gold Layer
Created business-ready analytical tables:

- `gold_sales_kpis`
- `gold_city_sales`
- `gold_category_sales`
- `gold_monthly_sales`
- `gold_product_sales`
- `gold_payment_sales`
- `gold_order_status`

## Dataset Summary
- Raw Records: 2,000
- Cleaned Records: 1,980
- Total Revenue: ₹5,942,291.08
- Delivered Orders: 1,235
- Revenue Eligible Orders: 1,225

## Dashboard Analysis
The dashboard provides insights into:

- Overall sales KPIs
- City-wise revenue
- Monthly sales trends
- Category-wise sales
- Product performance
- Payment mode analysis
- Order status distribution
- Delivery and cancellation analysis

## Data Quality
Data quality checks and cleaning addressed:
- Duplicate records
- Invalid dates
- Missing customer details
- Missing city information
- Invalid quantities and prices
- Unknown payment modes

## Project Screenshots
Dashboard screenshots are available in the `screenshots` folder.

## Key Learnings
- Data ingestion and layered data architecture
- SQL-based data transformation
- Data cleaning and validation
- Aggregation and KPI development
- Business analysis using structured datasets
- Dashboard design and data storytelling

## Author
Pavani Bandi
