#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
$PSQL "DROP TABLE teams, games"
$PSQL "CREATE TABLE teams(team_id SERIAL PRIMARY KEY, name VARCHAR(36) UNIQUE NOT NULL)"
$PSQL "CREATE TABLE games(game_id SERIAL PRIMARY KEY, year INT NOT NULL, round VARCHAR(36) NOT NULL, winner_goals INT NOT NULL, opponent_goals INT NOT NULL, winner_id INT NOT NULL REFERENCES teams(team_id), opponent_id INT NOT NULL REFERENCES teams(team_id) )"

cat games.csv | while IFS="," read year round winner opponent winner_goals opponent_goals
do
  if [[ $year != "year" ]]
  then
    # get winner_id
    winner_id=$($PSQL "SELECT team_id FROM teams WHERE name='$winner'") 

    # if not found
    if [[ -z $winner_id ]]
    then
      # inser winner
      $PSQL "INSERT INTO teams(name) VALUES('$winner')"
      #get his id
      winner_id=$($PSQL "SELECT team_id FROM teams WHERE name='$winner'") 
    fi

    # get opponent_id
    opponent_id=$($PSQL "SELECT team_id FROM teams WHERE name='$opponent'") 

    # if not found
    if [[ -z $opponent_id ]]
    then
      # inser winner
      $PSQL "INSERT INTO teams(name) VALUES('$opponent')"
      #get his id
      opponent_id=$($PSQL "SELECT team_id FROM teams WHERE name='$opponent'") 
    fi

    # insert game
    $PSQL "INSERT INTO games(year, round, winner_goals, opponent_goals, winner_id, opponent_id) VALUES($year, '$round', $winner_goals, $opponent_goals, $winner_id, $opponent_id)"
  fi
done