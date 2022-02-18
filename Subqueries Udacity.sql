--Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.

with t1 as
	(select
		s.name Name,
		sum(o.total_amt_usd) sum_amt,
		r.name region
	from sales_reps s
	join accounts a
	on a.sales_rep_id = s.id
	join orders o
	on a.id = o.account_id
	join region r
	on r.id = s.region_id
	group by s.name, r.name),
t2 as
	(select distinct
			region,
			max(sum_amt) sum_amt
		from t1
		group by region)
select 
	t1.name,
	t2.region,
	t2.sum_amt
from t1
join t2
on t1.region = t2.region and t1.sum_amt = t2.sum_amt
group by t1.Name, t2.region, t2.sum_amt

--For the region with the largest (sum) of sales total_amt_usd, how many total (count) orders were placed? 

	select max(sum_amt)
	from
	(select 
		r.name Name,
		sum(o.total_amt_usd) sum_amt
	from orders o
	join accounts a
	on a.id = o.account_id
	join sales_reps s
	on a.sales_rep_id = s.id 
	join region r
	on r.id = s.region_id
	group by r.name)t1


select
	r.name Region,
	COUNT(o.total) order_count
from region r
join sales_reps s
on s.region_id = r.id
join accounts a 
on a.sales_rep_id = s.id
join orders o 
on o.account_id = a.id
group by r.name
having SUM(o.total_amt_usd) = (select max(sum_amt)
	from
	(select 
		r.name Name,
		sum(o.total_amt_usd) sum_amt
	from orders o
	join accounts a
	on a.id = o.account_id
	join sales_reps s
	on a.sales_rep_id = s.id 
	join region r
	on r.id = s.region_id
	group by r.name)t1)
	

--How many accounts had more total purchases than the account name which has bought the most standard_qty paper 
--throughout their lifetime as a customer? 
select total_order
from
	(select top 1
		a.name Name,
		sum(o.total) total_order,
		SUM(o.standard_qty) standard_qty
	from accounts a
	join orders o
	on a.id = o.account_id
	group by a.name
	order by standard_qty desc)t1

with t2 as
	(select
		a.name Name,
		sum(o.total) sum_total
	from accounts a
	join orders o
	on a.id = o.account_id
	group by a.name
	having sum(o.total) > (select total_order
	from
		(select top 1
			a.name Name,
			sum(o.total) total_order,
			SUM(o.standard_qty) standard_qty
		from accounts a
		join orders o
		on a.id = o.account_id
		group by a.name
		order by standard_qty desc)t1))
select count(*) Total_accounts
from t2


--For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, 
--how many web_events did they have for each channel?
select id
from
(select
	top 1
	a.name Name,
	a.id,
	SUM(o.total_amt_usd) Total_amt
from accounts a
join orders o
on a.id = o.account_id
group by a.name, a.id
order by Total_amt desc)t1

select 
	a.name Name,
	w.channel Channel,
	count(*) channel_count
from web_events w
join accounts a
on a.id = w.account_id and a.id = (
		select id
	from
	(select
		top 1
		a.name Name,
		a.id,
		SUM(o.total_amt_usd) Total_amt
	from accounts a
	join orders o
	on a.id = o.account_id
	group by a.name, a.id
	order by Total_amt desc)t1)
group by a.name, w.channel


--What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?
with t1 as
	(select top 10
		a.name Name,
		sum(o.total_amt_usd) Total_sum
	from accounts a
	join orders o
	on a.id = o.account_id
	group by a.name
	order by Total_sum desc)
select AVG(total_sum) lifetime_average
	from t1


--What is the lifetime average amount spent in terms of total_amt_usd, including only the companies that spent more per order, on average, 
--than the average of all orders.

select
	AVG(o.total_amt_usd) avg_amt
from orders o

with t1 as 
	(select
		a.id,
		AVG(o.total_amt_usd) avg_amt
	from accounts a
	join orders o
	on a.id = o.account_id
	group by a.id
		having AVG(o.total_amt_usd) > (select
			AVG(o.total_amt_usd) avg_amt
		from orders o))
select AVG(avg_amt) Avg_of_avg
from t1






	



