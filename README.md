# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: RETAIL_SALES_ANALYSIS

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `RETAIL_SALES_ANALYSIS`.
- **Table Creation**: A table named `SALES_DETAILS` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE RETAIL_SALES_ANALYSIS;
USE RETAIL_SALES_ANALYSIS;

-- CREATING A TABLE
CREATE TABLE SALES_DETAILS (
transactions_id	INT(10),
sale_date DATE,
sale_time TIME,
customer_id	INT(10),
gender VARCHAR(12),
age	INT(4),
category VARCHAR(15),
quantiy	INT(8),
price_per_unit INT(10),
cogs FLOAT(2),
total_sale FLOAT(2));
```
**Altering the table**
```sql
ALTER TABLE SALES_DETAILS
MODIFY price_per_unit FLOAT ;
DESC SALES_DETAILS ;
ALTER TABLE SALES_DETAILS 
MODIFY transactions_id	INT PRIMARY KEY ;
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql

-- Determine the total number of records in the dataset.

SELECT COUNT(*) FROM SALES_DETAILS;

-- Find out how many unique customers are in the dataset.

SELECT COUNT(DISTINCT customer_id) FROM SALES_DETAILS;

-- Identify all unique product categories in the dataset.

SELECT COUNT(DISTINCT category) FROM SALES_DETAILS;

-- CHECK FOR NULL VALUES AND IF ANYTHING HAS NULL VALUE HANDLE IT (REPLACE , DELETE)

SELECT COUNT(*) FROM SALES_DETAILS
WHERE transactions_id IS NULL
OR
sale_date IS NULL
OR
sale_time IS NULL
OR
customer_id	IS NULL
OR
gender IS NULL
OR
age	IS NULL 
OR
category IS NULL
OR
quantiy	IS NULL
OR
price_per_unit IS NULL
OR
cogs IS NULL 
OR
total_sale IS NULL ;


-- THERE IS NO NULL VALUE IN THIS RECORDS , SO THE DATA CLEANING IS DONE !!!

/*  IF ANYTHING WAS THERE WE HAVE TO HANDLE THAT (DELETE IT OR REPLACE IT)

	THE QUERY FOR DELETING THE NULL VALUE IS ...
    
	DELETE FROM SALES_DETAILS
	WHERE 
		transactions_id IS NULL
		OR
		sale_date IS NULL
		OR
		sale_time IS NULL
		OR
		customer_id	IS NULL
		OR
		gender IS NULL
		OR
		age	IS NULL 
		OR
		category IS NULL
		OR
		quantiy	IS NULL
		OR
		price_per_unit IS NULL
		OR
		cogs IS NULL 
		OR
		total_sale IS NULL ;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT * FROM SALES_DETAILS WHERE sale_date = '2022-11-05';
    SELECT COUNT(*) FROM SALES_DETAILS WHERE sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022**:
```sql
-- to know the date formate select sale_date from  SALES_DETAILS limit 10 ;

SELECT * FROM SALES_DETAILS 
WHERE category = 'clothing' and quantiy > 3 and sale_date like '2022-11%';
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
SELECT category , SUM(total_sale) TOTAL_SALES FROM SALES_DETAILS
group by category ;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT round(AVG(age),2) FROM SALES_DETAILS
where category in ('Beauty') ;
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT * FROM SALES_DETAILS 
WHERE total_sale > 1000 ;

 -- COUNT OF TRANSACTIONS WHERE TOTAL SALE IS GRATER THAN 1000
SELECT COUNT(*) TOTAL_SALE_COUNT FROM SALES_DETAILS 
WHERE total_sale > 1000 ;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT category ,gender, count(transactions_id) FROM SALES_DETAILS
group by category,gender 
order by category ;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
SELECT total_sale FROM sales_details
LIMIT 10 ;

SELECT * FROM  (
SELECT AVG(total_sale) , EXTRACT(YEAR FROM sale_date ) yearr , EXTRACT(MONTH FROM sale_date ) monthh ,
RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date ) ORDER BY AVG(total_sale) DESC ) rankk from sales_details
GROUP BY 2 , 3 ) temp
WHERE rankk = 1 ;
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
SELECT customer_id,max(total_sale) as total_sales FROM SALES_DETAILS
group by customer_id 
order by total_sales desc
limit 5 ;

```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT count(distinct customer_id) unique_customers ,category from SALES_DETAILS
group by category ;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
SELECT sale_time FROM sales_details
limit 10;

SELECT CASES , COUNT(*) ORDERS FROM ( SELECT sales_details.*,CASE 
WHEN EXTRACT(HOUR FROM sale_time) <=12 THEN 'MORNING'
WHEN EXTRACT(HOUR FROM sale_time) > 12 AND  EXTRACT(HOUR FROM sale_time) <= 17 THEN 'AFTERNOON'
WHEN EXTRACT(HOUR FROM sale_time) > 17 THEN 'EVENING' 
END AS CASES FROM sales_details ) TEMPP
GROUP BY CASES ;
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.
