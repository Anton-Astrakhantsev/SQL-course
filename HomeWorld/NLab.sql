-- Запрос 1
select
  d.name,
  count(distinct e.chief_doc_id)
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
