
-- ============================================================
-- Project: E-Commerce Sales Data Engineering & Analytics
-- Layer: Gold
-- Purpose: Create business-ready analytical tables
-- Platform: Databricks SQL
-- Source: ecommerce_sales.default.silver_orders
-- ============================================================

-- 1. GOLD SALES KPIs
CREATE OR REPLACE TABLE ecommerce_sales.default.gold_sales_kpis AS
SELECT
    COUNT(*) AS total_orders,
    COUNT_IF(order_status = 'Delivered') AS delivered_orders,
    COUNT_IF(
        order_status = 'Delivered'
        AND quantity IS NOT NULL
        AND unit_price IS NOT NULL
    ) AS revenue_eligible_orders,

    SUM(
        CASE
            WHEN order_status = 'Delivered'
                 AND quantity > 0
                 AND unit_price > 0
            THEN quantity * unit_price
            ELSE 0
        END
    ) AS total_revenue,

    ROUND(
        SUM(
            CASE
                WHEN order_status = 'Delivered'
                     AND quantity > 0
                     AND unit_price > 0
                THEN quantity * unit_price
                ELSE 0
            END
        ) /
        NULLIF(
            COUNT_IF(
                order_status = 'Delivered'
                AND quantity IS NOT NULL
                AND unit_price IS NOT NULL
            ), 0
        ), 2
    ) AS average_order_value,

    SUM(
        CASE
            WHEN order_status = 'Delivered'
                 AND quantity > 0
            THEN quantity
            ELSE 0
        END
    ) AS units_sold,

    ROUND(
        COUNT_IF(order_status = 'Delivered') * 100.0 /
        NULLIF(COUNT(*), 0), 2
    ) AS delivery_rate_percentage

FROM ecommerce_sales.default.silver_orders;


-- 2. CITY-WISE SALES
CREATE OR REPLACE TABLE ecommerce_sales.default.gold_city_sales AS
SELECT
    city,
    COUNT(*) AS total_orders,
    COUNT_IF(order_status = 'Delivered') AS delivered_orders,
    SUM(
        CASE
            WHEN order_status = 'Delivered'
                 AND quantity > 0
                 AND unit_price > 0
            THEN quantity
            ELSE 0
        END
    ) AS units_sold,
    ROUND(SUM(
        CASE
            WHEN order_status = 'Delivered'
                 AND quantity > 0
                 AND unit_price > 0
            THEN quantity * unit_price
            ELSE 0
        END
    ), 2) AS total_revenue
FROM ecommerce_sales.default.silver_orders
GROUP BY city;


-- 3. CATEGORY-WISE SALES
CREATE OR REPLACE TABLE ecommerce_sales.default.gold_category_sales AS
SELECT
    category,
    COUNT(*) AS total_orders,
    COUNT_IF(order_status = 'Delivered') AS delivered_orders,
    SUM(
        CASE
            WHEN order_status = 'Delivered'
                 AND quantity > 0
            THEN quantity
            ELSE 0
        END
    ) AS units_sold,
    ROUND(SUM(
        CASE
            WHEN order_status = 'Delivered'
                 AND quantity > 0
                 AND unit_price > 0
            THEN quantity * unit_price
            ELSE 0
        END
    ), 2) AS total_revenue
FROM ecommerce_sales.default.silver_orders
GROUP BY category;


-- 4. MONTHLY SALES
CREATE OR REPLACE TABLE ecommerce_sales.default.gold_monthly_sales AS
SELECT
    DATE_FORMAT(order_date, 'yyyy-MM') AS sales_month,
    COUNT(*) AS total_orders,
    COUNT_IF(order_status = 'Delivered') AS delivered_orders,
    SUM(
        CASE
            WHEN order_status = 'Delivered'
                 AND quantity > 0
            THEN quantity
            ELSE 0
        END
    ) AS units_sold,
    ROUND(SUM(
        CASE
            WHEN order_status = 'Delivered'
                 AND quantity > 0
                 AND unit_price > 0
            THEN quantity * unit_price
            ELSE 0
        END
    ), 2) AS total_revenue
FROM ecommerce_sales.default.silver_orders
WHERE order_date IS NOT NULL
GROUP BY DATE_FORMAT(order_date, 'yyyy-MM');


-- 5. PRODUCT-WISE SALES
CREATE OR REPLACE TABLE ecommerce_sales.default.gold_product_sales AS
SELECT
    product,
    category,
    COUNT(*) AS total_orders,
    COUNT_IF(order_status = 'Delivered') AS delivered_orders,
    SUM(
        CASE
            WHEN order_status = 'Delivered'
                 AND quantity > 0
            THEN quantity
            ELSE 0
        END
    ) AS units_sold,
    ROUND(SUM(
        CASE
            WHEN order_status = 'Delivered'
                 AND quantity > 0
                 AND unit_price > 0
            THEN quantity * unit_price
            ELSE 0
        END
    ), 2) AS total_revenue
FROM ecommerce_sales.default.silver_orders
GROUP BY product, category;


-- 6. PAYMENT-WISE SALES
CREATE OR REPLACE TABLE ecommerce_sales.default.gold_payment_sales AS
SELECT
    payment_mode,
    COUNT(*) AS total_orders,
    COUNT_IF(order_status = 'Delivered') AS delivered_orders,
    SUM(
        CASE
            WHEN order_status = 'Delivered'
                 AND quantity > 0
            THEN quantity
            ELSE 0
        END
    ) AS units_sold,
    ROUND(SUM(
        CASE
            WHEN order_status = 'Delivered'
                 AND quantity > 0
                 AND unit_price > 0
            THEN quantity * unit_price
            ELSE 0
        END
    ), 2) AS total_revenue
FROM ecommerce_sales.default.silver_orders
GROUP BY payment_mode;


-- 7. ORDER STATUS ANALYSIS
CREATE OR REPLACE TABLE ecommerce_sales.default.gold_order_status AS
SELECT
    order_status,
    COUNT(*) AS total_orders,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2)
        AS order_percentage
FROM ecommerce_sales.default.silver_orders
GROUP BY order_status;
