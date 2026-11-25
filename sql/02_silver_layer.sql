
-- ============================================================
-- Project: E-Commerce Sales Data Engineering & Analytics
-- Layer: Silver
-- Purpose: Clean, standardize and deduplicate raw sales data
-- Platform: Databricks SQL
-- ============================================================

CREATE OR REPLACE TABLE ecommerce_sales.default.silver_orders
USING DELTA
AS

WITH cleaned_data AS (
    SELECT
        TRIM(CAST(order_id AS STRING)) AS order_id,

        TRY_CAST(order_date AS DATE) AS order_date,

        TRIM(CAST(customer_id AS STRING)) AS customer_id,

        COALESCE(
            NULLIF(TRIM(customer_name), ''),
            'Unknown Customer'
        ) AS customer_name,

        COALESCE(
            NULLIF(TRIM(city), ''),
            'Unknown City'
        ) AS city,

        TRIM(product) AS product,

        TRIM(category) AS category,

        TRY_CAST(quantity AS INT) AS quantity,

        TRY_CAST(unit_price AS DOUBLE) AS unit_price,

        COALESCE(
            NULLIF(TRIM(payment_mode), ''),
            'Unknown Payment'
        ) AS payment_mode,

        CASE
            WHEN LOWER(TRIM(order_status)) = 'delivered' THEN 'Delivered'
            WHEN LOWER(TRIM(order_status)) = 'shipped' THEN 'Shipped'
            WHEN LOWER(TRIM(order_status)) = 'cancelled' THEN 'Cancelled'
            WHEN LOWER(TRIM(order_status)) = 'canceled' THEN 'Cancelled'
            WHEN LOWER(TRIM(order_status)) = 'processing' THEN 'Processing'
            WHEN LOWER(TRIM(order_status)) = 'returned' THEN 'Returned'
            ELSE 'Unknown'
        END AS order_status,

        ingestion_timestamp

    FROM ecommerce_sales.default.bronze_orders
),

deduplicated_data AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY order_id
            ORDER BY ingestion_timestamp DESC
        ) AS row_num
    FROM cleaned_data
    WHERE order_id IS NOT NULL
)

SELECT
    order_id,
    order_date,
    customer_id,
    customer_name,
    city,
    product,
    category,
    CASE
        WHEN quantity > 0 THEN quantity
        ELSE NULL
    END AS quantity,
    CASE
        WHEN unit_price > 0 THEN unit_price
        ELSE NULL
    END AS unit_price,
    payment_mode,
    order_status
FROM deduplicated_data
WHERE row_num = 1;
