class DatabaseManager {

  String name = nameinput.name;

  //shows the highscores
  void drawHighScores() {
    background(52, 190, 130);
    textSize(32);
    fill(208, 98, 36); 

    insertValues();
    showHighscores ();
  }

  //adds data to the database
  void insertValues() {
    if (online) {
      insertDeath();
      insertNewHighscore();
    }
  }

  //adds score to the highscore table
  void insertNewHighscore() {
    connection.updateQuery("INSERT INTO Highscore (name, highscore) VALUES('"+ name + "', '"+ p.score +"');");
  }

  //adds the death position and cause to the deaths table
  void insertDeath() {
    connection.updateQuery("INSERT INTO Deaths (map, xPos, yPos, xTile, yTile, cause) VALUES('"+ currentMap +"', '"+ p.x +"', '"+p.y+"', '"+ p.playerTileX +"', '"+ p.playerTileY +"', '"+ deathCause +"');");
  }

  /*
  * Method to insert a new Achievement
   * @return void
   */
  void insertAchievement() {
    connection.updateQuery("INSERT INTO Player_has_Achievements (Player_playerId, Achievements_achievementName, is_achieved) VALUES (" + playerId + ", '" + lastAchievement + "' , '" + "true');" );
  }

  /*
  * Method to insert a new Player
   * @return void
   */
  void createNewPlayer() {
    connection.updateQuery("INSERT INTO Player (name) VALUES ('"+name+"');");
  }

  /*
  * Method to get the latest player
   * @return void
   */
  void getLatestPlayer() {
    Table player = connection.runQuery("SELECT playerId FROM Player ORDER BY playerId  DESC LIMIT 1");
    TableRow row = player.getRow(0);
    playerId = int(row.getString(0));
  }

  boolean isAchievementAchieved(String achievementName) {
    Table player_has_achievement = connection.runQuery("SELECT is_achieved FROM Player_has_Achievements WHERE Player_playerId = " + playerId + " AND Achievements_achievementName = '" + achievementName + "';");
    TableRow row = player_has_achievement.getRow(0);

    //array exception 
    try {
      boolean achieved = boolean(row.getString(0));
      return true;
    }
    catch (Exception E) {
      return false;
    }
  }


  //shows the highscores on the highscores screen
  void showHighscores() {

    textAlign(LEFT);
    text("NAME", xPositionName, yPosition);
    text("HIGHSCORE", xPositionScores, yPosition);
    text("________________________", xPositionName, yPosition + 10);
    if (online) {
      Table highscores = connection.runQuery("SELECT name, highscore FROM Highscore ORDER BY highscore DESC LIMIT 0, 10");
      for (int i = 0; i < highscores.getRowCount(); i++) {
        TableRow row = highscores.getRow(i);
        text(row.getString(0), xPositionName, yPosition + (i+1) * 50);
        text(row.getString(1), xPositionScores, yPosition + (i+1) * 50);
      }
    } else {

      image(noConnection, width/2-180, height/2-100, 240, 200);
    }
  }


  //shows the deathpoints on the map
  void showDeaths() {
    if (online) {
      Table deathLocation = connection.runQuery("SELECT xPos, yPos FROM Deaths WHERE map ="+ currentMap +" AND cause !='time';");

      for (int i=0; i<deathLocation.getRowCount(); i++) {
        TableRow row = deathLocation.getRow(i);
        int Xpos = row.getInt(0), Ypos = row.getInt(1);
        fill(255, 0, 0);
        circle(Xpos, Ypos, 10);
      }
    }
  }
}
