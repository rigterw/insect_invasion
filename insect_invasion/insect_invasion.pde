//importing the sound library
import processing.sound.*;

//importing the squelized related libraries
import samuelal.squelized.*;
import java.util.Properties;

/*
 * initializing the settings
 */
void settings() {
  size(1280, 720);
}

//developer settings
int testMap = 3;
boolean online = true;

//initializing all the variables
Tile tile;

boolean left, right, up, down, g, canWind, paused = false;
Player p = new Player();


//variables for the tilegrid
int cols = 32;
int rows = 18;
int w = 40;
int h = 40;

color tileColor;
String tileType;

//variables for the objects
int coinCounter = 0;
int nCoins = 75;
int mEnemys = 50; //Amount of moving enemys for in the array
int sEnemys = 50; //Amount of static enemys for in the array
int totalEnemys = mEnemys + sEnemys;
int movingEnemyCounter;
int staticEnemyCounter;



int mapCount = 6;
int currentMap = 0;
int nextMap;
int windSpeed = 10;
int screenSizeX = 1280;
int screenSizeY = 720;
int stage; // integer to keep track of the game state
/*
 * stage 1 = main menu
 * stage 2 = Easter egg
 * stage 3 = the running game
 * stage 4 = game over
 * stage 5 = highscores
 * stage 6 = pause
 * stage 7 = settings
 */



//initialises varables for pictures
PFont title;
PImage  map, mapOverlay;
PImage player, enemy, timeCoin;
PImage walkTile, oneWayNorth, oneWayEast, oneWaySouth, oneWayWest, grassTile, wallTile, tileImage, doorTile, buttonTile, buttonPressed, doorOpenTile, finishTile, windTile, startScreen;



String deathCause;

final int xPositionName = 400, yPosition = 100;
final int xPositionScores = xPositionName + 200;

//initializes the managers and database
SQLConnection connection;
DatabaseManager databasemanager = new DatabaseManager();
CollisionManager collisionmanager = new CollisionManager();






//initializes the games objects
Tile[][] tiles = new Tile[cols][rows];
Coin[] coins = new Coin[nCoins];
MovingEnemy[] movingEnemys = new MovingEnemy[mEnemys];
StaticEnemy[] staticEnemys = new StaticEnemy[sEnemys];
MainEnemy[] allEnemys = new MainEnemy [mEnemys + sEnemys];
Timer timer = new Timer();

SoundFile coinSound, buttonSound, finishSound, soundTrack,clickSound;

/*
 * Method to execute code before the game starts
 */
void setup() {
  
  //shows loading screen
  background(0);
  textAlign(CENTER);
  textSize(30);
  text("loading...", width/2, height/2);
  //declaring all images and sounds
  wallTile = loadImage("data/tiles/WallTile.png");
  grassTile = loadImage("data/tiles/GrassTile.png");
  walkTile = loadImage("data/tiles/WalkTile.png"); 
  oneWayNorth = loadImage("data/tiles/OneWayNorth.png");
  oneWayEast = loadImage("data/tiles/OneWayEast.png");
  oneWaySouth = loadImage("data/tiles/OneWaySouth.png");
  oneWayWest = loadImage("data/tiles/OneWayWest.png");
  doorTile = loadImage("data/tiles/DoorTile.png");
  buttonTile = loadImage("data/tiles/ButtonTile.png"); 
  buttonPressed = loadImage("data/tiles/ButtonPressed.png");
  doorOpenTile = loadImage("data/tiles/DoorOpenTile.png");
  finishTile = loadImage("data/tiles/FinishTile.png");
  windTile = loadImage("data/tiles/WindTile.png");
  player = loadImage("data/Player/Player.png");
  enemy = loadImage("data/enemy/ant.png");
  startScreen = loadImage("data/images/startScreen.png");
  timeCoin = loadImage("data/Player/TimeCoin.png");


  coinSound = new SoundFile(this, "data/sounds/coin.wav");
  buttonSound = new SoundFile(this, "data/sounds/button.wav");
  finishSound = new SoundFile(this, "data/sounds/finish.wav");
  clickSound = new SoundFile(this, "data/sounds/click.wav");
  soundTrack = new SoundFile(this, "data/sounds/soundtrack.wav");

  //connects the database    
  Properties props = new Properties();
  props.setProperty("user", "berkeln1");
  props.setProperty("password", "ytAT+sPYwZl7JH");


  if (online) {
    connection  = new MySQLConnection("jdbc:mysql://oege.ie.hva.nl/zberkeln1?serverTimezone=UTC", props);
  }



  //looping thru all the coins
  for (int i = 0; i < nCoins; i++) {
    coins[i] = new Coin();
  }


  //making array of MovingEnemys
  //puts all MovingEnemys in allEnemys Array
  for (int i = 0; i < mEnemys; i++) {
    MovingEnemy m = new MovingEnemy(3, 3);
    movingEnemys[i] = m;
    allEnemys[i] = m;
  }

  //making array of StaticEnemys
  //puts all StaticEnemys in allEnemys Array
  for (int i = 0; i < sEnemys; i++) {
    StaticEnemy s = new StaticEnemy();
    staticEnemys [i] = s;
    allEnemys[i+mEnemys] = s;
  }


  //updateing the map with the tutorial level
  updateMap("levels/level0.png", "levels/level0overlay.png");    

  //setting the moving directions of the player
  left = false;
  right = false;
  up = false;
  down = false;

  //playing and looping the music
  soundTrack.play();
  soundTrack.loop();

  //adjusting the volume of the sounds
  soundTrack.amp(0.1);
  buttonSound.amp(0.3);
  finishSound.amp(0.3);
  coinSound.amp(0.3);
  clickSound.amp(0.3);

  //setting the screen for the main menu
  image(startScreen, 0, 0, screenSizeX, screenSizeY);
  stage = 1;
}

/*
 * Method where processing actually draws to the screen
 */
void draw() {

  if (stage == 1) {
    //draws the start screen
    textAlign(CENTER);
    textSize(56);
    fill(#000000);
    text("press any key to continue except spatiebalk", screenSizeX / 2, screenSizeY / 2 + 325);
  } else if (stage == 2) {
    background(#000000);
    textAlign(CENTER);
    textSize(73);
    fill(#FFFFFF);
    text("WAT ZEIDEN WE NOU", screenSizeX / 2, screenSizeY / 2);
  } else if (stage == 3) {
    drawMap();
  } else if (stage == 4) {//draws game over screen
    databasemanager.showDeaths();
    textAlign(CENTER);
    textSize(73);
    fill(#FFFFFF);
    text("GAME OVER", screenSizeX / 2, 100);
    textSize(36);
    text("press X to view highscores", screenSizeX / 2, screenSizeY / 2 + 250);
    text("press A to restart", screenSizeX / 2, screenSizeY / 2 + 325);
  } else if (stage == 5) {//draws highscores screen
    textAlign(RIGHT);
    text("press A to restart", screenSizeX - 25, screenSizeY - 25);
  } else if (stage == 6) {//draws pause screen
    background(100, 200, 100);
    textAlign(CENTER);
    text("game paused", width/2, height/2);
  } else if( stage == 7) {//draws settings screen
     background(100, 200, 100);
    textAlign(CENTER);
    text("settings", width/2, height/2);
  }
}

/*
 * Method to draw the map
 */
void drawMap() {
  //drawing all the tiles
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      tile = tiles[i][j]; 
      tile.tileCheck();
      tile.draw();
    }
  }
  timer.drawTimer();
  //looping thru all the coins and draw them
  for (int i = 0; i < nCoins; i++) { // tekent de coins
    coins[i].display();
  }

  //Display the StaticEnemys from the array.
  for (int i = 0; i < sEnemys; i++) {
    staticEnemys[i].display();
  }
  //Display the MovingEnems from the array
  for (int i = 0; i < mEnemys; i++) {
    movingEnemys[i].display();
  }

  //updating and drawing the player
  p.update();
  p.display();
  p.playerTileX = int(p.x / 40);
  p.playerTileY = int(p.y / 40);

  //displaying debug text(pressed keys)
  fill(0);
  textSize(24);

  //checking all the collisions
  collisionmanager.CheckCollisionToWall();

  for (int i = 0; i < allEnemys.length; i++) {
    collisionmanager.CheckCollisionToEnemy(i);
  }
}
/*
 * Method to update the displayed map
 * @params String mapImage
 * @params String mapOverlayImage
 * @return void
 */
void updateMap(String mapImage, String mapOverlayImage) {

  //looping thru all the coins and disable them
  for (int j =0; j <nCoins; j++) {
    coins[j].isEnabled = false;
  }


  //Disable the moving enemys
  for (int i = 0; i < mEnemys; i++) {
    movingEnemys[i].isEnabled = false;
  }

  //Disable the static enemys
  for (int i = 0; i < sEnemys; i++) {
    staticEnemys[i].isEnabled = false;
  }

  coinCounter = 0;
  movingEnemyCounter = 0;
  staticEnemyCounter = 0;

  //loading in the map image and overlay
  map = loadImage(mapImage);
  mapOverlay = loadImage(mapOverlayImage);

  //drawing the map image and overlay
  image(map, 0, 0);
  image(mapOverlay, 0, 18);

  //looping thru all the tiles of the map and overlay
  for (int x = 0; x < cols; x++) {

    for (int y = 0; y < rows; y++) {
      tileColor = get(x, y);

      switch(hex(tileColor)) {
      case "FFCE7C38" :
        tileType = "walkable";
        tileImage = walkTile;
        canWind = true;
        break;
      case "FF000000":
        tileType = "wall";
        tileImage = wallTile;
        canWind = false;
        break;
      case"FF228A15" :
        tileType = "grass";
        tileImage = grassTile;
        canWind = false;
        break;
      case "FF0026FF" : 
        tileType = "door";
        tileImage = doorTile;
        canWind = false;
        break;
      case "FF4C64FF" : 
        tileType = "doorOpen";
        tileImage = doorOpenTile;
        canWind = true;
        break;
      case "FF00FFFF" : 
        tileType = "button";
        tileImage = buttonTile;
        canWind = true;
        break;
      case "FFF2FF02" : 
        tileType = "finish";
        tileImage = finishTile;
        canWind = true;
        break;
      case "FF7F3300":
        tileType = "enemywalkable";
        tileImage = walkTile;
        canWind = true;
        break;
      case "FFFF3819" :
        tileType = "enemyOneWay";
        tileImage = walkTile;
        canWind = true;
        break;
      case "FF404040":
        tileType = "oneWay";
        tileImage = oneWayNorth;
        canWind = true;
        break;
      case "FF808080":
        tileType = "windtile";
        tileImage = grassTile;
        canWind = false;
        break;
      case "FFCECECE":
        tileType = "windStop";
        tileImage = walkTile;
        canWind = false;
        break;
      default:
        tileType = "background"; 
        tileImage = grassTile;
        canWind = false;
      }
      //geting the tile color
      tileColor = get(x, y + 18);

      //create new tile
      Tile newTile = new Tile(w * x, h * y, w, h, tileType, hex(tileColor), tileImage, canWind);

      //put the tile in the array
      tiles[x][y] = newTile;
      //spawns the wind
      if (newTile.type.equals("windTile")) {
        newTile.spawnWind(x, y);
      }
    }
  }
  
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      
      //check if tile is walkable
      if (tiles[x][y].type == "walkable" || tiles[x][y].type == "enemywalkable") {
        switch(tiles[x][y].colour) {
        case "FFFFD800" :
          //coin aanroepen
          coins[coinCounter].place(x * w + 0.5 * w, y * h + 0.5 * h);
          coinCounter++;

          break;

        case "FFFF0000" :
          //moving enemy aanroepen
          movingEnemys[movingEnemyCounter].placeMovingEnemy(x * w + 0.5 * w, y * h + 0.5 * h);
          movingEnemys[movingEnemyCounter].pathcheck(tiles[x][y]);

          movingEnemyCounter++;

          break;
        case "FFFF6A00" :
          //stationair enemy
          staticEnemys[staticEnemyCounter].placeStaticEnemy(x * w + 0.5 * w, y * h + 0.5 * h);
          staticEnemyCounter++;

          break;
        case "FF00FF21":
          //respawning the player
          p.place(x*w + 0.5*w, y*h + 0.5*h);
          break;
        }
      }
    }
  }
  updateWind();
}

//this function updates all the wind
void updateWind() {
  for (int xTile = 0; xTile < cols; xTile++) {
    for (int yTile = 0; yTile < rows; yTile++) {
      tiles[xTile][yTile].hasWind = false;
    }
  }

  for (int xTile = 0; xTile < cols; xTile++) {
    for (int yTile = 0; yTile < rows; yTile++) {
      if (tiles[xTile][yTile].type == "windtile") {
        tiles[xTile][yTile].spawnWind(xTile, yTile);
      }
    }
  }  
}




/*
 * method to check if a key is pressed on the keyboard
 */
void keyPressed() {
  if (stage == 4 && keyCode == 82) {//restarts the game from game over screen
    stage = 3;
    databasemanager.insertValues();
    nextMap = int(random(1, mapCount + 1));
    updateMap("data/levels/level" + str(nextMap) + ".png", "data/levels/level" + str(nextMap) + "overlay.png") ;

    timer.time = timer.maxTime;
    timer.lastTime = millis();
    p.score = 0;
 
  } else if (stage == 4 && keyCode == 72) {//loads the highscore screen
    databasemanager.drawHighScores();
    stage = 5;
    return;
  } else if ( stage == 4 && keyCode != 82 && keyCode != 72) {
    println("not 82 or 72");
    return;
  }
  if (stage == 3 && keyCode == 70) {//pauses the game
    paused = true;
    stage = 6;
  }
  if (stage == 6 && keyCode == 71) {//resumes the game
    timer.lastTime = millis();
    stage = 3;    
    paused = false;
  }
  if (stage == 5 && keyCode == 82) {//restarts the game from highscores
    updateMap("levels/level0.png", "levels/level0overlay.png");
    stage = 3;
    timer.time = timer.maxTime;
    timer.lastTime = millis();
    p.score = 0;
  } else if (stage == 5 && keyCode != 82) {
    println("not 82");
    return;
  }

  if (stage == 1) {
    timer.lastTime = millis();
  } else if (stage == 2) {
    timer.lastTime = millis();
  }
  //changing the stage to launch game from main menu
  //dev code to load in a new map
  if (keyCode == 32) {
    if (stage == 1) {
      stage = 2;
      return;
    } else if (stage == 3) {
      updateMap("levels/level"+testMap+".png", "levels/level"+testMap+"overlay.png");
      currentMap = testMap;
    }
  }

  if (stage == 1) {//loads the first level from start screen
    stage = 3;
  }


  //checking if the player wants to move to the left
  if (keyCode == 65)
  {
    left = true;
  }
  //checking if the player wants to move to the right
  else if (keyCode == 68)
  {
    right = true;
  }
  //checking if the player wants to move upwards
  else if (keyCode == 87)
  {
    up = true;
  } 
  //checking if the player wants to move downwards
  else if (keyCode == 83)
  {
    down = true;
  }
}

/*
 * method to check if a key is released on the keyboard
 */
void keyReleased()
{
  if (keyCode == 32) {
    stage = 3;
  }
  if (keyCode == 65)        // naar links bewegen
  {
    left = false;
  } else if (keyCode == 68) // naar rechts bewegen
  {
    right = false;
  } else if (keyCode == 87) // naar boven bewegen
  {
    up = false;
  } else if (keyCode == 83) // naar benden bewegen
  {
    down = false;
  }
}
