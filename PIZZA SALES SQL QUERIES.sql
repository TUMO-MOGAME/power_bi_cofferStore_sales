select * from pizza_sales;
select sum(quantity* unit_price) as "Total Revenue" from pizza_sales;

select (sum(quantity* unit_price))/ count(distinct(order_id)) as 'Average order value' from pizza_sales;

select sum(quantity) as 'Total pizza sold'  from pizza_sales;

select count(distinct(order_id)) as 'Total Number of orders'  from pizza_sales;

select  round(sum(quantity)/count(distinct(order_id)),0) as 'Average pizza per order' from pizza_sales;


SELECT * FROM pizza_sales;
-------------------------------------------------------------------------
SET SQL_SAFE_UPDATES = 0;

UPDATE pizza_sales
SET order_date = STR_TO_DATE(order_date, '%d-%m-%Y')
WHERE STR_TO_DATE(order_date, '%d-%m-%Y') IS NOT NULL;

SET SQL_SAFE_UPDATES = 1;
-------------------------------------------------------------------------
SELECT
    DAYNAME(left(order_date,10)) AS day_name, count(distinct(order_id)) as Total_orders
    from pizza_sales
    group by DAYNAME(left(order_date,10));

SELECT
    monthname(order_date) AS month_name, count(distinct(order_id)) as Total_orders
    from pizza_sales
    group by month_name;





WITH tbl AS (
    SELECT pizza_category, SUM(total_price) AS Total_per_category
    FROM pizza_sales
    GROUP BY pizza_category
),
tbl2 AS (
    SELECT SUM(total_price) AS total
    FROM pizza_sales
)
SELECT 
    tbl.pizza_category, 
    tbl.Total_per_category, 
    (tbl.Total_per_category / tbl2.total) * 100 AS percentage
FROM 
    tbl, 
    tbl2
ORDER BY 
    percentage DESC;
  
  
  
  
WITH tbl AS (
    SELECT pizza_size, SUM(total_price) AS Total_per_size
    FROM pizza_sales
    GROUP BY pizza_size
),
tbl2 AS (
    SELECT SUM(total_price) AS total
    FROM pizza_sales
)
SELECT 
    tbl.pizza_size, 
    tbl.Total_per_size, 
    (tbl.Total_per_size / tbl2.total) * 100 AS percentage
FROM 
    tbl, 
    tbl2
ORDER BY 
    percentage DESC;


select 
	distinct(pizza_name), 
    sum(total_price) as Total_revenue,
    (sum(total_price)/(select sum(total_price) from pizza_sales)*100) as percentage 
from pizza_sales
group by (pizza_name)
order by percentage  
limit 5;



select 
	distinct(pizza_name), 
    sum(quantity) as Total_quantity,
    (sum(quantity)/(select sum(quantity) from pizza_sales)*100) as percentage 
from pizza_sales
group by (pizza_name)
order by percentage  desc
limit 5`coffee shop sales`