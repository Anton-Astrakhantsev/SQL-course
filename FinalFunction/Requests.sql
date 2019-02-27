-- Запрос 1
select
  d.name,
  count(distinct e.id)
from
  department as d
  left join employee as e
    on (d.id=e.department_id)
group by
  d.name;


-- Запрос 2
select
  d.id,
  d.name,
  count(e.id)
from
  department as d
  left join employee as e
    on (d.id=e.department_id)
group by
  d.id,
  d.name
having
  count(e.id) >= 3
order by d.id;


-- Запрос 3
select
  d.id as id,
  d.name as name,
  sum(e.num_public) as sum_public
from
  department as d
  left join employee as e
    on (d.id=e.department_id)
group by
  d.id,
  d.name
having
  sum(e.num_public) in (
  select sum(num_public)
  from employee
  group by department_id
  order by sum(num_public) desc
  limit 1
  );


--Запрос 4
with emp as (
select
  d.id as dep_id,
  d.name as dep_name,
  e.name as emp_name,
  num_public as num_public,
  min(num_public) over (partition by d.name) as min_public
from
  employee as e
  left join department as d
    on (d.id=e.department_id)
)
select
  dep_id,
  dep_name,
  emp_name,
  num_public
from
  emp
where
  num_public = min_public
order by dep_id asc;


-- Запрос 5
select
  d.id,
  d.name,
  round(avg(e.num_public),2) as avg_num_public
from
  department as d
  left join employee as e
    on (d.id=e.department_id)
group by 
  d.id,
  d.name
having
  count(distinct e.chief_doc_id) > 1;


-- Запрос 6
select
    d.name,
    sum(e.num_public) as sum_public
  from
    employee as e
    left join department as d on (e.department_id=d.id)
    left join marks as m on (e.id=m.employee_id)
  where
    m.average_mark >= 4
    and e.num_public > 5
  group by d.name
  having
    count(distinct e.id) >= 2
  order by sum(e.num_public) desc;
  

-- Запрос 7
select
  c.name as chief,
  c.experience,
  count(distinct e.id) as interns,
  round(avg(average_mark),2) as intern_average_mark
from
  employee as e
  left join chiefs as c on (e.chief_doc_id=c.id)
  left join marks as m on (e.id=m.employee_id)
group by c.name, c.id
order by c.id asc;


-- Запрос 8
select distinct
  c.name as chief,
  min(num_public) over (partition by chief_doc_id)
  || '-' ||
  max(num_public) over (partition by chief_doc_id)
  as chief_intern_pub_range
from
  employee as e
  left join chiefs as c on (e.chief_doc_id=c.id)
  left join marks as m on (e.id=m.employee_id);


-- Запрос 9
with one_two as (
select
  avg(average_mark),
  1 as check
from
  employee as e
  left join marks as m on (e.id=m.employee_id)
group by chief_doc_id
having
  count(e.id) < 3
),
three_plus as (
select
  avg(average_mark),
  1 as check
from
  employee as e
  left join marks as m on (e.id=m.employee_id)
group by chief_doc_id
having
  count(e.id) >= 3
)
select
  round(avg(ot.avg),2) as one_two_intern_per_chief,
  round(avg(tp.avg),2) as three_plus_intern_per_chief
from
  one_two as ot
  left join three_plus as tp on (ot.check=tp.check)


-- Запрос 10
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
