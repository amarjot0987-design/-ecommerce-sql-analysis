-- ============================================================
--   PROJECT 1: E-COMMERCE SALES ANALYSIS
--   Tool: MySQL
--   Author: Amarjot Singh Chawla
--   Description: End-to-end SQL analysis of e-commerce orders
--                covering revenue, customers, products & trends
-- ============================================================


-- ============================================================
-- STEP 1: DATABASE & TABLE SETUP
-- ============================================================

CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
    order_id        INT PRIMARY KEY,
    customer_id     INT,
    customer_name   VARCHAR(100),
    product_category VARCHAR(50),
    product_name    VARCHAR(100),
    quantity        INT,
    unit_price      DECIMAL(10,2),
    total_amount    DECIMAL(10,2),
    order_date      DATE,
    city            VARCHAR(50),
    payment_method  VARCHAR(30)
);


-- ============================================================
-- STEP 2: INSERT DATA (30 realistic records)
-- ============================================================

INSERT INTO orders VALUES
(1001, 201, 'Rahul Sharma',    'Electronics', 'Laptop',            1, 45000, 45000, '2024-01-05', 'Delhi',     'Credit Card'),
(1002, 202, 'Priya Singh',     'Clothing',    'Jacket',            2,  1500,  3000, '2024-01-07', 'Mumbai',    'UPI'),
(1003, 203, 'Amit Verma',      'Electronics', 'Phone',             1, 20000, 20000, '2024-01-10', 'Bangalore', 'Debit Card'),
(1004, 201, 'Rahul Sharma',    'Books',       'Data Science Book', 3,   500,  1500, '2024-01-12', 'Delhi',     'UPI'),
(1005, 204, 'Sneha Patel',     'Electronics', 'Headphones',        2,  2000,  4000, '2024-01-15', 'Ahmedabad', 'Credit Card'),
(1006, 205, 'Vikram Nair',     'Clothing',    'T-Shirt',           5,   600,  3000, '2024-01-18', 'Chennai',   'UPI'),
(1007, 206, 'Anjali Mehta',    'Home',        'Table Lamp',        1,   800,   800, '2024-01-20', 'Pune',      'Cash'),
(1008, 202, 'Priya Singh',     'Electronics', 'Tablet',            1, 15000, 15000, '2024-02-02', 'Mumbai',    'Credit Card'),
(1009, 207, 'Rohan Das',       'Books',       'Python Programming', 2,  450,   900, '2024-02-05', 'Kolkata',   'UPI'),
(1010, 208, 'Kavya Reddy',     'Home',        'Curtains',          3,  1200,  3600, '2024-02-08', 'Hyderabad', 'Debit Card'),
(1011, 203, 'Amit Verma',      'Clothing',    'Jeans',             2,  1800,  3600, '2024-02-10', 'Bangalore', 'UPI'),
(1012, 209, 'Neha Joshi',      'Electronics', 'Smart Watch',       1,  8000,  8000, '2024-02-14', 'Delhi',     'Credit Card'),
(1013, 210, 'Arjun Kapoor',    'Home',        'Bed Sheet Set',     2,   900,  1800, '2024-02-18', 'Jaipur',    'Cash'),
(1014, 204, 'Sneha Patel',     'Books',       'ML Handbook',       1,   600,   600, '2024-02-20', 'Ahmedabad', 'UPI'),
(1015, 211, 'Meera Iyer',      'Electronics', 'Laptop',            1, 52000, 52000, '2024-03-01', 'Chennai',   'Credit Card'),
(1016, 205, 'Vikram Nair',     'Home',        'Wall Clock',        2,   500,  1000, '2024-03-05', 'Chennai',   'UPI'),
(1017, 212, 'Siddharth Roy',   'Clothing',    'Formal Shirt',      3,  1200,  3600, '2024-03-08', 'Kolkata',   'Debit Card'),
(1018, 206, 'Anjali Mehta',    'Electronics', 'Phone',             1, 22000, 22000, '2024-03-12', 'Pune',      'Credit Card'),
(1019, 213, 'Tanvi Shah',      'Books',       'SQL Mastery',       2,   400,   800, '2024-03-15', 'Mumbai',    'UPI'),
(1020, 207, 'Rohan Das',       'Home',        'Dinner Set',        1,  2500,  2500, '2024-03-18', 'Kolkata',   'Cash'),
(1021, 214, 'Karan Malhotra',  'Electronics', 'Headphones',        3,  2500,  7500, '2024-03-22', 'Delhi',     'Credit Card'),
(1022, 208, 'Kavya Reddy',     'Clothing',    'Saree',             2,  3000,  6000, '2024-03-25', 'Hyderabad', 'UPI'),
(1023, 215, 'Divya Nair',      'Electronics', 'Smart Watch',       1,  9500,  9500, '2024-04-01', 'Bangalore', 'Debit Card'),
(1024, 209, 'Neha Joshi',      'Home',        'Sofa Cover',        1,  1500,  1500, '2024-04-05', 'Delhi',     'UPI'),
(1025, 216, 'Rahul Gupta',     'Books',       'Excel for Analysts', 3,  350,  1050, '2024-04-08', 'Pune',      'Cash'),
(1026, 210, 'Arjun Kapoor',    'Electronics', 'Tablet',            1, 18000, 18000, '2024-04-12', 'Jaipur',    'Credit Card'),
(1027, 217, 'Pooja Sharma',    'Clothing',    'Kurta Set',         2,  1100,  2200, '2024-04-15', 'Lucknow',   'UPI'),
(1028, 211, 'Meera Iyer',      'Home',        'Photo Frames',      4,   300,  1200, '2024-04-18', 'Chennai',   'Cash'),
(1029, 218, 'Aditya Singh',    'Electronics', 'Laptop',            1, 48000, 48000, '2024-04-22', 'Delhi',     'Credit Card'),
(1030, 212, 'Siddharth Roy',   'Books',       'Power BI Guide',    2,   550,  1100, '2024-04-25', 'Kolkata',   'UPI');


-- ============================================================
-- STEP 3: ANALYSIS QUERIES
-- ============================================================

-- ── ANALYSIS 1: Total Revenue, Orders & Avg Order Value ──────
-- Business Question: What is the overall business performance?

SELECT
    COUNT(order_id)            AS total_orders,
    SUM(total_amount)          AS total_revenue,
    ROUND(AVG(total_amount),2) AS avg_order_value,
    SUM(quantity)              AS total_units_sold
FROM orders;


-- ── ANALYSIS 2: Revenue by Product Category ──────────────────
-- Business Question: Which category drives the most revenue?

SELECT
    product_category,
    COUNT(order_id)             AS total_orders,
    SUM(total_amount)           AS total_revenue,
    ROUND(AVG(total_amount), 2) AS avg_order_value,
    ROUND(SUM(total_amount) * 100.0 / (SELECT SUM(total_amount) FROM orders), 2) AS revenue_share_pct
FROM orders
GROUP BY product_category
ORDER BY total_revenue DESC;


-- ── ANALYSIS 3: Top 5 Best-Selling Products by Revenue ────────
-- Business Question: Which products generate the most money?

SELECT
    product_name,
    product_category,
    SUM(quantity)     AS units_sold,
    SUM(total_amount) AS total_revenue
FROM orders
GROUP BY product_name, product_category
ORDER BY total_revenue DESC
LIMIT 5;


-- ── ANALYSIS 4: Monthly Revenue Trend ────────────────────────
-- Business Question: Is revenue growing month over month?

SELECT
    DATE_FORMAT(order_date, '%Y-%m')  AS month,
    COUNT(order_id)                   AS total_orders,
    SUM(total_amount)                 AS monthly_revenue
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month ASC;


-- ── ANALYSIS 5: Top 5 Customers by Total Spending ────────────
-- Business Question: Who are our highest value customers?

SELECT
    customer_id,
    customer_name,
    COUNT(order_id)   AS total_orders,
    SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id, customer_name
ORDER BY total_spent DESC
LIMIT 5;


-- ── ANALYSIS 6: City-wise Revenue Performance ────────────────
-- Business Question: Which cities contribute the most revenue?

SELECT
    city,
    COUNT(order_id)   AS total_orders,
    SUM(total_amount) AS total_revenue
FROM orders
GROUP BY city
ORDER BY total_revenue DESC;


-- ── ANALYSIS 7: Payment Method Preference ────────────────────
-- Business Question: Which payment method do customers prefer?

SELECT
    payment_method,
    COUNT(order_id)                                                AS total_orders,
    ROUND(COUNT(order_id) * 100.0 / (SELECT COUNT(*) FROM orders), 2) AS usage_pct
FROM orders
GROUP BY payment_method
ORDER BY total_orders DESC;


-- ── ANALYSIS 8: Repeat vs One-Time Customers ─────────────────
-- Business Question: How many customers ordered more than once?

SELECT
    CASE
        WHEN order_count = 1 THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END AS customer_type,
    COUNT(*) AS total_customers
FROM (
    SELECT customer_id, COUNT(order_id) AS order_count
    FROM orders
    GROUP BY customer_id
) AS customer_summary
GROUP BY customer_type;


-- ── ANALYSIS 9: Running Total Revenue (Window Function) ───────
-- Business Question: What is the cumulative revenue over time?

SELECT
    order_date,
    order_id,
    total_amount,
    SUM(total_amount) OVER (ORDER BY order_date) AS running_total_revenue
FROM orders
ORDER BY order_date;


-- ── ANALYSIS 10: Customer Rank by Spending (Window Function) ──
-- Business Question: Rank all customers by how much they spent

SELECT
    customer_name,
    SUM(total_amount) AS total_spent,
    RANK() OVER (ORDER BY SUM(total_amount) DESC) AS spending_rank
FROM orders
GROUP BY customer_id, customer_name;


-- ── ANALYSIS 11: Above Average Orders (Subquery) ─────────────
-- Business Question: Which orders are above the average order value?

SELECT
    order_id,
    customer_name,
    product_name,
    total_amount
FROM orders
WHERE total_amount > (SELECT AVG(total_amount) FROM orders)
ORDER BY total_amount DESC;


-- ── ANALYSIS 12: Category Revenue vs Overall Average (CTE) ───
-- Business Question: Which categories perform above average?

WITH category_revenue AS (
    SELECT
        product_category,
        SUM(total_amount) AS total_revenue
    FROM orders
    GROUP BY product_category
),
overall_avg AS (
    SELECT AVG(total_revenue) AS avg_revenue
    FROM category_revenue
)
SELECT
    c.product_category,
    c.total_revenue,
    o.avg_revenue,
    CASE
        WHEN c.total_revenue > o.avg_revenue THEN 'Above Average'
        ELSE 'Below Average'
    END AS performance
FROM category_revenue c, overall_avg o
ORDER BY c.total_revenue DESC;


-- ============================================================
-- END OF PROJECT 1
-- ============================================================
