--Provide a table that provides the region for each sales_rep along with their associated accounts. 
--This time only for the Midwest region. Your final table should include three columns: 
--the region name, the sales rep name, and the account name. 
--Sort the accounts alphabetically (A-Z) according to account name.

select
	a.name Account,
	s.name Rep,
	r.name Region
from accounts a
join sales_reps s
on a.sales_rep_id = s.id
join region r
on r.id = s.region_id
where r.name = 'Midwest'
order by a.name

--Provide a table that provides the region for each sales_rep along with their associated accounts. 
--This time only for accounts where the sales rep has a first name starting with S and in the Midwest region. 
--Your final table should include three columns: the region name, the sales rep name, and the account name. 
--Sort the accounts alphabetically (A-Z) according to account name. 

select
	a.name Account,
	s.name Rep,
	r.name Region
from accounts a
join sales_reps s
on a.sales_rep_id = s.id
join region r
on r.id = s.region_id
where s.name like 's%' and r.name = 'Midwest'
order by a.name


--Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. 
--However, you should only provide the results if the standard order quantity exceeds 100. 
--Your final table should have 3 columns: region name, account name, and unit price. 
--In order to avoid a division by zero error, adding .01 to the denominator here is helpful total_amt_usd/(total+0.01).

select
	r.name Region,
	a.name Account,
	o.total_amt_usd/(o.total+0.01) as Unit_Pice,
	o.standard_qty
from accounts a 
join orders o 
on a.id = o.account_id
join sales_reps s
on s.id = a.sales_rep_id
join region r
on r.id = s.region_id
where o.standard_qty > 100


--Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. 
--However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. 
--Your final table should have 3 columns: region name, account name, and unit price. 
--Sort for the smallest unit price first. In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01). 

select
	r.name Region,
	a.name Account,
	o.total_amt_usd/(o.total+0.01) as Unit_Pice,
	o.standard_qty,
	o.poster_qty
from accounts a 
join orders o 
on a.id = o.account_id
join sales_reps s
on s.id = a.sales_rep_id
join region r
on r.id = s.region_id
where o.standard_qty > 100 and o.poster_qty > 50
order by Unit_Pice desc


--What are the different channels used by account id 1001? Your final table should have only 2 columns: account name and the different channels. 
--You can try SELECT DISTINCT to narrow down the results to only the unique values.

select distinct 
	a.name Account,
	w.channel,
	a.id id
from accounts a
join web_events w
on a.id = w.account_id
where a.id = 1001


--Find all the orders that occurred in 2015. 
--Your final table should have 4 columns: occurred_at, account name, order total, and order total_amt_usd. 

select
	a.name Account,
	o.occurred_at,
	o.total,
	o.total_amt_usd
from accounts a
join orders o
on a.id = o.account_id
where o.occurred_at between '2015-01-01' and '2016-01-01'