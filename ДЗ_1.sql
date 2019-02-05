CREATE table films (name varchar(255) not null, id serial primary key, country varchar(255) not null, box_office numeric, release_year int);
CREATE table persons (id serial primary key, fio varchar(255) not null unique);
create table persons2content (person_id serial references persons(id), content_id serial references films(id), person_type varchar(255));
insert into films values ('The Boat That Rocked', 416824, 'Great Britain', 36348784, 2009), ('The Departed', 81314, 'USA', 289847354, 2006), ('Fight Club', 361, 'USA', 100853753, 1999), ('Secret Window', 4304, 'USA', 92913171, 2004), ('Venom', 463634, 'USA', 855002841, 2018);
insert into persons values (39984, 'Tom Hardy'), (25774, 'Edward Norton'), (6458, 'Matt Damon'), (36184, 'David Koepp'), (2944, 'David Fincher');
insert into persons2content values (39984, 463634, 'Actor'), (25774, 361, 'Actor'), (6458, 81314, 'Actor'), (36184, 4304, 'Producer'), (2944, 361, 'Producer');
