select * from orders;

-- Top 3 outlets by cuisine type without using limit and top function
with cte as (
select cuisine,Restaurant_id,count(*) as no_of_orders
from orders
group by Cuisine,Restaurant_id
)
select * from (
select *,ROW_NUMBER() over (partition by cuisine order by no_of_orders desc) as rn
from cte) a
where a.rn=1

--2 Find the daily new customer count from the launch date (everyday how many new customers are we acquiring)
with cte2 as(
select Customer_code,cast(Min(Placed_at) as date) as first_order_date from orders
group by Customer_code
)
select first_order_date,count(*) as no_of_new_customers
from cte2
group by first_order_date
order by first_order_date

--3 Count of all the users who were acquired in Jan 2025 and only placed one order in Jan and did not order any other order
-- find customers who were acquired in Jan month
-- only placed one order in jan
-- filter out those customers who have placed orders in any other months apart from January
select Customer_code,MONTH(Placed_at) as month_name,count(*) as no_of_orders
from orders
where MONTH(Placed_at)=1 and YEAR(placed_at) = 2025 and Customer_code not in
(select distinct Customer_code
from orders
where not ( MONTH(Placed_at)=1 and YEAR(placed_at) = 2025)
)
group by Customer_code,MONTH(Placed_at)
having count(*)=1;

-- they have placed orders in feb,march and any other month
select distinct Customer_code
from orders
where not ( MONTH(Placed_at)=1 and YEAR(placed_at) = 2025)

-- 4 List all the customers with no order in the last 7 days but were acquired one month ago with their first order on promo
-- first get latest order date for each customer and check whether they lie in last 7 days or not and get their first order date and
-- wether they are one month ago or not
-- then we join this cte with org tables on cust_code and first_order_date with placed_at
with cte as (
select Customer_code, MIN(placed_at) as first_order_date,
MAX(Placed_at) as latest_order_date
from orders
group by Customer_code)
select c.* ,o.Promo_code_Name as first_order_promo from cte c inner join orders o on c.Customer_code=o.Customer_code and c.first_order_date=o.Placed_at
where o.Promo_code_Name is not NULL and latest_order_date < dateadd(day,-7,getdate())
and first_order_date < DATEADD(MONTH,-1,getdate())

--5) Growth team is planning to create a trigger that will target customers after their every third order with a personalized communication
-- and they have asked you to create a query for this.
-- after every third order they need to send a communication
-- need to make sure they are running this query everyday and send trigger to those cust who are placing after every 3rd orders
with cte as (
select *,
ROW_NUMBER() over (partition by customer_code order by Placed_at) as order_number
from orders)
select * from cte
where order_number%3=0 and cast(Placed_at as DATE)= '2025-03-31' -- cast(GETDATE() as DATE) since we are running this query everyday so we must use this
-- we are adding this condition such that we dont send the same communication again and again to same customers

--6) list customers who placed more than one order and their order are promo only

select Customer_code,count(*) as no_of_orders,count(Promo_code_Name) as promo_orders from orders
group by Customer_code
having count(*)>1 and count(*)=count(Promo_code_Name);

--7) what percent of customers were organically acquired in January 2025 ( placed their first order without promo code)
with cte as (
select *,
ROW_NUMBER() over (partition by Customer_Code order by placed_at) as rn
from orders
where month(Placed_at)=1
)
select count(case when rn=1 and Promo_Code_Name is null then customer_code end)*100.0/Count(distinct Customer_code)
from cte