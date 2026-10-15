SELECT * FROM matches_analysis LIMIT 10;
select count(*) as total_matches from matches_analysis;

--ipl analysis using sql
select season,
count(*) as total_matches
from matches_analysis
group by season
order by season;

--team with most wins
select winner as team,
count(*) as total_wins
from matches_analysis
where winner is not null
group by winner
order by total_wins desc;

--top 10 players with the most player of the match awards
select player_of_match,
count(*) as awards
from matches_analysis
where player_of_match is not null
group by player_of_match
order by awards desc
limit 10;

--most frequent using stadium
select venue,
count(*) as matches_hosted
from matches_analysis
where venue is not null
group by venue
order by matches_hosted desc
limit 10;

--toss decisions
select toss_decision,
count(*) as total
from matches_analysis
where toss_decision is not null
group by toss_decision
order by total desc;

--does winning the toss help a team win the match
select count(*) as total_matches,
count(*) filter(
where toss_winner = winner
) as toss_winner_also_won,
round(
100.0 *count(*) filter(
where toss_winner= winner
)/ nullif(count(*) filter (
where winner is not null
),0),
2
) as toss_win_match_win_percentage
from matches_analysis;

--biggest victory margins
select id,
season,
team1,
team2,
winner,
result,
result_margin
from matches_analysis
where result_margin is not null
order by result_margin desc
limit 10;

--match wins by each team in each season
select season,
winner as team,
count(*) as wins
from matches_analysis
where winner is not null
group by season, winner
order by season, wins desc;

--check missing values in important columns
select count(*) filter (where winner is null) as missing_winner,
count(*) filter (where venue is null) as missing_venue,
count(*) filter (where player_of_match is null) as missing_player_award,
count(*) as total_rows
from matches_analysis;