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

int mapcount = 4;

PImage map, walkTile, grassTile, wallTile, tileImage, doorTile, buttonTile, buttonPressed, doorOpenTile, finishTile,windTile, mapOverlay, Player, enemy;

color tileColor;

String tileType;

Tile[][] tiles = new Tile[cols][rows];

MovingEnemy enemymove = new MovingEnemy(0, -1, 339, 300, true, 1);
//MovingEnemy enemymove2 = new MovingEnemy(3, 0, 340, 380, false, 2);
StaticEnemy enemystatic = new StaticEnemy(739, 20);

CollisionManager collisionmanager = new CollisionManager();

Coin[] coins = new Coin[nCoins];

SoundFile coinSound, buttonSound, finishSound;

/*
 * Method to execute code before the game starts
 */
void setup() {
  //decalring all images and sounds
  wallTile = loadImage("data/tiles/WallTile.png");
  grassTile = loadImage("data/tiles/GrassTile.png");
  walkTile = loadImage("data/tiles/WalkTile.png"); 
  doorTile = loadImage("data/tiles/DoorTile.png");
  buttonTile = loadImage("data/tiles/ButtonTile.png"); 
  buttonPressed = loadImage("data/tiles/ButtonPressed.png");
  doorOpenTile = loadImage("data/tiles/DoorOpenTile.png");
  finishTile = loadImage("data/tiles/FinishTile.png");
  windTile = loadImage("data/tiles/WindTile.png");
  Player = loadImage("data/Player/Player.png");
  enemy = loadImage("data/enemy/ant.png");

  coinSound = new SoundFile(this, "data/sounds/coin.wav");
  buttonSound = new SoundFile(this, "data/sounds/button.wav");
  finishSound = new SoundFile(this, "data/sounds/finish.wav");

  //looping thru all the coins
  for (int i = 0; i < nCoins; i++) {
    coins[i] = new Coin();
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
}

/*
 * Method where processing actually draws to the screen
 */
void draw() {

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

  //updating and drawing the player
  p.update();
  p.display();

  //displaying debug text(pressed keys)
  fill(0);
  textSize(24);
  text(s, 100, 50);

  //drawing the moving enemy if enabled
  if (enemymove.isEnabled) {
    enemymove.draw();
  }
  //enemymove2.draw();

  //drawing the static enemy
  enemystatic.draw();

  //checking all the collisions
  collisionmanager.CheckCollisionToWall();
  collisionmanager.CheckCollisionToEnemy();
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

  coinCounter = 0;

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

      if (x == 23 && y == 6)
      {
        println(hex(tileColor));
      }
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

          break;
        case "FFFF6A00" :
          //stationair enemy

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
  //dev code to load in a new map
  if (keyCode == 32) {
    updateMap("data/levels/level3.png", "data/levels/level3overlay.png");
    enemystatic.isEnabled = false;//disable static enemy for level 2
    enemymove.isEnabled = false;
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
