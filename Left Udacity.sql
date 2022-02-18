--In the accounts table, there is a column holding the website for each company. 
--The last three digits specify what type of web address they are using. A list of extensions (and pricing) is provided here. 
--Pull these extensions and provide how many of each website type exist in the accounts table.

with t1 as
	(select
		a.website website,
		RIGHT(a.website,3) website_type
	from accounts a)
select 
	t1.website_type,
	count(*) Total_no
from t1
group by website_type
order by Total_no desc


--There is much debate about how much the name (or even the first letter of a company name) matters. 
--Use the accounts table to pull the first letter of each company name to see the distribution of company names 
--that begin with each letter (or number).

with t1 as
	(select
		a.name Name,
		LEFT(a.name,1) First_letter
	from accounts a)
select t1.first_letter
	,COUNT(*) count_letter
from t1
group by t1.first_letter
order by count_letter desc


--Use the accounts table and a CASE statement to create two groups: 
--one group of company names that start with a number and a second group of those company names that start with a letter. 
--What proportion of company names start with a letter?


with t1 as
	(select
		name,
		case when LEFT(upper(name),1) in ('0','1','2','3','4','5','6','7','8','9') then 1 else 0 end as Numb,
		case when LEFT(upper(name),1) in ('0','1','2','3','4','5','6','7','8','9') then 0 else 1 end as Letter
	from accounts a)
select SUM(numb) Number, SUM(letter) Letters
from t1


--Consider vowels as a, e, i, o, and u. What proportion of company names start with a vowel, and what percent start with anything else? 
with t1 as
	(select
		name,
		case when LEFT(upper(name),1) in ('a','e','i','o','u') then 1 else 0 end as Vowels,
		case when LEFT(upper(name),1) in ('a','e','i','o','u') then 0 else 1 end as Others
	from accounts a)
select SUM(Vowels) Vowels, SUM(Others) Others
from t1

--Use the accounts table to create first and last name columns that hold the first and last names for the primary_poc. 

select
	primary_poc,
	left (primary_poc, CHARINDEX(' ', primary_Poc)) as First_name,
	RIGHT(primary_poc, len(primary_poc)-CHARINDEX(' ', primary_Poc)) as Last_name
from accounts a


--Now see if you can do the same thing for every rep name in the sales_reps table. Again provide first and last name columns.

select
	s.name Name,
	LEFT(name, CHARINDEX(' ', name)) as First_name,
	RIGHT(name, len(name)-CHARINDEX(' ', name)) as Last_name
from sales_reps s
