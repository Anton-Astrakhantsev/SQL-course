with temp_table as(
	select
		userid,
		movieid,
		rating as r,
		min(rating) over (partition by userid) as r_min,
		max(rating) over (partition by userid) as r_max,
		avg(rating) over (partition by userid) as avg_rating
	from
		ratings
)
select
	userid,
	movieid,
	case when
		r_max = r_min
	then
		null
	else
		round((r - r_min)/(r_max - r_min), 3)
	end as normed_rating,
	round(avg_rating, 3)
from
	temp_table
limit 30;
