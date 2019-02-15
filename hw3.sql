SELECT 'ФИО: Ковалева Ирина';

""
select userId, movieId,
       (rating - min(rating) over (partition by userId))/(max(rating) over (partition by userid) - min(rating) over (partition by userId)) as normed_rating,
       avg(rating) over (partition by userId) as avg_rating
from (select distinct userid, movieId, rating from ratings) as rate
limit 30;

create table if not exists "keywords" (
  movieid bigint,
  tags text
);

""

create table if not exists "keywords" (
  movieid bigint,
  tags text
);

with top_rates as (select distinct movieId,
      avg(rating) over (partition by movieId) as avg_rating
from (select movieId, rating from
            (select movieid, rating, count(rating) over (partition by movieId) as cnt from ratings) as bb
            where cnt>50) as z1
order by avg_rating desc, movieId
limit 150) select top_rates.movieId, avg_rating, tags into public.top_tags from top_rates join keywords on top_rates.movieId=keywords.movieid;

copy (select * from top_tags) to '/tmp/top_rated_tags.csv' with csv header delimiter as E'\t';
