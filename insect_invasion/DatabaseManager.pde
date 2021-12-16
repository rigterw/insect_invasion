class DatabaseManager {

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
    String name = "insect";
    connection.updateQuery("INSERT INTO Highscore (name, highscore) VALUES('"+ name + "', '"+ p.score +"');");
  }

  //adds the death position and cause to the deaths table
  void insertDeath() {

    connection.updateQuery("INSERT INTO Deaths (map, xPos, yPos, xTile, yTile, cause) VALUES('"+ currentMap +"', '"+ p.x +"', '"+p.y+"', '"+ p.playerTileX +"', '"+ p.playerTileY +"', '"+ deathCause +"');");
  }
  //shows the highscores on the highscores screen
  void showHighscores() {
 
    textAlign(LEFT);
    text("NAME", xPositionName, yPosition);
    text("HIGHSCORE", xPositionScores, yPosition);
    text("________________________", xPositionName, yPosition + 10);
    if (online) {
         Table highscores = connection.runQuery("SELECT name, highscore FROM Highscore ORDER BY highscore DESC");
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
