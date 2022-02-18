--Try pulling all the data from the accounts table, and all the data from the orders table.
select 
	a.*,
	o.*
from accounts a
join orders o
on a.id = o.account_id

--Try pulling standard_qty, gloss_qty, and poster_qty from the orders table, and the website and the primary_poc from the accounts table. 
select
	o.standard_qty standard_qty,
	o.gloss_qty gloss_qty,
	o.poster_qty poster_qty,
	a.primary_poc poc,
	a.website website
from accounts a
join orders o
on a.id = o.account_id

 
--Provide a table for all web_events associated with account name of Walmart. There should be three columns. 
--Be sure to include the primary_poc, time of the event, and the channel for each event. 
--Additionally, you might choose to add a fourth column to assure only Walmart events were chosen. 

select
	a.primary_poc,
	w.occurred_at,
	w.channel,
	a.name
from accounts a
join web_events w
on a.id = w.account_id
where a.name = 'Walmart'

--Provide a table that provides the region for each sales_rep along with their associated accounts. Your final table should include three columns: 
--the region name, the sales rep name, and the account name. 
--Sort the accounts alphabetically (A-Z) according to account name. 

select
	r.name Region,
	s.name Rep,
	a.name Account
from accounts a
join sales_reps s
on a.sales_rep_id = s.id
join region r
on r.id = s.region_id
--group by a.name,s.name,r.name
order by a.name


--Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. 
--Your final table should have 3 columns: region name, account name, and unit price. 
--A few accounts have 0 for total, so I divided by (total + 0.01) to assure not dividing by zero.

select
	a.name Account,
	r.name Region,
	o.total_amt_usd/(o.total + 0.01) unit_price
from accounts a
join orders o
on a.id = o.account_id
join sales_reps s
on a.sales_rep_id =s.id
join  region r
on r.id = s.region_id



