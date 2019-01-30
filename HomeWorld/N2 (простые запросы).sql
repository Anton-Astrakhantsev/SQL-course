select 'Антон Астраханцев' as fio;


select 'N1' as query;

select * from ratings limit 10;
select * from links where imdbId like '%42' and movieId between 100 and 1000 limit 10;


select 'N2' as query;

select distinct imdbId
from links as l
inner join ratings as r
on (l.movieId=r.movieId)
where r.rating = 5
limit 10;


select 'N3' as query;

select count(distinct l.movieId)
from links as l
left join ratings as r
on (l.movieId=r.movieId)
where r.movieId is null;

select userId
from ratings
group by userId
having avg(rating) > 3.5
order by avg(rating) desc
limit 10;


select 'N4' as query;

select imdbId
from links as l
left join ratings as r
on (l.movieId=r.movieId)
where l.movieId in (
select movieId
from ratings
group by movieId
having avg(rating) > 3.5)
limit 10;

with eleven as(
select userId, count(rating)
from ratings
group by userId
having count(rating) > 10)
select round(avg(rating), 3)
from ratings inner join eleven using (userId);
