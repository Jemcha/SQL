create table Department (id integer primary key, name varchar(255));

create table Employee (id integer primary key, department_id integer, cheif_doc_id integer, name varchar(255), num_public integer);
alter table Employee add foreign key (department_id) references Department(id);
 
                                                              
with count_cheif as (
select department_id, count(distinct cheif_doc_id) as cnt_cheif_doc
from Employee
group by department_id
order by department_id) select department.name, cnt_cheif_doc from count_cheif join Department on Department.id=count_cheif.department_id;
                                                              
with cnt3_in_dep as (
     select department_id, cnt_emp from (
select department_id, count(department_id) as cnt_emp
from Employee
group by department_id
order by department_id) as cnt_in_dep
where cnt_emp>=3)
  select department_id, Department.name, cnt_emp from cnt3_in_dep join department on department.id=cnt3_in_dep.department_id;
                                                              
with max_cnt as (
select department_id, sum(num_public) as cnt_pub
from Employee
group by department_id
  order by cnt_pub desc) select department_id, cnt_pub, department.name from max_cnt join department on Department.id=max_cnt.department_id where cnt_pub in (select max(cnt_pub) from max_cnt limit 1) ;

SELECT d.id, d.name, e.name, e.num_public 
FROM (SELECT id, department_id, name, num_public, RANK() OVER (PARTITION BY department_id ORDER BY num_public) as rank
FROM employee) e
INNER JOIN department d ON e.department_id = d.id
WHERE e.rank = 1

with avg_dep as (select department_id, avg(num_public) as avg_num from Employee group by department_id having department_id in(
select department_id from Employee group by department_id having count(distinct cheif_doc_id)>1))
select name, department_id, avg_num from avg_dep inner join Department on Department.id=avg_dep.department_id;                                                       
