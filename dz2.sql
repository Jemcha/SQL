SELECT 'ФИО: Ковалева Ирина';

--1.1
SELECT *
from public.ratings
limit 10;
--1.2.1
select *
from public.links
where imdbid like '%42' and movieid between 101 and 999
limit 10;

--1.2.2
select *
from public.links
where imdbid like '%42' and movieid>100 and movieid<1000
limit 10;

--2.1
select links.imdbid, ratings.rating
from public.links
inner join public.ratings
on links.movieid=ratings.movieid
where ratings.rating=5
limit 10;

--3.1
select
count (movieid)
from public.ratings
where ratings.rating is null
limit 10;

--3.2
select
userid as top10,
avg(rating) as avg_rate
from public.ratings
group by userid
having avg(rating) > 3.5
order by avg_rate desc
limit 10;

--4.1
select imdbid
from public.links
where movieid in (
    select movieid
    from public.ratings
    group by movieid
    having avg(rating) > 3.5
    )
limit 10;

--4.2
with rate
as (
select userid
from public.ratings
group by userid
having count(userid) > 10
    )
select userid, avg(rating) as avg_rate
from public.ratings
where userid in (select userid from rate)
group by userid
limit 10;
