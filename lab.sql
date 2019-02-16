create table Department (id integer primary key, name varchar(255));

create table Employee (id integer primary key, department_id integer, cheif_doc_id integer, name varchar(255), num_public integer);
alter table Employee add foreign key (department_id) references Department(id);
 
                                                              
with count_cheif as (
select department_id, count(distinct cheif_doc_id) as cnt_cheif_doc
from Employee
group by department_id
order by department_id) select department.name, cnt_cheif_doc from count_cheif join Department on Department.id=count_cheif.department_id;
                                                              
