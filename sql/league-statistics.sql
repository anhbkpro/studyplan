select t.team_name,
COUNT(*) as matches_played,
SUM(
    CASE
        WHEN (m.home_team_id = t.team_id AND m.home_team_goals > m.away_team_goals)
        OR (m.away_team_id = t.team_id AND m.away_team_goals > m.home_team_goals)
        THEN 3
        WHEN m.home_team_goals = m.away_team_goals THEN 1
        ELSE 0
    END
) as points,
SUM(
    CASE WHEN m.home_team_id = t.team_id THEN m.home_team_goals ELSE m.away_team_goals END
) as goal_for,
SUM(
    CASE WHEN m.home_team_id = t.team_id THEN m.away_team_goals ELSE m.home_team_goals END
) as goal_against,
SUM(
    CASE WHEN m.home_team_id = t.team_id THEN m.home_team_goals - m.away_team_goals ELSE m.away_team_goals - m.home_team_goals END
) as goal_diff
from teams t
join matches m
on m.home_team_id = t.team_id
or m.away_team_id = t.team_id
group by 1
order by
    points desc,
    goal_diff desc,
    team_name
