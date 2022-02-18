--Find the sales in terms of total dollars for all orders in each year, ordered from greatest to least. 
--Do you notice any trends in the yearly sales totals?

select
	distinct YEAR(o.occurred_at) 'Year',
	SUM(o.total_amt_usd) Total_amt
from orders o
group by o.occurred_at
order by Total_amt desc

select
	datepart(YEAR,o.occurred_at) as 'Year',
	SUM(o.total_amt_usd) over (partition by o.occurred_at ) as Total_sum
from orders o
group by o.occurred_at,o.total_amt_usd
order by Total_sum desc

--Which month did Parch & Posey have the greatest sales in terms of total dollars? Are all months evenly represented by the dataset?
	select
		DATENAME(month, o.occurred_at) as 'month',
		sum(o.total_amt_usd) as Total_sum
	from orders o
	WHERE o.occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
	group by o.occurred_at
	order by Total_sum desc


