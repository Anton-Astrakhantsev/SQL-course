-- Запрос 6
select
  c.name as MDs,
  count(distinct e.id) as interns,
  round(avg(average_mark),2) as intern_average_mark
from
  employee as e
  left join chiefs as c on (e.chief_doc_id=c.id)
  left join marks as m on (e.id=m.employee_id)
group by c.name, c.id
order by c.id asc;

-- Запрос 9
with interns as (
select
  e.id,
  e.num_public as intern_num_public,
  m.average_mark as intern_average_mark
from
  employee as e
  left join marks as m on (e.id=m.employee_id)
)
select
  corr(intern_num_public, intern_average_mark)
from
  interns;
