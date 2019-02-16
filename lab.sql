create table Department (id integer primary key, name varchar(255));

create table Employee (id integer primary key, department_id integer foreign key, cheif_doc_id integer, name varchar(255), num_public integer);
