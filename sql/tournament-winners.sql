-- CTE to combine scores for each playing position
with PlayerScores as (
    -- Combine scores where player is the first player
    select first_player as player_id, first_score as score from Matches
    union all
    -- Combine scores where player is the second player
    select second_player as player_id, second_score as score from Matches
),

-- CTE to aggregate total scores for each player
TotalScores as (
    select
        group_id,
        player_id,
        SUM(score) as total
    from Players
    left join PlayerScores using (player_id)
    group by 1, 2
    order by 1, 2
),

-- CTE to select the winner in each group
RankedPlayersByScore as (
    select distinct group_id,
        -- Use window function to determine the player with the highest score in each group
        -- In case of a tie, the player with the lowest player_id is chosen
        FIRST_VALUE(player_id) over (PARTITION BY group_id ORDER BY total desc, player_id) as player_id -- Winner player_id
    from TotalScores
)

select group_id, player_id from RankedPlayersByScore
