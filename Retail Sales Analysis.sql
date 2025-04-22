USE sql_project;

CREATE TABLE retail_sales(
transactions_id int primary key,
sale_date date,
sale_time time,
customer_id int,
gender varchar(15),
age int,
category varchar(15),
quantity int,
price_per_unit float,
cogs float,
total_sale float
)

-- CHECKING FOR NULL VALUES   ---DATA CLEANING
SELECT * FROM retail_sales
WHERE 
  sale_time IS NULL
  OR 
  customer_id IS NULL
  OR 
  gender IS NULL
  OR
  age IS NULL
  OR 
  category IS NULL
  OR 
  quantity IS NULL
  OR 
  price_per_unit IS NULL
  OR 
  cogs IS NULL 
  OR
  total_sale IS NULL;
  
-- DATA EXPLORATION

-- HOW MANY SALES WE HAVE
SELECT COUNT(*) as total_sale FROM retail_sales;

-- HOW MANY UNIQUE CUSTOMERS WE HAVE
SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales;

-- HOW MANY CATEGORIES WE HAVE
SELECT DISTINCT category FROM retail_sales;

-- DATA ANALYSIS & BUSINESS KEY PROBLEMS AND ANSWER
-- 1.Write a SQL query to retrieve all columns for sales made on '2022-11-05:

SELECT * 
FROM retail_sales
WHERE sale_date = '05-11-2022';

-- 2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 2:

SELECT *
FROM retail_sales
WHERE category = 'Clothing' 
  AND quantity > 2;

-- 3.Write a SQL query to calculate the total sales (total_sale) for each category.:

SELECT 
  category,
  SUM(total_sale) as total_sales,
  COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1;

-- 4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:

SELECT 
  category as item_purchased,
  ROUND(AVG(age),2) as avg_age
FROM retail_sales
WHERE category = 'Beauty';
  

-- 5.Write a SQL query to find top 5 transactions where the total_sale is greater than 1000.:

SELECT * 
FROM retail_sales
WHERE 
total_sale > 1000
LIMIT 5;

-- 6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

SELECT 
 category,
 gender,
 COUNT(*) as total_trans
FROM retail_sales
GROUP BY 
  category,
  gender
 ORDER BY 1;

-- 7.Write a SQL query to calculate the average sale for each category and gender. 

SELECT 
 category,
 gender,
 AVG(total_sale) as avg_sale
FROM retail_sales
GROUP BY 1,2
ORDER BY 1,2;

-- 8.**Write a SQL query to find the top 5 customers based on the highest total sales **:

SELECT 
customer_id,
SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
-- 9.Write a SQL query to find the number of unique customers who purchased items from each category.:

SELECT 
category as category,
COUNT(DISTINCT customer_id) as unique_customer
FROM retail_sales
GROUP BY 1
ORDER BY 2; 

-- 10.Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
SELECT 
 CASE
 WHEN HOUR(sale_time) <12 THEN 'MORNING'
 WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON'
 ELSE 'EVENING'
END AS shift,
 COUNT(*) AS number_of_orders
FROM retail_sales 
GROUP BY shift;
 
