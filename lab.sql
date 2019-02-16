SELECT 'ФИО: Ковалева Ирина';
 
--2.a                                                              
--ver 1
with count_cheif as (
select department_id, count(distinct cheif_doc_id) as cnt_cheif_doc
from Employee group by department_id order by department_id) 
select department.name, cnt_cheif_doc from count_cheif join Department on Department.id=count_cheif.department_id;
--ver 2 
select department.name, dep_chief.cht_chief from 
(select distinct department_id, count(cheif_doc_id) over (partition by department_id) cht_chief 
from Employee order by department_id) as dep_chief
inner join department on department.id=dep_chief.department_id;

--2.b
--ver1
with cnt3_in_dep as (
select department_id, cnt_emp from (
select department_id, count(department_id) as cnt_emp from Employee group by department_id order by department_id) as cnt_in_dep
where cnt_emp>=3)
select department_id, Department.name, cnt_emp from cnt3_in_dep join department on department.id=cnt3_in_dep.department_id;
--ver2
select department.name, department_id, cnt_emp from (
select distinct department_id, count(name) over (partition by department_id) cnt_emp from Employee order by department_id) dep_emp
inner join Department on Department.id=dep_emp.department_id
where cnt_emp>=3;

--2.c                                                             
--ver1
with max_cnt as (
select department_id, sum(num_public) as cnt_pub
from Employee
group by department_id
  order by cnt_pub desc) 
select department_id, cnt_pub, department.name from max_cnt join department on Department.id=max_cnt.department_id 
where cnt_pub in (select max(cnt_pub) from max_cnt limit 1) ;
--ver2
select distinct department_id, department.name, sum_pub  from (
select distinct department_id, sum(num_public) over (partition by department_id) sum_pub 
from Employee order by department_id) as dep_pub
inner join Department on Department.id=dep_pub.department_id
where sum_pub in (select sum(num_public) over (partition by department_id) as sum_pubb from Employee order by sum_pubb desc limit 1);

--2.d
SELECT department.id, Department.name, rank_e.name, rank_e.num_public
FROM (SELECT id, department_id, name, num_public, RANK() OVER (PARTITION BY department_id ORDER BY num_public) as rank
FROM employee) as rank_e
INNER JOIN department ON rank_e.department_id = department.id
WHERE rank_e.rank = 1;
--2.e
--ver1
with avg_dep as (select department_id, avg(num_public) as avg_num from Employee group by department_id having department_id in(
select department_id from Employee group by department_id having count(distinct cheif_doc_id)>1))
select name, department_id, avg_num from avg_dep inner join Department on Department.id=avg_dep.department_id;
--ver2
select distinct department_id, department.name, avg_pub from (
select distinct department_id, cheif_doc_id, avg(num_public) over (partition by department_id) avg_pub, 
rank() over (partition by department_id order by cheif_doc_id) cnt_cf from Employee) cnt_dep
inner join Department on cnt_dep.department_id=Department.id
where cnt_cf>1;                                                     
