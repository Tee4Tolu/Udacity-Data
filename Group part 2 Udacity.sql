--For each account, determine the average amount of each type of paper they purchased across their orders. 
--Your result should have four columns - one for the account name and one for the average quantity purchased for each of the paper types for each account. 

select
	a.name,
	AVG(o.standard_qty) standard_qty,
	AVG(o.gloss_qty) gloss_qty,
	AVG(o.poster_qty) poster_qty
from accounts a
join orders o
on a.id = o.account_id
group by a.name


--For each account, determine the average amount spent per order on each paper type. 
--Your result should have four columns - one for the account name and one for the average amount spent on each paper type.

select
	a.name,
	AVG(o.standard_amt_usd) standard_amt,
	AVG(o.gloss_amt_usd) gloss_amt,
	AVG(o.poster_amt_usd) poster_amt
from accounts a
join orders o
on a.id = o.account_id
group by a.name

--Determine the number of times a particular channel was used in the web_events table for each sales rep. 
--Your final table should have three columns - the name of the sales rep, the channel, and the number of occurrences. 
--Order your table with the highest number of occurrences first.

select 
	s.name Name,
	w.channel Channel,
	count(*) as Channel_count
from sales_reps s
join accounts a
on a.sales_rep_id = s.id
join web_events w
on w.account_id = a.id
group by s.name, w.channel
order by Channel_count desc


--Determine the number of times a particular channel was used in the web_events table for each region. 
--Your final table should have three columns - the region name, the channel, and the number of occurrences. 
--Order your table with the highest number of occurrences first.

select
	r.name Name,
	w.channel Channel,
	COUNT(*) Channel_count
from region r
join sales_reps s
on s.region_id = r.id
join accounts a 
on a.sales_rep_id = s.id
join web_events w 
on a.id = w.account_id
group by r.name, w.channel
order by Channel_count desc