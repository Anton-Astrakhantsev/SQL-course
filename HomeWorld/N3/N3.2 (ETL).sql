select 'Extract' as step;

create table keywords(
	id bigint,
	keywords varchar (6666)
	);
copy
	keywords("id","keywords")
from
	'F:\NETOLOGY_DATA\keywords.csv'
with
	delimiter ',' csv header;


select 'Transform' as step;

with top_rated as (
	-- ЗАПРОС1
	select
		movieid,
		avg(rating) as avg_rating
	from
		ratings
	group by
		movieid
	having
		count(rating) > 50
	order by 
		avg_rating desc,
		movieid asc
	limit 150)
-- ЗАПРОС2
select
	movieid,
	keywords
from
	top_rated as tr
	left join keywords as k
	on (tr.movieid=k.id)


select 'Load' as step;

copy (
	with top_rated as (
		select
			movieid,
			avg(rating) as avg_rating
		from
			ratings
		group by
			movieid
		having
			count(rating) > 50
		order by 
			avg_rating desc,
			movieid asc
		limit 150)
	select
		movieid,
		keywords
	--into
		--top_rated_tags
	from
		top_rated as tr
		left join keywords as k
		on (tr.movieid=k.id)
) to
	'F:\NETOLOGY_DATA\top_rated_tags.csv'
with
	delimiter ',' csv header;
