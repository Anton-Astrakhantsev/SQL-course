-- Запрос 1: Вывести список названий департаментов и количество главных врачей в каждом из этих департаментов
select
  d.name,
  count(distinct e.chief_doc_id)
from
  department as d
  left join employee as e
    on (d.id=e.department_id)
group by
  d.name;


-- Запрос 2: Вывести список департаментов, в которых работают 3 и более сотрудников
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


-- Запрос 3: Вывести список департаментов с максимальным количеством публикаций
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


--Запрос 4: Вывести список сотрудников с минимальным количеством публикаций в своем департаменте
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


-- Запрос 5: Вывести список департаментов и среднее количество публикаций для тех департаментов,
-- в которых работает более одного главного врача
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


-- Запрос 6: Вывести список департаментов и количество публикаций у интернов из них,
-- у которых средняя оценка не меньше 4 и количество публикаций больше 5,
-- а самих интернов в департаменте должно быть больше одного
select
  d.name,
  sum(e.num_public) as sum_public
from
  employee as e
  left join department as d on (e.department_id=d.id)
  left join mark as m on (e.id=m.employee_id)
where
  m.average_mark >= 4
  and e.num_public > 5
group by d.name
having
  count(distinct e.id) >= 2
order by sum(e.num_public) desc;
  

-- Запрос 7: Вывести доктора, его опыт, количество интернов под его руководством и средняя оценка этих интернов
select
  c.name as chief,
  c.experience,
  count(distinct e.id) as interns,
  round(avg(average_mark),2) as intern_average_mark
from
  employee as e
  left join chief as c on (e.chief_doc_id=c.id)
  left join mark as m on (e.id=m.employee_id)
group by c.name, c.id
order by c.id asc;


-- Запрос 8: Вывести докторов и диапозон максимльного и минимального количества публикаций у интернов этого доктора
select distinct
  c.name as chief,
  min(num_public) over (partition by chief_doc_id)
  || '-' ||
  max(num_public) over (partition by chief_doc_id)
  as chief_intern_pub_range
from
  employee as e
  left join chief as c on (e.chief_doc_id=c.id)
  left join mark as m on (e.id=m.employee_id);


-- Запрос 9: Найти среднюю оценку у интернов тех докторов, у которых меньше трех и от трех интернов в подчинении
with one_two as (
select
  avg(average_mark),
  1 as check
from
  employee as e
  left join mark as m on (e.id=m.employee_id)
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
  left join mark as m on (e.id=m.employee_id)
group by chief_doc_id
having
  count(e.id) >= 3
)
select
  round(avg(ot.avg),2) as one_two_intern_per_chief,
  round(avg(tp.avg),2) as three_plus_intern_per_chief
from
  one_two as ot
  left join three_plus as tp on (ot.check=tp.check);


-- Запрос 10: Найти корреляцию между количеством публикаций интерна и его средней оценкой в университете
with intern as (
select
  e.id,
  e.num_public as intern_num_public,
  m.average_mark as intern_average_mark
from
  employee as e
  left join mark as m on (e.id=m.employee_id)
)
select
  corr(intern_num_public, intern_average_mark)
from
  intern;
