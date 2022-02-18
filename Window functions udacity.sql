-- create a running total of standard_amt_usd (in the orders table) over order time with no date truncation. 
--Your final table should have two columns: one with the amount being added for each new row, and a second with the running total.

select total_amt_usd,
	sum(o.total_amt_usd)
	over (order by o.occurred_at) running_total
from orders o


--Now, modify your query from the previous quiz to include partitions. 
--Still create a running total of standard_amt_usd (in the orders table) over order time, 
--but this time, date truncate occurred_at by year and partition by that same year-truncated occurred_at variable. 
--Your final table should have three columns: 
--One with the amount being added for each row, one for the truncated date, and a final column with the running total within each year.

select
	standard_amt_usd,
	DATEPART(year,o.occurred_at),
	sum(standard_amt_usd) over (order by o.occurred_at) running_total
from orders o

--Select the id, account_id, and total variable from the orders table, 
--then create a column called total_rank that ranks this total amount of paper ordered (from highest to lowest) for each account using a partition. 
--Your final table should have these four columns.

select 
	a.id,
	a.name,
	o.total,
	DATEPART(YEAR, 'o.occurred_at'),
	sum(o.total) over (partition by year(o.occurred_at) order by sum(o.total) desc) as running_total
from accounts a
join orders o
on a.id = o.account_id
group by a.id, a.name, o.total, o.occurred_at