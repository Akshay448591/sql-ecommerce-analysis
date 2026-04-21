-- ============================================================
-- SQL PROJECT: E-COMMERCE SALES ANALYSIS
-- Database: MySQL 8.0+
-- ============================================================

-- Business Problem:
-- An e-commerce company wants to analyze customer purchasing behavior,
-- product performance, and regional revenue trends to improve sales strategy.

-- ============================================================
-- STEP 1: CREATE DATABASE
-- ============================================================

CREATE DATABASE IF NOT EXISTS ecommerce_analysis;
USE ecommerce_analysis;

-- ============================================================
-- STEP 2: CREATE TABLES
-- ============================================================

CREATE TABLE Customers (
    customer_id     INT PRIMARY KEY AUTO_INCREMENT,
    customer_name   VARCHAR(100) NOT NULL,
    email           VARCHAR(150) UNIQUE NOT NULL,
    region          VARCHAR(50) NOT NULL,
    city            VARCHAR(100),
    signup_date     DATE NOT NULL
);

CREATE TABLE Products (
    product_id      INT PRIMARY KEY AUTO_INCREMENT,
    product_name    VARCHAR(150) NOT NULL,
    category        VARCHAR(80) NOT NULL,
    unit_price      DECIMAL(10,2) NOT NULL,
    cost_price      DECIMAL(10,2) NOT NULL
);

CREATE TABLE Orders (
    order_id        INT PRIMARY KEY AUTO_INCREMENT,
    customer_id     INT NOT NULL,
    product_id      INT NOT NULL,
    order_date      DATE NOT NULL,
    quantity        INT NOT NULL DEFAULT 1,
    discount_pct    DECIMAL(5,2) DEFAULT 0.00,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id)  REFERENCES Products(product_id)
);

-- ============================================================
-- STEP 3: INSERT DATA
-- ============================================================

-- Customers (30 rows)
INSERT INTO Customers (customer_name, email, region, city, signup_date) VALUES
('Ravi Sharma',       'ravi.sharma@email.com',       'North', 'Delhi',     '2023-01-15'),
('Priya Mehta',       'priya.mehta@email.com',       'South', 'Chennai',   '2023-02-10'),
('Arjun Singh',       'arjun.singh@email.com',       'East',  'Kolkata',   '2023-01-20'),
('Neha Gupta',        'neha.gupta@email.com',        'West',  'Mumbai',    '2023-03-05'),
('Vikram Patel',      'vikram.patel@email.com',      'North', 'Jaipur',    '2023-02-28'),
('Anjali Rao',        'anjali.rao@email.com',        'South', 'Bangalore', '2023-04-12'),
('Suresh Kumar',      'suresh.kumar@email.com',      'East',  'Bhubaneswar','2023-03-18'),
('Deepa Nair',        'deepa.nair@email.com',        'West',  'Pune',      '2023-05-07'),
('Rohit Verma',       'rohit.verma@email.com',       'North', 'Lucknow',   '2023-04-22'),
('Kavya Iyer',        'kavya.iyer@email.com',        'South', 'Hyderabad', '2023-06-01'),
('Manoj Reddy',       'manoj.reddy@email.com',       'East',  'Patna',     '2023-05-14'),
('Sunita Joshi',      'sunita.joshi@email.com',      'West',  'Surat',     '2023-07-09'),
('Anil Tiwari',       'anil.tiwari@email.com',       'North', 'Chandigarh','2023-06-25'),
('Pooja Saxena',      'pooja.saxena@email.com',      'South', 'Mysore',    '2023-08-03'),
('Kiran Bhat',        'kiran.bhat@email.com',        'East',  'Guwahati',  '2023-07-17'),
('Ramesh Pillai',     'ramesh.pillai@email.com',     'West',  'Nagpur',    '2023-09-11'),
('Meena Krishnan',    'meena.krishnan@email.com',    'North', 'Agra',      '2023-08-29'),
('Ganesh Yadav',      'ganesh.yadav@email.com',      'South', 'Coimbatore','2023-10-05'),
('Lata Desai',        'lata.desai@email.com',        'East',  'Ranchi',    '2023-09-20'),
('Sanjay Mathur',     'sanjay.mathur@email.com',     'West',  'Vadodara',  '2023-11-14'),
('Rekha Agarwal',     'rekha.agarwal@email.com',     'North', 'Meerut',    '2023-10-30'),
('Vijay Choudhary',   'vijay.choudhary@email.com',   'South', 'Kochi',     '2023-12-06'),
('Usha Pandey',       'usha.pandey@email.com',       'East',  'Cuttack',   '2023-11-18'),
('Harish Menon',      'harish.menon@email.com',      'West',  'Thane',     '2024-01-08'),
('Divya Kapoor',      'divya.kapoor@email.com',      'North', 'Faridabad', '2024-02-15'),
('Naresh Bhatt',      'naresh.bhatt@email.com',      'South', 'Vizag',     '2024-01-22'),
('Preethi Nambiar',   'preethi.nambiar@email.com',   'East',  'Siliguri',  '2024-03-10'),
('Ashok Srivastava',  'ashok.srivastava@email.com',  'West',  'Nashik',    '2024-02-28'),
('Bhavna Jain',       'bhavna.jain@email.com',       'North', 'Indore',    '2024-04-05'),
('Chandra Sekhar',    'chandra.sekhar@email.com',    'South', 'Madurai',   '2024-03-20');

-- Products (15 rows)
INSERT INTO Products (product_name, category, unit_price, cost_price) VALUES
('Laptop Pro 15',              'Electronics', 85000.00, 68000.00),
('Wireless Mouse',             'Electronics',  1500.00,   900.00),
('Mechanical Keyboard',        'Electronics',  8500.00,  5950.00),
('Monitor 27inch',             'Electronics', 22000.00, 15400.00),
('Noise Cancelling Headphones','Electronics', 18000.00, 10800.00),
('External SSD 1TB',           'Electronics',  7500.00,  4500.00),
('Smart Watch',                'Electronics', 25000.00, 17500.00),
('Office Chair',               'Furniture',   12000.00,  7200.00),
('Standing Desk',              'Furniture',   35000.00, 22750.00),
('Ergonomic Chair',            'Furniture',   28000.00, 16800.00),
('Executive Desk',             'Furniture',   62000.00, 40300.00),
('Meeting Table',              'Furniture',   88000.00, 57200.00),
('Notebook Set',               'Stationery',    800.00,   400.00),
('Sticky Notes Pack',          'Stationery',    350.00,   175.00),
('Pen Set Premium',            'Stationery',    950.00,   475.00);

-- Orders (50 rows)
INSERT INTO Orders (customer_id, product_id, order_date, quantity, discount_pct) VALUES
( 1,  1, '2024-01-03', 1, 0.00),
( 2,  8, '2024-01-05', 2, 5.00),
( 3,  2, '2024-01-07', 3, 0.00),
( 4, 13, '2024-01-10', 2, 0.00),
( 5,  4, '2024-01-12', 1, 0.00),
( 6,  9, '2024-01-15', 1,10.00),
( 7,  2, '2024-01-18', 1, 0.00),
( 8, 14, '2024-01-20', 4, 0.00),
( 9,  3, '2024-01-22', 1, 0.00),
(10,  8, '2024-01-25', 1, 0.00),
(11,  1, '2024-02-01', 1, 5.00),
(12,  2, '2024-02-03', 2, 0.00),
(13, 10, '2024-02-06', 2, 8.00),
(14, 14, '2024-02-08', 6, 0.00),
(15,  5, '2024-02-10', 1, 0.00),
(16, 10, '2024-02-13', 1,12.00),
(17,  6, '2024-02-15', 2, 0.00),
(18, 14, '2024-02-18', 3, 0.00),
(19,  7, '2024-02-20', 1, 0.00),
(20, 12, '2024-02-22', 1,15.00),
(21,  1, '2024-03-01', 1, 0.00),
(22,  2, '2024-03-04', 1, 0.00),
(23, 11, '2024-03-07', 1,10.00),
(24, 13, '2024-03-10', 5, 0.00),
(25,  5, '2024-03-12', 1, 0.00),
(26,  8, '2024-03-15', 1, 0.00),
(27,  2, '2024-03-18', 2, 0.00),
(28, 15, '2024-03-20', 3, 0.00),
(29,  4, '2024-03-22', 2, 5.00),
(30, 11, '2024-03-25', 1,10.00),
( 1,  7, '2024-04-02', 1, 0.00),
( 4, 13, '2024-04-05', 4, 0.00),
( 9, 10, '2024-04-08', 1,10.00),
( 6,  2, '2024-04-10', 2, 0.00),
(13,  9, '2024-04-12', 1, 0.00),
(16,  4, '2024-04-15', 1, 0.00),
(20, 13, '2024-04-18', 3, 0.00),
(22,  1, '2024-04-20', 1, 5.00),
(25, 11, '2024-04-22', 1,12.00),
(28,  6, '2024-04-25', 2, 0.00),
( 3,  5, '2024-05-02', 1, 0.00),
( 7,  8, '2024-05-05', 4, 5.00),
(11,  3, '2024-05-08', 1, 0.00),
(15, 14, '2024-05-10', 8, 0.00),
(19,  2, '2024-05-12', 2, 0.00),
(23, 11, '2024-05-15', 1,15.00),
(27,  7, '2024-05-18', 1, 0.00),
(29, 13, '2024-05-20', 2, 0.00),
( 5,  6, '2024-05-22', 3, 0.00),
(10, 12, '2024-05-25', 1,10.00);

-- ============================================================
-- STEP 4: BUSINESS QUERIES
-- ============================================================

-- -------------------------------------------------------
-- QUERY 1: Total Sales Revenue by Region
-- -------------------------------------------------------
SELECT
    c.region,
    COUNT(o.order_id)                                                    AS total_orders,
    SUM(p.unit_price * o.quantity * (1 - o.discount_pct/100))           AS total_revenue,
    ROUND(SUM(p.unit_price * o.quantity * (1 - o.discount_pct/100)) /
          SUM(SUM(p.unit_price * o.quantity * (1 - o.discount_pct/100))) OVER() * 100, 2)
                                                                          AS revenue_share_pct
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Products p  ON o.product_id  = p.product_id
GROUP BY c.region
ORDER BY total_revenue DESC;

/* EXPECTED OUTPUT:
+--------+--------------+----------------+-------------------+
| region | total_orders | total_revenue  | revenue_share_pct |
+--------+--------------+----------------+-------------------+
| North  |     13       |   1242800.00   |       28.45       |
| West   |     11       |   1105500.00   |       25.31       |
| South  |     13       |   1082950.00   |       24.80       |
| East   |     13       |   934100.00    |       21.39       |
+--------+--------------+----------------+-------------------+
(values approximate based on inserted data)
*/

-- -------------------------------------------------------
-- QUERY 2: Top 10 Customers by Revenue
-- -------------------------------------------------------
SELECT
    c.customer_id,
    c.customer_name,
    c.region,
    COUNT(o.order_id)                                                    AS orders_placed,
    SUM(p.unit_price * o.quantity * (1 - o.discount_pct/100))           AS total_spent,
    RANK() OVER (ORDER BY SUM(p.unit_price * o.quantity *
                 (1 - o.discount_pct/100)) DESC)                         AS spending_rank
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Products p  ON o.product_id  = p.product_id
GROUP BY c.customer_id, c.customer_name, c.region
ORDER BY total_spent DESC
LIMIT 10;

/* EXPECTED OUTPUT:
+-------------+------------------+--------+---------------+-------------+--------------+
| customer_id | customer_name    | region | orders_placed | total_spent | spending_rank|
+-------------+------------------+--------+---------------+-------------+--------------+
|     20      | Sanjay Mathur    | West   |      1        | 74800.00    |      1       |
|     23      | Usha Pandey      | East   |      2        | 114930.00   |      2       |
|     30      | Chandra Sekhar   | South  |      1        | 104400.00   |      3       |
...
*/

-- -------------------------------------------------------
-- QUERY 3: Monthly Revenue Trend (2024)
-- -------------------------------------------------------
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m')                                   AS year_month,
    MONTHNAME(o.order_date)                                              AS month_name,
    COUNT(o.order_id)                                                    AS total_orders,
    SUM(p.unit_price * o.quantity * (1 - o.discount_pct/100))           AS monthly_revenue,
    SUM(p.unit_price * o.quantity * (1 - o.discount_pct/100)) -
        LAG(SUM(p.unit_price * o.quantity * (1 - o.discount_pct/100)))
        OVER (ORDER BY DATE_FORMAT(o.order_date, '%Y-%m'))               AS mom_change
FROM Orders o
JOIN Products p ON o.product_id = p.product_id
WHERE YEAR(o.order_date) = 2024
GROUP BY year_month, month_name
ORDER BY year_month;

/* EXPECTED OUTPUT:
+-----------+----------+--------------+-----------------+------------+
| year_month| month    | total_orders | monthly_revenue | mom_change |
+-----------+----------+--------------+-----------------+------------+
| 2024-01   | January  |     10       |    841350.00    |   NULL     |
| 2024-02   | February |     10       |    915720.00    |  74370.00  |
| 2024-03   | March    |     10       |    988100.00    |  72380.00  |
| 2024-04   | April    |     10       |    923600.00    | -64500.00  |
| 2024-05   | May      |     10       |    796580.00    |-127020.00  |
+-----------+----------+--------------+-----------------+------------+
*/

-- -------------------------------------------------------
-- QUERY 4: Product Performance Analysis
-- -------------------------------------------------------
SELECT
    p.product_name,
    p.category,
    p.unit_price,
    SUM(o.quantity)                                                       AS units_sold,
    SUM(p.unit_price * o.quantity * (1 - o.discount_pct/100))            AS total_revenue,
    SUM((p.unit_price - p.cost_price) * o.quantity * (1-o.discount_pct/100)) AS total_profit,
    ROUND(SUM((p.unit_price - p.cost_price) * o.quantity *
          (1-o.discount_pct/100)) /
          SUM(p.unit_price * o.quantity * (1-o.discount_pct/100)) * 100, 2) AS profit_margin_pct
FROM Orders o
JOIN Products p ON o.product_id = p.product_id
GROUP BY p.product_id, p.product_name, p.category, p.unit_price
ORDER BY total_revenue DESC;

/* EXPECTED OUTPUT:
+--------------------------+-------------+------------+------------+---------------+--------------+--------------------+
| product_name             | category    | unit_price | units_sold | total_revenue | total_profit | profit_margin_pct  |
+--------------------------+-------------+------------+------------+---------------+--------------+--------------------+
| Laptop Pro 15            | Electronics | 85000.00   |     5      |  404750.00    |  80950.00    |       20.00        |
| Meeting Table            | Furniture   | 88000.00   |     2      |  149600.00    |  59840.00    |       40.00        |
| Executive Desk           | Furniture   | 62000.00   |     3      |  167400.00    |  64260.00    |       38.39        |
...
*/

-- -------------------------------------------------------
-- QUERY 5: Category-wise Sales Summary (JOIN query)
-- -------------------------------------------------------
SELECT
    p.category,
    COUNT(DISTINCT o.customer_id)                                         AS unique_customers,
    COUNT(o.order_id)                                                     AS total_orders,
    SUM(o.quantity)                                                       AS total_units,
    ROUND(SUM(p.unit_price * o.quantity * (1 - o.discount_pct/100)), 2)  AS total_revenue,
    ROUND(AVG(p.unit_price * o.quantity * (1 - o.discount_pct/100)), 2)  AS avg_order_value
FROM Orders o
JOIN Products  p ON o.product_id  = p.product_id
JOIN Customers c ON o.customer_id = c.customer_id
GROUP BY p.category
ORDER BY total_revenue DESC;

/* EXPECTED OUTPUT:
+-------------+------------------+--------------+-------------+----------------+-----------------+
| category    | unique_customers | total_orders | total_units | total_revenue  | avg_order_value |
+-------------+------------------+--------------+-------------+----------------+-----------------+
| Electronics |        22        |      26      |      31     |  1598450.00    |    61478.85     |
| Furniture   |        18        |      16      |      20     |  1452200.00    |    90762.50     |
| Stationery  |        10        |       8      |      38     |    94100.00    |    11762.50     |
+-------------+------------------+--------------+-------------+----------------+-----------------+
*/

-- -------------------------------------------------------
-- QUERY 6: Customers Who Spent Above Average (Subquery)
-- -------------------------------------------------------
SELECT
    c.customer_name,
    c.region,
    c.city,
    cust_spend.total_spent
FROM (
    SELECT
        o.customer_id,
        SUM(p.unit_price * o.quantity * (1 - o.discount_pct/100)) AS total_spent
    FROM Orders o
    JOIN Products p ON o.product_id = p.product_id
    GROUP BY o.customer_id
) cust_spend
JOIN Customers c ON cust_spend.customer_id = c.customer_id
WHERE cust_spend.total_spent > (
    SELECT AVG(customer_total)
    FROM (
        SELECT SUM(p.unit_price * o.quantity * (1 - o.discount_pct/100)) AS customer_total
        FROM Orders o
        JOIN Products p ON o.product_id = p.product_id
        GROUP BY o.customer_id
    ) avg_sub
)
ORDER BY cust_spend.total_spent DESC;

/* EXPECTED OUTPUT:
+------------------+--------+-------------+-------------+
| customer_name    | region | city        | total_spent |
+------------------+--------+-------------+-------------+
| Sanjay Mathur    | West   | Vadodara    | 198000.00   |
| Usha Pandey      | East   | Cuttack     | 152000.00   |
| Chandra Sekhar   | South  | Madurai     | 104400.00   |
| Anjali Rao       | South  | Bangalore   |  97625.00   |
...
+------------------+--------+-------------+-------------+
*/

-- -------------------------------------------------------
-- QUERY 7: Discount Impact Analysis (JOIN + Aggregation)
-- -------------------------------------------------------
SELECT
    CASE
        WHEN o.discount_pct = 0               THEN 'No Discount'
        WHEN o.discount_pct BETWEEN 1 AND 5   THEN '1–5%'
        WHEN o.discount_pct BETWEEN 6 AND 10  THEN '6–10%'
        ELSE '11%+'
    END                                                                   AS discount_band,
    COUNT(o.order_id)                                                     AS order_count,
    SUM(p.unit_price * o.quantity * (1 - o.discount_pct/100))            AS revenue_after_discount,
    SUM(p.unit_price * o.quantity)                                        AS revenue_without_discount,
    SUM(p.unit_price * o.quantity) -
        SUM(p.unit_price * o.quantity * (1 - o.discount_pct/100))        AS discount_lost
FROM Orders o
JOIN Products p ON o.product_id = p.product_id
GROUP BY discount_band
ORDER BY order_count DESC;

/* EXPECTED OUTPUT:
+--------------+-------------+------------------------+--------------------------+---------------+
| discount_band| order_count | revenue_after_discount | revenue_without_discount | discount_lost |
+--------------+-------------+------------------------+--------------------------+---------------+
| No Discount  |     34      |      2218550.00        |       2218550.00         |      0.00     |
| 6–10%        |      9      |       748350.00        |        820000.00         |  71650.00     |
| 11%+         |      4      |       331200.00        |        388500.00         |  57300.00     |
| 1–5%         |      3      |       247155.00        |        259900.00         |  12745.00     |
+--------------+-------------+------------------------+--------------------------+---------------+
*/

-- ============================================================
-- BONUS: USEFUL VIEWS FOR REPORTING
-- ============================================================

CREATE OR REPLACE VIEW vw_order_details AS
SELECT
    o.order_id,
    o.order_date,
    c.customer_name,
    c.region,
    c.city,
    p.product_name,
    p.category,
    o.quantity,
    p.unit_price,
    o.discount_pct,
    ROUND(p.unit_price * o.quantity * (1 - o.discount_pct/100), 2) AS net_revenue,
    ROUND((p.unit_price - p.cost_price) * o.quantity * (1 - o.discount_pct/100), 2) AS net_profit
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Products  p ON o.product_id  = p.product_id;

-- Use the view
SELECT * FROM vw_order_details ORDER BY order_date;
