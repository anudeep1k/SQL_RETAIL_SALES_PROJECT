-- sql retail sales
create database sql_project_1;

-- create table
DROP table IF EXISTS retail_sales;
create table retail_sales (
     transactions_id INT PRIMARY KEY,
	sale_date DATE,
	sale_time  TIME,
	customer_id INT,
	gender VARCHAR(15),
	age INT,
	category VARCHAR(15),
	quantiy INT,
	price_per_unit  FLOAT,
	cogs   FLOAT,
	total_sale  FLOAT
);
--

SELECT * FROM retail_sales 
where
transactions_id is null
or
sale_date is NULL
or
sale_time is null
or
customer_id is null
or 
gender is null
or 
age is null
or
category is null
or
quantiy is null
or 
cogs is null
or 
total_sale is null;

-- data cleaning

delete from retail_sales
WHERE
transactions_id is null
or
sale_date is NULL
or
sale_time is null
or
customer_id is null
or 
gender is null
or 
age is null
or
category is null
or
quantiy is null
or 
cogs is null
or 
total_sale is null;

-- data exploration
-- overall sales amount  we generated?

select sum(total_sale) as Total_sales from retail_sales;

-- how many customers we have?

select count(distinct customer_id) as total_customers from retail_sales;

-- data Analysis & business key problems & answers

--  My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)



-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

select * from retail_sales
where
sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022

select * from retail_sales
WHERE category = 'Clothing'
  AND quantiy >= 4
  AND MONTH(sale_date) = 11
  AND YEAR(sale_date) = 2022;



-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select category , sum(total_sale) 
from retail_sales 
group by category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.



select customer_id,avg(age) from retail_sales where category = 'Beauty'
group by customer_id;

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.



select * from retail_sales where total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select 
gender ,
 category ,
 count(*) 
 from retail_sales 
 group by gender,
 category
 order by gender;
 
 
 
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year



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
SELECT 
    year,
    month,
    avg_sale,
    total_sales
FROM ranked_months
WHERE rank_num = 1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select * from retail_sales;

select customer_id ,
sum(total_sale)
 from retail_sales
 group by customer_id 
 order by 2 desc 
 limit 5;
 
 -- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
 
 
 select category,
 count(distinct customer_id)
 from retail_sales group by 1; 
 
 -- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
 

SELECT 
    CASE 
        WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS number_of_orders
FROM retail_sales
GROUP BY shift;

-- end of project
