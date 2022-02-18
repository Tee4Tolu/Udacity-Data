--When was the earliest order ever placed? You only need to return the date.

select top 1
	o.occurred_at
from orders o
order by o.occurred_at
--Try performing the same query as in question 1 without using an aggregation function.

--When did the most recent (latest) web_event occur?
select
	max(w.occurred_at) Event_time
from web_events w


--Find the mean (AVERAGE) amount spent per order on each paper type, as well as the mean amount of each paper type purchased per order. 
--Your final answer should have 6 values - one for each paper type for the average number of sales, as well as the average amount.

select 
	AVG(o.standard_qty) standard_qty,
	AVG(o.gloss_qty) gloss_qty,
	AVG(o.poster_qty) poster_qty,
	AVG(o.standard_amt_usd) standard_amt,
	AVG(o.gloss_amt_usd) gloss_amt,
	AVG(o.poster_amt_usd) poster_amt
from orders o