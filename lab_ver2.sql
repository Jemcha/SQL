-------2.a
--ver 1
with count_cheif as (
select department_id, count(distinct cheif_doc_id) as cnt_cheif_doc
from Employee
group by department_id
order by department_id) select department.name, cnt_cheif_doc from count_cheif join Department on Department.id=count_cheif.department_id;
--ver 2 
select department.name, dep_chief.cht_chief
from (select distinct department_id, count(cheif_doc_id) over (partition by department_id) cht_chief from Employee order by department_id) as dep_chief
inner join department on department.id=dep_chief.department_id;

---b
--ver1
with cnt3_in_dep as (
     select department_id, cnt_emp from (
select department_id, count(department_id) as cnt_emp
from Employee
group by department_id
order by department_id) as cnt_in_dep
where cnt_emp>=3)
  select department_id, Department.name, cnt_emp from cnt3_in_dep join department on department.id=cnt3_in_dep.department_id;
--ver2
select department.name, department_id, cnt_emp from (
  select distinct department_id, count(name) over (partition by department_id) cnt_emp from Employee order by department_id) dep_emp
inner join Department on Department.id=dep_emp.department_id
where cnt_emp>=3;






SELECT COUNT(*)
FROM ratings RIGHT JOIN links
ON links.movieid = ratings.movieid
WHERE ratings.rating IS NULL
LIMIT 10;
