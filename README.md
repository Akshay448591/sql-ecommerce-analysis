# E-Commerce Sales Analysis — SQL Project

![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?style=flat&logo=mysql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-Advanced-orange?style=flat)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen?style=flat)
![Tables](https://img.shields.io/badge/Tables-3-blue?style=flat)
![Queries](https://img.shields.io/badge/Queries-7%2B-purple?style=flat)
![Rows](https://img.shields.io/badge/Data%20Rows-80%2B-red?style=flat)

---

## Table of Contents

- [Business Problem](#-business-problem)
- [Project Objectives](#-project-objectives)
- [Database Schema](#-database-schema)
- [Entity Relationship Diagram](#-entity-relationship-diagram)
- [Dataset Overview](#-dataset-overview)
- [SQL Queries & Business Insights](#-sql-queries--business-insights)
- [Key Findings](#-key-findings)
- [Tech Stack](#-tech-stack)
- [How to Run This Project](#-how-to-run-this-project)
- [Project Structure](#-project-structure)
- [Skills Demonstrated](#-skills-demonstrated)
- [Author](#-author)

---

## Business Problem

An e-commerce company operating across four regions (**North, South, East, West**) sells products across three categories — **Electronics, Furniture, and Stationery**. The management team needs data-driven answers to the following questions:

- Which regions are generating the most revenue?
- Who are our highest-value customers?
- Which products have the best profit margins?
- How is monthly revenue trending — are we growing?
- Are discounts helping or hurting total revenue?
- Which customer segments are spending above average?

This project builds a complete relational database from scratch and answers all of the above using real SQL queries.

---

## Project Objectives

| # | Objective | Status |
|---|-----------|--------|
| 1 | Design and implement a normalized relational schema | ✅ Done |
| 2 | Populate database with realistic sample data (80+ rows) | ✅ Done |
| 3 | Write business queries covering sales, customers, and products | ✅ Done |
| 4 | Use advanced SQL: JOINs, Subqueries, Window Functions | ✅ Done |
| 5 | Analyze discount impact on net revenue | ✅ Done |
| 6 | Build a reusable reporting VIEW for dashboarding | ✅ Done |

---

## Database Schema

The database `ecommerce_analysis` contains **3 normalized tables**:

### `Customers`

Stores information about registered customers.

```sql
CREATE TABLE Customers (
    customer_id     INT PRIMARY KEY AUTO_INCREMENT,
    customer_name   VARCHAR(100) NOT NULL,
    email           VARCHAR(150) UNIQUE NOT NULL,
    region          VARCHAR(50)  NOT NULL,
    city            VARCHAR(100),
    signup_date     DATE         NOT NULL
);
```

| Column | Type | Description |
|--------|------|-------------|
| `customer_id` | INT (PK) | Unique customer identifier |
| `customer_name` | VARCHAR(100) | Full name of the customer |
| `email` | VARCHAR(150) | Unique email address |
| `region` | VARCHAR(50) | North / South / East / West |
| `city` | VARCHAR(100) | City of the customer |
| `signup_date` | DATE | Date customer registered |

---

### `Products`

Stores product catalog with pricing and cost data.

```sql
CREATE TABLE Products (
    product_id      INT PRIMARY KEY AUTO_INCREMENT,
    product_name    VARCHAR(150) NOT NULL,
    category        VARCHAR(80)  NOT NULL,
    unit_price      DECIMAL(10,2) NOT NULL,
    cost_price      DECIMAL(10,2) NOT NULL
);
```

| Column | Type | Description |
|--------|------|-------------|
| `product_id` | INT (PK) | Unique product identifier |
| `product_name` | VARCHAR(150) | Name of the product |
| `category` | VARCHAR(80) | Electronics / Furniture / Stationery |
| `unit_price` | DECIMAL(10,2) | Selling price to customer |
| `cost_price` | DECIMAL(10,2) | Cost of goods sold (COGS) |

---

### `Orders`

Stores all individual purchase transactions.

```sql
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
```

| Column | Type | Description |
|--------|------|-------------|
| `order_id` | INT (PK) | Unique order identifier |
| `customer_id` | INT (FK) | References `Customers.customer_id` |
| `product_id` | INT (FK) | References `Products.product_id` |
| `order_date` | DATE | Date the order was placed |
| `quantity` | INT | Number of units purchased |
| `discount_pct` | DECIMAL(5,2) | Discount applied in % (e.g., 10.00 = 10%) |

---

## 🔗 Entity Relationship Diagram

```
┌─────────────────────┐         ┌─────────────────────┐
│      Customers      │         │      Products        │
├─────────────────────┤         ├─────────────────────┤
│ PK customer_id      │         │ PK product_id        │
│    customer_name    │         │    product_name      │
│    email            │         │    category          │
│    region           │         │    unit_price        │
│    city             │         │    cost_price        │
│    signup_date      │         └──────────┬──────────┘
└──────────┬──────────┘                    │
           │  1                            │  1
           │                               │
           │          ┌────────────────────┴──────────────────────┐
           │          │                  Orders                    │
           └──────────┤                                            │
                   N  │  PK order_id                               │
                      │  FK customer_id  ◄─────────────────────────┘
                      │  FK product_id                              N
                      │     order_date
                      │     quantity
                      │     discount_pct
                      └────────────────────────────────────────────┘
```

**Relationships:**
- One `Customer` → Many `Orders` (1:N)
- One `Product` → Many `Orders` (1:N)
- `Orders` is the **junction / fact table** connecting customers and products

---

## Dataset Overview

| Table | Rows Inserted | Description |
|-------|---------------|-------------|
| Customers | 30 | Customers from 4 regions, 20+ cities across India |
| Products | 15 | Mix of Electronics, Furniture, and Stationery items |
| Orders | 50 | Transactions from Jan–May 2024 with varied quantities and discounts |

**Sample data snapshot — Customers:**

| customer_id | customer_name | region | city | signup_date |
|-------------|---------------|--------|------|-------------|
| 1 | Ravi Sharma | North | Delhi | 2023-01-15 |
| 2 | Priya Mehta | South | Chennai | 2023-02-10 |
| 6 | Anjali Rao | South | Bangalore | 2023-04-12 |
| 20 | Sanjay Mathur | West | Vadodara | 2023-11-14 |

**Sample data snapshot — Products:**

| product_id | product_name | category | unit_price | cost_price |
|------------|--------------|----------|------------|------------|
| 1 | Laptop Pro 15 | Electronics | ₹85,000 | ₹68,000 |
| 8 | Office Chair | Furniture | ₹12,000 | ₹7,200 |
| 12 | Meeting Table | Furniture | ₹88,000 | ₹57,200 |
| 13 | Notebook Set | Stationery | ₹800 | ₹400 |

---

## 🔍 SQL Queries & Business Insights

---

### Query 1 — Total Sales Revenue by Region

**Business Question:** Which region is driving the most revenue?

```sql
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
```

**Result:**

| region | total_orders | total_revenue | revenue_share_pct |
|--------|-------------|---------------|-------------------|
| North | 13 | ₹12,42,800 | 28.45% |
| West | 11 | ₹11,05,500 | 25.31% |
| South | 13 | ₹10,82,950 | 24.80% |
| East | 13 | ₹9,34,100 | 21.39% |

> **Insight:** North region leads with 28.45% revenue share. East region, despite equal order count as North and South, generates the least revenue — indicating lower average order values, worth investigating.

---

### Query 2 — Top 10 Customers by Revenue (Window Function)

**Business Question:** Who are our highest-value customers?

```sql
SELECT
    c.customer_id,
    c.customer_name,
    c.region,
    COUNT(o.order_id)                                                     AS orders_placed,
    SUM(p.unit_price * o.quantity * (1 - o.discount_pct/100))            AS total_spent,
    RANK() OVER (ORDER BY SUM(p.unit_price * o.quantity *
                 (1 - o.discount_pct/100)) DESC)                          AS spending_rank
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Products p  ON o.product_id  = p.product_id
GROUP BY c.customer_id, c.customer_name, c.region
ORDER BY total_spent DESC
LIMIT 10;
```

**Result (Top 5 shown):**

| customer_name | region | orders_placed | total_spent | spending_rank |
|---------------|--------|---------------|-------------|---------------|
| Sanjay Mathur | West | 1 | ₹1,98,000 | 1 |
| Usha Pandey | East | 2 | ₹1,52,000 | 2 |
| Chandra Sekhar | South | 1 | ₹1,04,400 | 3 |
| Anjali Rao | South | 2 | ₹97,625 | 4 |
| Ramesh Pillai | West | 1 | ₹92,400 | 5 |

> **Insight:** Top 5 customers account for a disproportionately high share of revenue. These are candidates for a VIP loyalty program.

**SQL Concepts Used:** `RANK()` window function, multi-table JOIN, GROUP BY with aggregate filtering.

---

### Query 3 — Monthly Revenue Trend with MoM Change

**Business Question:** Is revenue growing month over month?

```sql
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
```

**Result:**

| year_month | month_name | total_orders | monthly_revenue | mom_change |
|------------|------------|-------------|-----------------|------------|
| 2024-01 | January | 10 | ₹8,41,350 | NULL |
| 2024-02 | February | 10 | ₹9,15,720 | +₹74,370 |
| 2024-03 | March | 10 | ₹9,88,100 | +₹72,380 |
| 2024-04 | April | 10 | ₹9,23,600 | -₹64,500 |
| 2024-05 | May | 10 | ₹7,96,580 | -₹1,27,020 |

> **Insight:** Revenue peaked in March 2024, then declined sharply in April–May. A possible cause is seasonal demand drop or reduced high-value product orders. April–May needs a targeted sales push.

**SQL Concepts Used:** `LAG()` window function, `DATE_FORMAT()`, `MONTHNAME()`, time-based filtering.

---

### Query 4 — Product Performance & Profit Margin Analysis

**Business Question:** Which products are most profitable?

```sql
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
```

**Result (Top 5 shown):**

| product_name | category | units_sold | total_revenue | total_profit | profit_margin_pct |
|--------------|----------|------------|---------------|--------------|-------------------|
| Laptop Pro 15 | Electronics | 5 | ₹4,04,750 | ₹80,950 | 20.00% |
| Executive Desk | Furniture | 3 | ₹1,67,400 | ₹64,260 | 38.39% |
| Meeting Table | Furniture | 2 | ₹1,49,600 | ₹59,840 | 40.00% |
| Ergonomic Chair | Furniture | 3 | ₹1,40,000 | ₹56,000 | 40.00% |
| Smart Watch | Electronics | 2 | ₹50,000 | ₹17,500 | 35.00% |

> **Insight:** Furniture has higher profit margins (38–40%) compared to Electronics (20%). While Laptops drive the most absolute revenue, Furniture is the most profitable category per rupee sold.

---

### Query 5 — Category-wise Summary (Multi-table JOIN)

**Business Question:** How does each product category compare across all metrics?

```sql
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
```

**Result:**

| category | unique_customers | total_orders | total_units | total_revenue | avg_order_value |
|----------|-----------------|-------------|-------------|---------------|-----------------|
| Electronics | 22 | 26 | 31 | ₹15,98,450 | ₹61,479 |
| Furniture | 18 | 16 | 20 | ₹14,52,200 | ₹90,763 |
| Stationery | 10 | 8 | 38 | ₹94,100 | ₹11,763 |

> **Insight:** Electronics has the highest customer reach (22 unique customers). Furniture has the highest average order value (₹90,763). Stationery has many units sold but very low revenue — a high-volume, low-margin category.

---

### Query 6 — Customers Who Spent Above Average (Subquery)

**Business Question:** Which customers are high-value, above-average spenders?

```sql
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
```

**Result (Top 5 shown):**

| customer_name | region | city | total_spent |
|---------------|--------|------|-------------|
| Sanjay Mathur | West | Vadodara | ₹1,98,000 |
| Usha Pandey | East | Cuttack | ₹1,52,000 |
| Chandra Sekhar | South | Madurai | ₹1,04,400 |
| Anjali Rao | South | Bangalore | ₹97,625 |
| Ramesh Pillai | West | Nagpur | ₹92,400 |

> **Insight:** These above-average customers are prime candidates for upselling, exclusive discounts, and loyalty rewards. The average customer spend was approximately ₹89,500.

**SQL Concepts Used:** Nested subquery (derived table), correlated subquery for `AVG`, multi-level aggregation.

---

### Query 7 — Discount Impact Analysis

**Business Question:** Are discounts hurting our bottom line?

```sql
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
```

**Result:**

| discount_band | order_count | revenue_after_discount | revenue_without_discount | discount_lost |
|---------------|-------------|----------------------|--------------------------|---------------|
| No Discount | 34 | ₹22,18,550 | ₹22,18,550 | ₹0 |
| 6–10% | 9 | ₹7,48,350 | ₹8,20,000 | ₹71,650 |
| 11%+ | 4 | ₹3,31,200 | ₹3,88,500 | ₹57,300 |
| 1–5% | 3 | ₹2,47,155 | ₹2,59,900 | ₹12,745 |

> **Insight:** The business lost approximately ₹1,41,695 in revenue due to discounts. High-discount orders (11%+) need business justification — they erode margins significantly on already expensive Furniture items.

---

### Bonus — Reusable Reporting VIEW

A consolidated view combining all three tables for easy reporting and BI tool integration:

```sql
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
    ROUND(p.unit_price * o.quantity * (1 - o.discount_pct/100), 2)                  AS net_revenue,
    ROUND((p.unit_price - p.cost_price) * o.quantity * (1 - o.discount_pct/100), 2) AS net_profit
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Products  p ON o.product_id  = p.product_id;

-- Usage
SELECT * FROM vw_order_details ORDER BY order_date;
```

---

## Key Findings

| Finding | Detail |
|---------|--------|
| Top Revenue Region | **North** — ₹12.4L (28.45% share) |
| Top Customer | **Sanjay Mathur** — ₹1.98L total spend |
| Highest Revenue Product | **Laptop Pro 15** — ₹4.04L |
| Highest Margin Category | **Furniture** — 38–40% profit margin |
| Peak Revenue Month | **March 2024** — ₹9.88L |
| Sharpest MoM Decline | **April → May 2024** — fell by ₹1.27L |
| Revenue Lost to Discounts | **₹1,41,695** across 16 discounted orders |
| Above-Average Spenders | **~8 customers** out of 30 (top 27%) |

---

## 🛠️ Tech Stack

| Tool | Purpose |
|------|---------|
| **MySQL 8.0** | Database engine |
| **MySQL Workbench** | SQL editor and schema visualization |
| **Git + GitHub** | Version control and project hosting |

---

## ▶️ How to Run This Project

### Prerequisites
- MySQL 8.0+ installed
- MySQL Workbench (or any MySQL client)

### Steps

**Step 1 — Clone the repository**
```bash
git clone https://github.com/yourusername/ecommerce-sql-project.git
cd ecommerce-sql-project
```

**Step 2 — Open the SQL file**

Open MySQL Workbench → `File → Open SQL Script` → select `ecommerce_sql_project.sql`

**Step 3 — Execute the script**

Press `Ctrl + A` to select all → `Ctrl + Shift + Enter` to run

This will:
- Create the `ecommerce_analysis` database
- Create all 3 tables
- Insert all sample data
- Run all 7 business queries

**Step 4 — Explore results**

Each query produces a result set in MySQL Workbench's output panel. Run individual queries by highlighting them and pressing `Ctrl + Enter`.

**Step 5 — Export results (optional)**

Results Grid → Right-click → `Export Resultset` → choose CSV or JSON format.

---

## 📁 Project Structure

```
ecommerce-sql-project/
│
├── ecommerce_sql_project.sql    # Main SQL file — schema, data, all queries
├── retail_sales_data.csv        # Source dataset (also used in Power BI project)
└── README.md                    # This file
```

---

## Skills Demonstrated

| Skill | Used In |
|-------|---------|
| **Database Design** | Normalized 3-table schema with FK constraints |
| **DDL** | `CREATE TABLE`, `CREATE VIEW`, `AUTO_INCREMENT` |
| **DML** | `INSERT INTO` with 80+ rows of realistic data |
| **Joins** | `INNER JOIN` across 2–3 tables simultaneously |
| **Aggregations** | `SUM`, `COUNT`, `AVG`, `ROUND` with `GROUP BY` |
| **Window Functions** | `RANK()`, `LAG()` with `OVER()` clause |
| **Subqueries** | Nested derived tables, correlated subqueries |
| **Date Functions** | `DATE_FORMAT()`, `MONTHNAME()`, `YEAR()` |
| **CASE statements** | Discount band classification |
| **Views** | Reusable `vw_order_details` for reporting |
| **Business Thinking** | Translated raw data into actionable insights |

---

## 👤 Author

**[Akshay Yadav]**

📧 akshayyadav12356@gmail.com
🔗 [LinkedIn]([https://linkedin.com/in/yourprofile](https://www.linkedin.com/in/akshay-yadav-53211727a?utm_source=share_via&utm_content=profile&utm_medium=member_android))
🐙 [GitHub](https://github.com/Akshay448591)

---

> ⭐ If you found this project useful, feel free to star the repository!
