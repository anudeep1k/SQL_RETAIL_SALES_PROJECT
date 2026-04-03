# 🛍️ Retail Sales Analysis Using SQL

> A complete SQL data analysis project on retail sales covering data cleaning, business questions, and SQL solutions in GitHub README format.

## 📖 About the Project

This project is a hands-on SQL analysis of retail sales data designed to solve real business problems using structured queries.

The main goal of this project was to practice how SQL is used in a real Data Analyst role—from cleaning raw transactional data to answering business questions that help understand sales trends, customer behavior, and product performance.

I used SQL to explore the dataset, clean missing values, and solve 10 business-driven SQL problems.

---

## 📂 Dataset Details

The dataset contains transaction-level retail sales records with the following fields:

* transactions_id
* sale_date
* sale_time
* customer_id
* gender
* age
* category
* quantiy
* price_per_unit
* cogs
* total_sale

---

## 🛠️ SQL Questions and Solutions

### ✅ Q1: Sales made on 2022-11-05

```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

### ✅ Q2: Clothing transactions with quantity > 10 in Nov 2022

```sql
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND quantiy > 10
  AND MONTH(sale_date) = 11
  AND YEAR(sale_date) = 2022;
```

### ✅ Q3: Total sales by category

```sql
SELECT category, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY category;
```

### ✅ Q4: Average age of customers in Beauty category

```sql
SELECT AVG(age) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';
```

### ✅ Q5: Transactions where total sale > 1000

```sql
SELECT *
FROM retail_sales
WHERE total_sale > 1000;
```

### ✅ Q6: Number of transactions by gender in each category

```sql
SELECT gender, category, COUNT(*) AS total_transactions
FROM retail_sales
GROUP BY gender, category
ORDER BY gender;
```

### ✅ Q7: Average sale for each month and best-selling month in each year

```sql
WITH monthly_sales AS (
    SELECT
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        SUM(total_sale) AS total_sales
    FROM retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
),
ranked_months AS (
    SELECT *,
           RANK() OVER (
               PARTITION BY year
               ORDER BY total_sales DESC
           ) AS rank_num
    FROM monthly_sales
)
SELECT year, month, avg_sale, total_sales
FROM ranked_months
WHERE rank_num = 1;
```

### ✅ Q8: Top 5 customers by highest total sales

```sql
SELECT customer_id, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```

### ✅ Q9: Unique customers by category

```sql
SELECT category, COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category;
```

### ✅ Q10: Shift-wise number of orders

```sql
SELECT
    CASE
        WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS number_of_orders
FROM retail_sales
GROUP BY shift;
```

---

## 📈 Key Insights

* Identified top-performing product categories
* Found highest-value customers
* Measured monthly sales trends
* Found best-selling month in each year
* Analyzed peak shift timings
* Understood customer purchase behavior

---

## 💼 Tools Used

* MySQL
* SQL Workbench
* GitHub

---

## 👤 Author

**ANUDEEP KOLLA**
Aspiring Data Analyst | SQL | Python | Power BI | AWS
