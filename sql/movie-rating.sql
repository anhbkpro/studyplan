# Write your MySQL query statement below
with person_rate as (
    select name
    from movieRating
    join users
    using (user_id)
    group by user_id
    order by count(1) desc, name
    limit 1
),
movie_rate as (
    select title
    from movieRating
    join movies
    using (movie_id)
    where created_at >= '2020-02-01' and created_at < '2020-03-01'
    group by movie_id
    order by avg(rating) desc, title
    limit 1
)
select name as results from person_rate
union all
select title as results from movie_rate
