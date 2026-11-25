
# Project Workflow

## 1. Data Ingestion – Bronze Layer
The raw E-Commerce sales dataset was ingested into Databricks and stored in the Bronze layer.

- Source: CSV dataset
- Raw records: 2,000
- Table: bronze_orders
- Purpose: Preserve source data for further processing.

## 2. Data Cleaning – Silver Layer
The raw data was cleaned and transformed to improve data quality and consistency.

Cleaning activities:
- Removed duplicate records.
- Standardized text fields and order statuses.
- Handled missing and invalid values.
- Corrected data types.
- Cleaned city, customer, payment, and product-related fields.

- Cleaned records: 1,980
- Table: silver_orders

## 3. Business Aggregation – Gold Layer
Business-ready analytical tables were created to support reporting and dashboard analysis.

Gold tables:
- gold_sales_kpis
- gold_city_sales
- gold_category_sales
- gold_monthly_sales
- gold_product_sales
- gold_payment_sales
- gold_order_status

## 4. Dashboard & Analytics
The dashboard provides insights into:

- Overall sales KPIs
- City-wise revenue performance
- Monthly revenue trends
- Category performance
- Product sales rankings
- Payment mode analysis
- Order status distribution
- Delivery and cancellation analysis

## 5. Architecture

CSV Source
   ↓
Bronze – Raw Data
   ↓
Silver – Cleaned & Standardized Data
   ↓
Gold – Business Aggregations
   ↓
E-Commerce Sales Analytics Dashboard

## 6. Tools Used
- Databricks
- SQL
- Delta Tables
- Data Cleaning & Transformation
- Data Analytics & Visualization
