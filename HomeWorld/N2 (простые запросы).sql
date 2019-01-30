select 'Антон Астраханцев' as fio;


select 'N1' as query;

select * from ratings limit 10;
select * from links where imdbid like '%42' and movieid between 100 and 1000 limit 10;


select 'N2' as query;

select distinct imdbid
from links as l
inner join ratings as r
on (l.movieid=r.movieid)
where r.rating = 5
limit 10;


select 'N3' as query;

select count(distinct l.movieid)
from links as l
left join ratings as r
on (l.movieid=r.movieid)
where r.movieid is null;

select userid
from ratings
group by userid
having avg(rating) > 3.5
order by avg(rating) desc
limit 10;


select 'N4' as query;

select imdbid
from links as l
left join ratings as r
on (l.movieid=r.movieid)
where l.movieid in (
select movieid
from ratings
group by movieid
having avg(rating) > 3.5)
limit 10;

with eleven as(
select userid, count(rating)
from ratings
group by userid
having count(rating) > 10)
select round(avg(rating), 3)
from ratings inner join eleven using (userid);
