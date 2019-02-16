create table Department (id integer primary key, name varchar(255));

create table Employee (id integer primary key, department_id integer, cheif_doc_id integer, name varchar(255), num_public integer);
alter table Employee add foreign key (department_id) references Department(id);

https://docs.google.com/document/d/1I94e2vaalFC-r7Ke1W4sC0jh1YUP-e48xDdmVM1AECo/edit                                                              
                                                              
