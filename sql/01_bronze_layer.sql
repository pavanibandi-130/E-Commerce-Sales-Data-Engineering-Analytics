
-- ============================================================
-- Project: E-Commerce Sales Data Engineering & Analytics
-- Layer: Bronze
-- Purpose: Ingest raw CSV data into a Delta table
-- Platform: Databricks
-- ============================================================

CREATE TABLE IF NOT EXISTS ecommerce_sales.default.bronze_orders
USING DELTA
AS
SELECT
    *,
    current_timestamp() AS ingestion_timestamp,
    'ecommerce_orders.csv' AS source_file
FROM read_files(
    '/Volumes/ecommerce_sales/default/ecommerce_volume/ecommerce_orders.csv',
    format => 'csv',
    header => true
);
