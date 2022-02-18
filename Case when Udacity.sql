--Write a query to display for each order, the account ID, total amount of the order, and the level of the order - ‘Large’ or ’Small’ - 
--depending on if the order is $3000 or more, or smaller than $3000.

select
	a.id id,
	SUM(o.total_amt_usd) total_sum,
	case when SUM(o.total_amt_usd) > 3000 then 'Large order'
	else 'Small' end as Range
from orders o 
join accounts a 
on a.id = o.account_id
group by a.id
order by total_sum desc

--Write a query to display the number of orders in each of three categories, based on the total number of items in each order. 
--The three categories are: 'At Least 2000', 'Between 1000 and 2000' and 'Less than 1000'.

select
	o.id id,
	case when o.total <= 1000 then 'Small'
		when o.total > 1000 and o.total < 2000
		then 'Medium' 
		else 'Large' end as Range
from orders o
--group by o.id

--We would like to understand 3 different levels of customers based on the amount associated with their purchases. 
--The top level includes anyone with a Lifetime Value (total sales of all orders) greater than 200,000 usd. 
--The second level is between 200,000 and 100,000 usd. The lowest level is anyone under 100,000 usd. 
--Provide a table that includes the level associated with each account. 
--You should provide the account name, the total sales of all orders for the customer, and the level. 
--Order with the top spending customers listed first.

select
	a.name Name,
	sum(o.total_amt_usd) Sum_Total,
	case when sum(o.total_amt_usd) <= 100000 then 'Stingy'
	when sum(o.total_amt_usd) > 100000 and sum(o.total_amt_usd) <= 200000 
	then 'Fair'
	else 'Lavish'
	end as Customer_range
from accounts a
join orders o
on a.id = o.account_id
group by a.name

--We would now like to perform a similar calculation to the first, but we want to obtain the total amount spent by customers only in 2016 and 2017. 
--Keep the same levels as in the previous question. Order with the top spending customers listed first.

select
	a.name Name,
	o.occurred_at, 
	sum(o.total_amt_usd) Sum_Total,
	case when sum(o.total_amt_usd) <= 100000 then 'Stingy'
	when sum(o.total_amt_usd) > 100000 and sum(o.total_amt_usd) <= 200000 
	then 'Fair'
	else 'Lavish'
	end as Customer_range
from accounts a
join orders o
on a.id = o.account_id
where o.occurred_at between '2016-01-01' and '2017-01-01'
group by a.name, o.occurred_at

--We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders. 
--Create a table with the sales rep name, the total number of orders, and a column with top or not depending on if they have more than 200 orders. 
--Place the top sales people first in your final table.

select 
	s.name Rep,
	SUM(o.total) Total_orders,
	case when SUM(o.total) >= 15000 then 'Top Rep'
	else 'Not so top'
	end as Typa_rep
from sales_reps s
join accounts a 
on a.sales_rep_id = s.id
join orders o 
on o.account_id = a.id
group by s.name
order by Total_orders desc

--We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders or more than 750000 in total sales. 
--The middle group has any rep with more than 150 orders or 500000 in sales. 
--Create a table with the sales rep name, the total number of orders, total sales across all orders, 
--and a column with top, middle, or low depending on this criteria. 
--Place the top sales people based on dollar amount of sales first in your final table. 
--You might see a few upset sales people by this criteria!

select
	s.name Name,
	count(*) order_count,
	sum(o.total_amt_usd) sum_qty,
	case when count(*) > 200 or sum(o.total_amt_usd)  > 750000 then 'Top shot'
	when COUNT(*) > 150 and count(*) < 200 or sum(o.total_amt_usd) > 500000 and sum(o.total_amt_usd) < 750000
	then 'You dey try'
	else 'Fix your life'
	end as Typa_customers
from sales_reps s
join accounts a 
on a.sales_rep_id = s.id
join orders o
on a.id = o.account_id
group by s.name
order by order_count desc
