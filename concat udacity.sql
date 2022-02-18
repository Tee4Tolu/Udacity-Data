--Each company in the accounts table wants to create an email address for each primary_poc. 
--The email address should be the first name of the primary_poc . last name primary_poc @ company name .com.

with t1 as
	(select
		primary_poc,
		name Name,
		LEFT(primary_poc, charindex(' ', primary_poc)) as First_name,
		RIGHT(primary_poc, LEN(primary_poc) - charindex(' ', primary_poc)) as Last_name
	from accounts a)
select First_name,
	Last_name,
	CONCAT(first_name, '.', last_name, '@', replace(name, ' ',''), '.com') as email,
	CONCAT(left(lower(first_name),1),RIGHT(lower(first_name),1), left(lower(Last_name),1),RIGHT(lower(Last_name),1),
	len(first_name), len(last_name), REPLACE(upper(name),' ','')) as password
from t1