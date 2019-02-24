create table Readers (id integer primary key, login varchar);
create table Authors (id integer primary key, name varchar);
create table Genres (id integer primary key, name varchar);

create table Books (id integer primary key, name varchar, author_id integer, genre_id integer, year integer, pages integer);
alter table Books add foreign key (author_id) references Authors(id);
alter table Books add foreign key (genre_id) references Genres(id);

create table Book_ratings (id integer primary key, reader_id integer, book_id integer, rating integer, date timestamp);
alter table Book_ratings add foreign key (reader_id) references Readers(id);
alter table Book_ratings add foreign key (book_id) references Books(id);


insert into Readers values
('1', 'Anna'),
('2', 'Rodion'),
('3', 'Best_reader'),
('4', 'Petro'),
('5', 'Jem');

insert into Authors values
('1', 'S. E. King'),
('2', 'D. G. Brown'),
('3', 'G. R. R. Martin');

insert into Genres values
('1', 'Fantasy'),
('2', 'Mystery'),
('3', 'Horror');


insert into Books values
('1', 'The Shinning', '1', '3', '1977', '447'),
('2', 'The Green Mile', '1', '1', '1996', '400'),
('3', 'Misery', '1', '3', '1987', '310'),
('4', 'Angels&Demons', '2', '2', '2000', '616'),
('5', 'The Da Vinci Code', '2', '2', '2003', '689'),
('6', 'The Lost Symbol', '2', '2', '2009', '528'),
('7', 'A Game of Thrones', '3', '1', '1996', '694'),
('8', 'A Clash of Kings', '3', '1', '1998', '761'),
('9', 'A Storm Of Swords', '3', '1', '2000', '973');

insert into Book_ratings values
('1', '1', '1', '4', '22-02-2019 12:54:55'),
('2', '1', '2', '3', '23-02-2019 17:42:50'),
('3', '1', '4', '5', '12-02-2019 13:30:55'),
('4', '1', '8', '4', '23-02-2019 18:51:31'),
('5', '2', '1', '5', '11-02-2019 14:54:45'),
('6', '2', '3', '3', '05-02-2019 05:58:35'),
('7', '3', '5', '4', '21-02-2019 10:11:22'),
('8', '3', '7', '5', '22-02-2019 12:23:55'),
('9', '3', '8', '4', '20-02-2019 20:54:34'),
('10', '3', '9', '4', '21-02-2019 11:23:55'),
('11', '3', '1', '3', '22-02-2019 15:45:01'),
('12', '4', '2', '4', '23-02-2019 09:23:58'),
('13', '5', '1', '4', '18-02-2019 16:54:43'),
('14', '5', '2', '5', '21-02-2019 19:13:55'),
('15', '5', '3', '4', '22-02-2019 21:57:25');
