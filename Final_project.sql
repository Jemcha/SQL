1. Посчитать число книг без оценок

Select count(*) from book_ratings right join Books on books.id=Book_ratings.book_id where Book_ratings.rating is null ;

2. Вывести список книг и их средний рейтинг

Select name, avg(rating) from Book_ratings right join Books on Books.id=Book_ratings.book_id group by books.name;

3. Вывести название жанров, количество книг и средний рейтинг каждого жанра

select Genres.name, count(distinct Books.id), avg(rating) from books inner join Genres on Books.genre_id=Genres.id 
inner join Book_ratings on Book_ratings.book_id=Books.id group by Genres.id;

4. Вывести список логинов 3 пользователей, у которых средний рейтинг выше 3.5

select login, avg(rating) from Readers inner join Book_ratings on readers.id=Book_ratings.reader_id  
group by reader_id, login having avg(rating)>3.5 limit 3;

5. Вывести список названий книг с макимальной оценкой

with avg_rate as ( select book_id, avg(rating) as avg from Book_ratings group by book_id ) 
select books.name, avg from avg_rate inner join Books on Books.id=avg_rate.book_id 
where avg in( select max(avg) from avg_rate limit 1);


6. Вывести список пользователей с максимальным количеством оценок и среднюю оценку

select login, cnt, avg from 
(select distinct reader_id, count(rating) over (partition by reader_id) as cnt, avg(rating) over (partition by reader_id) as avg 
from book_ratings) as cnt_avg
inner join Readers on cnt_avg.reader_id=Readers.id 
where cnt in (select count(rating) over (partition by reader_id) cnt_rt from Book_ratings order by cnt_rt desc limit 1);


7. Вывести названия книг, у которых минимум 3 оценки и средний рейтинг выше 3.5

select name, avg, cnt from ( select distinct books.name, count(rating) over (partition by book_id) cnt, avg(rating) over (partition by book_id) avg
from Book_ratings inner join Books on Books.id=Book_ratings.book_id) cnt_avg where cnt_avg.cnt>2 AND cnt_avg.avg>3.5;

8. Вывести список авторов, количество их книг и средний рейтинг книг этого автора

select distinct authors.name, count(distinct Books.name), avg(rating) from Books left join Book_ratings on Books.id=Book_ratings.book_id
  inner join Authors on Books.author_id=Authors.id group by Authors.name;

9. Вывести список авторов, у которых есть книги хотя бы в 2 жанрах и количество их книг

select authors.name,  rnk_cnt.cnt from (select author_id, genre_id, count(id) over (partition by author_id) cnt, rank() over (partition by author_id order by genre_id desc) rnk from Books) rnk_cnt
inner join Authors on Authors.id=rnk_cnt.author_id where rnk_cnt.rnk>1;

10. Вывести список жанров, для каждого список книг с максимальной средней оценкой, авторов этих книг и эту оценку

select authors.name, inters.name, year from( (select year, author_id, name from books where year>1995)
intersect
(select year, author_id, name from Books where year<2000)) as inters inner join Authors on inters.author_id=Authors.id
;
