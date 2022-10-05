#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL "SELECT SUM(winner_goals) + SUM(opponent_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "SELECT AVG(winner_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "SELECT ROUND(AVG(winner_goals), 2) FROM games")"

echo -e "\nAverage number of goals in all games from both teams:"
echo "$($PSQL "SELECT AVG(winner_goals + opponent_goals) FROM games")"

echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL "SELECT MAX(winner_goals) FROM games")"

echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "SELECT COUNT(game_id) FROM games WHERE winner_goals > 2")"

echo -e "\nWinner of the 2018 tournament team name:"
echo "$($PSQL "SELECT t.name FROM games as g INNER JOIN teams as t on t.team_id = g.winner_id WHERE g.round = 'Final'and g.year = 2018")"

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo "$($PSQL " SELECT DISTINCT(t.name) FROM teams AS t LEFT JOIN games g1 ON g1.winner_id = t.team_id LEFT JOIN games g2 on g2.opponent_id = t.team_id WHERE (g1.year = 2014 or g2.year = 2014) AND (g1.round = 'Eighth-Final' or g2.round = 'Eighth-Final') ORDER BY t.name ")"

echo -e "\nList of unique winning team names in the whole data set:"
echo "$($PSQL " SELECT DISTINCT(t.name) FROM games as g INNER JOIN teams as t on t.team_id = g.winner_id ORDER BY t.name ")"

echo -e "\nYear and team name of all the champions:"
echo "$($PSQL " SELECT g.year, t.name FROM games as g INNER JOIN teams as t on t.team_id = g.winner_id WHERE g.round = 'Final' ORDER BY g.year ")"

echo -e "\nList of teams that start with 'Co':"
echo "$($PSQL " SELECT name FROM teams WHERE name LIKE 'Co%'")"

