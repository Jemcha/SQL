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
