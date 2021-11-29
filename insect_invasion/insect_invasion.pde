//importing the sound library
import processing.sound.*;

/*
 * initializing the settings
 */
void settings() {
  size(1280, 720);
}

//initializing all the variables
Tile tile;

boolean left, right, up, down, g;
Player p = new Player();
String s;

int cols = 32;
int rows = 18;

int w = 40;
int h = 40;
int coinCounter = 0;
int nCoins = 75;
int mEnemys = 50; //Amount of moving enemys for in the array
int sEnemys = 50; //Amount of static enemys for in the array
int movingEnemyCounter;
int staticEnemyCounter;

int mapcount = 1;

int screenSizeX = 1280;
int screenSizeY = 720;
int stage;

PFont title;

PImage map, walkTile, oneWayTile, grassTile, wallTile, tileImage, doorTile, buttonTile, buttonPressed, doorOpenTile, finishTile, mapOverlay, windTile, Player, enemy, startScreen;

color tileColor;

String tileType;

Tile[][] tiles = new Tile[cols][rows];

//MovingEnemy enemymove = new MovingEnemy(0, -1, 339, 300, true, 1);
//MovingEnemy enemymove2 = new MovingEnemy(3, 0, 340, 380, false, 2);
StaticEnemy enemystatic = new StaticEnemy();

CollisionManager collisionmanager = new CollisionManager();

Coin[] coins = new Coin[nCoins];
MovingEnemy[] movingEnemys = new MovingEnemy[mEnemys];
StaticEnemy[] staticEnemys = new StaticEnemy[sEnemys];

SoundFile coinSound, buttonSound, finishSound, soundTrack;

/*
 * Method to execute code before the game starts
 */
void setup() {
  //decalring all images and sounds
  wallTile = loadImage("data/tiles/WallTile.png");
  grassTile = loadImage("data/tiles/GrassTile.png");
  walkTile = loadImage("data/tiles/WalkTile.png"); 
  oneWayTile = loadImage("data/tiles/OneWayTile.png");
  doorTile = loadImage("data/tiles/DoorTile.png");
  buttonTile = loadImage("data/tiles/ButtonTile.png"); 
  buttonPressed = loadImage("data/tiles/ButtonPressed.png");
  doorOpenTile = loadImage("data/tiles/DoorOpenTile.png");
  finishTile = loadImage("data/tiles/FinishTile.png");
  windTile = loadImage("data/tiles/Wind.gif");
  Player = loadImage("data/Player/Player.png");
  enemy = loadImage("data/enemy/ant.png");
  startScreen = loadImage("data/images/startScreen.png");


  coinSound = new SoundFile(this, "data/sounds/coin.wav");
  buttonSound = new SoundFile(this, "data/sounds/button.wav");
  finishSound = new SoundFile(this, "data/sounds/finish.wav");
  soundTrack = new SoundFile(this, "data/sounds/soundtrack.wav");

  //looping thru all the coins
  for (int i = 0; i < nCoins; i++) {
    coins[i] = new Coin();
  }

  //StaticEnemys array vullen
  for (int i = 0; i < sEnemys; i++) {
    staticEnemys[i] = new StaticEnemy();
  }

  //MovingEnemys array vullen
  for (int i = 0; i <mEnemys; i++) {
    movingEnemys[i] = new MovingEnemy(3, 3);
  }

  //variable to look what code belongs to the WASD keys
  s = "";

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

  //setting the screen for the main menu
  image(startScreen, 0, 0, screenSizeX, screenSizeY);
  stage = 1;
}

/*
 * Method where processing actually draws to the screen
 */
void draw() {
  if (stage == 1) {
    textAlign(CENTER);
    textSize(75);
    text("INSECT INVASION", screenSizeX / 2, screenSizeY / 2 - 100);
    textSize(56);
    text("press any key to continue", screenSizeX / 2, screenSizeY / 2 + 100);
  } else if (stage == 2) {
    drawMap();
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

  //displaying debug text(pressed keys)
  fill(0);
  textSize(24);
  text(s, 100, 50);

  //drawing the moving enemy if enabled
  //if (enemymove.isEnabled) {
  //  enemymove.draw();
  //}
  ////enemymove2.draw();

  ////drawing the static enemy
  //enemystatic.draw();

  //checking all the collisions
  collisionmanager.CheckCollisionToWall();
  for (int i = 0; i < mEnemys; i++) {
    collisionmanager.CheckCollisionToEnemy(i);
  }
  collisionmanager.CheckCollisionToFinish();
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
  println(hex(get(9, 4)));
  //looping thru all the tiles of the map and overlay
  for (int x = 0; x < cols; x++) {

    for (int y = 0; y < rows; y++) {

      tileColor = get(x, y);

      switch(hex(tileColor)) {
      case "FFCE7C38" :
        tileType = "walkable";
        tileImage = walkTile;
        break;
      case "FF000000":
        tileType = "wall";
        tileImage = wallTile;
        break;
      case"FF228A15" :
        tileType = "grass";
        tileImage = grassTile;
        break;
      case "FF0026FF" : 
        tileType = "door";
        tileImage = doorTile;
        break;
      case "FF4C64FF" : 
        tileType = "doorOpen";
        tileImage = doorOpenTile;
        break;
      case "FF00FFFF" : 
        tileType = "button";
        tileImage = buttonTile;
        break;
      case "FFF2FF02" : 
        tileType = "finish";
        tileImage = finishTile;
        break;
      case "FF7F3300":
        tileType = "enemywalkable";
        tileImage = walkTile;
        break;
      case "FFFF3819" :
        tileType = "enemyOneWay";
        tileImage = walkTile;
        break;
      case "FF404040":
        tileType = "oneWay";
        tileImage = oneWayTile;
        break;
      case "FF808080":
        tileType = "windtile";
        tileImage = windTile;
        break;
      default:
        tileType = "background"; 
        tileImage = grassTile;
      }
      //geting the tile color
      tileColor = get(x, y + 18);

      //create new tile
      Tile newTile = new Tile(w * x, h * y, w, h, tileType, hex(tileColor), tileImage);

      //put the tile in the array
      tiles[x][y] = newTile;

      //check if tile is walkable
      if (tiles[x][y].type == "walkable" || tiles[x][y].type == "enemywalkable") {
        switch(hex(tileColor)) {
        case "FFFFD800" :
          //coin aanroepen
          coins[coinCounter].place(x * w + 0.5 * w, y * h + 0.5 * h);
          coinCounter++;

          break;

        case "FFFF0000" :
          //moving enemy aanroepen
          movingEnemys[movingEnemyCounter].placeMovingEnemy(x * w + 0.5 * w, y * h + 0.5 * h);
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
}

/*
 * method to check if a key is pressed on the keyboard
 */
void keyPressed() {

  //changing the stage to launch game from main menu
  if (stage == 1) {
    stage = 2;
  }

  //dev code to load in a new map
  if (keyCode == 32) {
    updateMap("data/levels/level3.png", "data/levels/level3overlay.png");
    //enemystatic.isEnabled = false;//disable static enemy for level 2
    //enemymove.isEnabled = false;
    //enemymove2.isEnabled = true;//enable moving enemy for level 2
  }

  //setting the debug text to the pressed key
  s = "key: " + keyCode;

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
