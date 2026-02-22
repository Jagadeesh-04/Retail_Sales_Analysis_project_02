# CREATING THE DATA BASE

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

-- TABLE IS CREATED
ALTER TABLE SALES_DETAILS
MODIFY price_per_unit FLOAT ;
DESC SALES_DETAILS ;
ALTER TABLE SALES_DETAILS 
MODIFY transactions_id	INT PRIMARY KEY ;

-- TABLE IS ALTERED

SELECT * FROM SALES_DETAILS;
SELECT * FROM SALES_DETAILS
LIMIT 15 ;
-- DATA IMPORTED AND VIEWED SUCCESSFULLY

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
		 */

-- DATA EXPLORATION....

SELECT COUNT(*) FROM SALES_DETAILS;

SELECT COUNT(category) C FROM SALES_DETAILS;
SELECT COUNT(DISTINCT category) C FROM SALES_DETAILS;
SELECT DISTINCT category FROM SALES_DETAILS;

-- My Analysis & Findings
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


-- ________________________________________________________________________________________________________________________________________



-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

SELECT * FROM SALES_DETAILS WHERE sale_date = '2022-11-05';
    SELECT COUNT(*) FROM SALES_DETAILS WHERE sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 03 in the month of Nov-2022

-- to know the date formate select sale_date from  SALES_DETAILS limit 10 ;
SELECT * FROM SALES_DETAILS 
WHERE category = 'clothing' and quantiy > 3 and sale_date like '2022-11%';


-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT category , SUM(total_sale) TOTAL_SALES FROM SALES_DETAILS
group by category ;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT round(AVG(age),2) FROM SALES_DETAILS
where category in ('Beauty') ;


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT * FROM SALES_DETAILS 
WHERE total_sale > 1000 ;

 -- COUNT OF TRANSACTIONS WHERE TOTAL SALE IS GRATER THAN 1000
SELECT COUNT(*) TOTAL_SALE_COUNT FROM SALES_DETAILS 
WHERE total_sale > 1000 ;


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.


SELECT category ,gender, count(transactions_id) FROM SALES_DETAILS
group by category,gender 
order by category ;


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT total_sale FROM sales_details
LIMIT 10 ;

SELECT * FROM  (
SELECT AVG(total_sale) , EXTRACT(YEAR FROM sale_date ) yearr , EXTRACT(MONTH FROM sale_date ) monthh ,
RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date ) ORDER BY AVG(total_sale) DESC ) rankk from sales_details
GROUP BY 2 , 3 ) temp
WHERE rankk = 1 ;


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT customer_id,max(total_sale) as total_sales FROM SALES_DETAILS
group by customer_id 
order by total_sales desc
limit 5 ;


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT count(distinct customer_id) unique_customers ,category from SALES_DETAILS
group by category ;


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


SELECT sale_time FROM sales_details
limit 10;

SELECT CASES , COUNT(*) ORDERS FROM ( SELECT sales_details.*,CASE 
WHEN EXTRACT(HOUR FROM sale_time) <=12 THEN 'MORNING'
WHEN EXTRACT(HOUR FROM sale_time) > 12 AND  EXTRACT(HOUR FROM sale_time) <= 17 THEN 'AFTERNOON'
WHEN EXTRACT(HOUR FROM sale_time) > 17 THEN 'EVENING' 
END AS CASES FROM sales_details ) TEMPP
GROUP BY CASES ;


COMMIT;



-- End of project













