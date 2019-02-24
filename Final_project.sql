1. Посчитать число книг без оценок

Select count(*) from book_ratings right join Books on books.id=Book_ratings.book_id where Book_ratings.rating is null ;

2. Вывести список книг и их средний рейтинг

Select name, avg(rating) from Book_ratings right join Books on Books.id=Book_ratings.book_id group by books.name;

3. Вывести название жанров, количество книг и средний рейтинг каждого жанра



4. Вывести список логинов 3 пользователей, у которых средний рейтинг выше 3.5

select login, avg(rating) from Readers inner join Book_ratings on readers.id=Book_ratings.reader_id  
group by reader_id, login having avg(rating)>3.5 limit 3;

5. Вывести список названий книг с макимальной оценкой

with avg_rate as ( select book_id, avg(rating) as avg from Book_ratings group by book_id ) 
select books.name, avg from avg_rate inner join Books on Books.id=avg_rate.book_id 
where avg in( select max(avg) from avg_rate limit 1);


6. Вывести список пользователей с максимальным количеством оценок и среднюю оценку



7. Вывести названия книг, у которых минимум 3 оценки и средний рейтинг выше 3.5
8. Вывести список авторов, количество их книг и средний рейтинг книг этого автора
9. Вывести список авторов, у которых есть книги хотя бы в 2 жанрах и количество их книг
10. Вывести список жанров, автора с макимальной оценкой у книги выбранного жанра и эту оценку
