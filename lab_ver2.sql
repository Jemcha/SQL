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
