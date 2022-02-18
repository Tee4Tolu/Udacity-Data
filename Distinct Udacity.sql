--Use DISTINCT to test if there are any accounts associated with more than one region.

select
	a.name Account,
	a.id a_id,
	r.name Region,
	r.id r_id
from accounts a
join sales_reps s
on a.sales_rep_id = s.id
join region r
on r.id = s.region_id
group by a.name, a.id, r.name, r.id

select distinct id,name
from accounts

--Have any sales reps worked on more than one account?

select 
	s.name Rep,
	s.id s_id,
	COUNT(a.name) Account_count
from sales_reps s
join accounts a
on a.sales_rep_id = s.id
group by s.name, s.id
order by Account_count desc

select distinct s.name, s.id
from sales_reps s
group by s.name, s.id

