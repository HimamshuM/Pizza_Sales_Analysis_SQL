
use Pizza_DB;
Select Sum(total_price) as Total_Revenue from pizza_sales;


select * from pizza_sales;


Select count(Distinct(pizza_name_id)) as Total_Available_Pizza from pizza_sales;

Select Sum(total_price)/count(Distinct(order_id)) as Average_order_value from pizza_sales; 

Select sum(quantity) as total_Pizza_Sold from pizza_sales;

Select count(Distinct (Order_id)) as Total_orders from pizza_sales;

Select cast(sum(quantity) as decimal(10,2))/CAST(count(Distinct (Order_id)) as decimal(10,2)) from pizza_sales;


------------------------------------------------------------------------------------------------------------------------

-- Chart Requirements

select * from pizza_sales;

-- Hourly Trend for Total Pizzas Sold:

--Select order_time,sum(quantity) as Pizza_sold, sum(total_price) as Revenue
--from pizza_sales
--group by order_time
--order by order_time asc;

Select DATEPART(hour,order_time) as order_hour, sum(quantity) as Pizza_sold
from pizza_sales
group by DATEPART(hour,order_time)
order by DATEPART(hour,order_time);


-- 2.Weekly Trend for Total Orders:



Select DATEPART(ISO_WEEK,order_date) as week_Number,YEAR(order_date) as Order_year,Count(order_id) as Total_orders
from pizza_sales
group by DATEPART(ISO_WEEK,order_date),YEAR(order_date)
order by DATEPART(ISO_WEEK,order_date),YEAR(order_date);

-- 3.Percentage of Sales by Pizza Category:

Select * from pizza_sales;

Select pizza_category,sum(total_price) as total_sales,(sum(total_price)*100)/(select sum(total_price) from pizza_sales) as Pizza_sales_percent
from pizza_sales
group by pizza_category
order by pizza_category;


Select pizza_category,sum(total_price) as total_sales,(sum(total_price)*100)/
(select sum(total_price) from pizza_sales where MONTH(order_date)=1 ) as Pizza_sales_percent
from pizza_sales
where MONTH(order_date)=1
group by pizza_category;

-- 4.Percentage of Sales by Pizza Size:

Select * from pizza_sales;

Select pizza_size,sum(total_price) as total_sales,(sum(total_price)*100)/
(select sum(total_price) from pizza_sales) 
from pizza_sales
group by pizza_size;

SELECT pizza_size, CAST(sum(total_price) as decimal(10,2)) as Total_Sales, 
	Cast(sum(total_price)*100/(Select sum(total_price) from pizza_sales where DATEPART(QUARTER,order_date) = 1) as decimal(10,2))as PCT
	from pizza_sales
	where DATEPART(QUARTER,order_date) = 1
	group by pizza_size
	order by PCT DESC;

-- 6.Top 5 Best Sellers by Revenue, Total Quantity and Total Orders

Select * from pizza_sales;

SELECT TOP 5 pizza_name, sum(total_price) as Revenue
from pizza_sales
group by pizza_name
order by sum(total_price) DESC;

SELECT TOP 5 pizza_name, sum(quantity) as Total_quantity 
from pizza_sales
group by pizza_name
order by sum(total_price) DESC;

SELECT TOP 5 pizza_name, Sum(Distinct(order_id)) as Total_orders
from pizza_sales
group by pizza_name
order by sum(total_price) DESC;


-- 7. Bottom 5 Best Sellers by Revenue, Total Quantity and Total Orders


SELECT TOP 5 pizza_name, sum(total_price) as Revenue
from pizza_sales
group by pizza_name
order by sum(total_price) ASC;

SELECT TOP 5 pizza_name, sum(quantity) as Total_quantity 
from pizza_sales
group by pizza_name
order by sum(total_price) ASC;

SELECT TOP 5 pizza_name, Sum(Distinct(order_id)) as Total_orders
from pizza_sales
group by pizza_name
order by sum(total_price) ASC;

