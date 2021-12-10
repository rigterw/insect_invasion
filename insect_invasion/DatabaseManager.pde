class DatabaseManager{
void drawGameOver() 
{

  background(52, 190, 130);
  textSize(32);
  fill(208, 98, 36);

  Properties props = new Properties();
  props.setProperty("user", "berkeln1");
  props.setProperty("password", "ytAT+sPYwZl7JH");
  SQLConnection myConnection = new MySQLConnection("jdbc:mysql://oege.ie.hva.nl/zberkeln1?serverTimezone=UTC", props);
  insertDeath(myConnection);
  insertNewHighscore(myConnection);
  showHighscores (myConnection);
}

void onlyInsertNewHighscore() {
  Properties props = new Properties();
  props.setProperty("user", "berkeln1");
  props.setProperty("password", "ytAT+sPYwZl7JH");
  SQLConnection myConnection = new MySQLConnection("jdbc:mysql://oege.ie.hva.nl/zberkeln1?serverTimezone=UTC", props);
  insertDeath(myConnection);
  insertNewHighscore(myConnection);
}

void insertNewHighscore(SQLConnection connection) {
  String name = "Insect";
  connection.updateQuery("INSERT INTO Highscore (name, highscore) VALUES(\""+ name + "\", "+ p.score +");");
}

void insertDeath(SQLConnection connection) {
  connection.updateQuery("INSERT INTO Deaths (map, xPos, yPos, cause) VALUES('"+ currentMap +"', '"+ p.x +"', '"+ p.y +"', '"+ deathCause +"');");
}

void showHighscores(SQLConnection connection) {
  Table highscores = connection.runQuery("SELECT name, highscore FROM Highscore ORDER BY highscore DESC");
  textAlign(LEFT);
  text("NAME", xPositionName, yPosition);
  text("HIGHSCORE", xPositionScores, yPosition);
  text("________________________", xPositionName, yPosition + 10);

  for (int i = 0; i < highscores.getRowCount(); i++) {
    TableRow row = highscores.getRow(i);
    text(row.getString(0), xPositionName, yPosition + (i+1) * 50);
    text(row.getString(1), xPositionScores, yPosition + (i+1) * 50);
  }
}

//void showDeaths(SQLConnection connection){
//  Table deathLocation = connection.runQuery("SELECT 
  
  
  
  
//}
}
