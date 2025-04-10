***   Task 3: SQL for Data Analysis    ***

***   Objective: Use SQL queries to extract and analyze data from a database.    ***

*** View All Data ***
SELECT * from synthetic_online_retail_data

*** Total Revenue ***
SELECT SUM(price * quantity) AS Total_Revenue
FROM synthetic_online_retail_data

*** Revenue by City ***
SELECT city, SUM(price * quantity) AS City_Revenue
FROM synthetic_online_retail_data
GROUP BY city
ORDER BY City_Revenue DESC

*** Most Popular Product (by quantity sold) ***
SELECT product_name, SUM(quantity) AS Total_Sold
FROM synthetic_online_retail_data
GROUP BY product_name
ORDER BY Total_Sold DESC

***  Average Review Score by Product Category ***
SELECT category_name, ROUND(AVG(review_score), 2) AS Avg_Review
FROM synthetic_online_retail_data
GROUP BY category_name
ORDER BY Avg_Review DESC

*** Payment Method Distribution ***
SELECT payment_method, COUNT(*) AS Num_Orders
FROM synthetic_online_retail_data
GROUP BY payment_method
ORDER BY Num_Orders DESC

*** Revenue by Gender ***
SELECT gender, SUM(price * quantity) AS Revenue
FROM synthetic_online_retail_data
GROUP BY gender

***  Age Grouping with Purchase Count ***
SELECT 
  CASE 
    WHEN age < 20 THEN 'Teen (<20)'
    WHEN age BETWEEN 20 AND 29 THEN '20s'
    WHEN age BETWEEN 30 AND 39 THEN '30s'
    WHEN age BETWEEN 40 AND 49 THEN '40s'
    ELSE '50+'
  END AS Age_Group,
  COUNT(*) AS Orders
FROM synthetic_online_retail_data
GROUP BY Age
ORDER BY Orders DESC

*** Subquery: Orders with High Review Score ***
SELECT * 
FROM synthetic_online_retail_data
WHERE review_score > (SELECT AVG(review_score) FROM synthetic_online_retail_data)

*** View: Monthly Sales Trend ***
CREATE VIEW monthly_sales AS
SELECT 
  YEAR(order_date) AS Sales_Year,
  MONTH(order_date) AS Sales_Month,
  SUM(price * quantity) AS Monthly_Revenue
FROM synthetic_online_retail_data
GROUP BY YEAR(order_date), MONTH(order_date)

SELECT * FROM monthly_sales
ORDER BY Sales_Year, Sales_Month

*** INNER JOIN → Show matched orders from known customers ***

SELECT 
  c.CustomerName,
  c.PurchaseAmount,
  sr.order_date,
  sr.product_id,
  sr.quantity,
  sr.price
FROM Customer as c
INNER JOIN synthetic_online_retail_data AS sr
  ON c.CustomerId = sr.customer_id
  
*** LEFT JOIN → All customers, even if they didn’t order ***

SELECT 
  c.CustomerName,
  c.PurchaseAmount,
  sr.order_date,
  sr.product_id,
  sr.quantity
FROM Customer as c
LEFT JOIN synthetic_online_retail_data as sr
  ON c.CustomerId = sr.customer_id
  
*** RIGHT JOIN ***  

SELECT 
  sr.customer_id,
  sr.order_date,
  c.CustomerName,
  c.PurchaseAmount
FROM synthetic_online_retail_data as sr
RIGHT JOIN Customer AS c
  ON sr.customer_id = c.CustomerId
  
*** Composite Index ***

CREATE INDEX idx_city_orderdate ON synthetic_online_retail_data (city, order_date)

