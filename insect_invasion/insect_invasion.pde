import processing.sound.*;

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

int mapcount = 1;

PImage map, walkTile, grassTile, wallTile, tileImage, doorTile, buttonTile, buttonPressed, doorOpenTile, finishTile, mapOverlay, Player, enemy;

color tileColor;

String tileType;

Tile[][] tiles = new Tile[cols][rows];

MovingEnemy enemymove = new MovingEnemy(0, -1, 339, 300, true, 1);
//MovingEnemy enemymove2 = new MovingEnemy(3, 0, 340, 380, false, 2);
StaticEnemy enemystatic = new StaticEnemy(739, 20);

CollisionManager collisionmanager = new CollisionManager();

Coin[] coins = new Coin[nCoins];

SoundFile coinSound, buttonSound, finishSound;

void setup() {

  wallTile = loadImage("data/tiles/WallTile.png");
  grassTile = loadImage("data/tiles/GrassTile.png");
  walkTile = loadImage("data/tiles/WalkTile.png"); 
  doorTile = loadImage("data/tiles/DoorTile.png");
  buttonTile = loadImage("data/tiles/ButtonTile.png"); 
  buttonPressed = loadImage("data/tiles/ButtonPressed.png");
  doorOpenTile = loadImage("data/tiles/DoorOpenTile.png");
  finishTile = loadImage("data/tiles/FinishTile.png");
  Player = loadImage("data/Player/Player.png");
  enemy = loadImage("data/enemy/ant.png");
  
  coinSound = new SoundFile(this, "data/sounds/coin.wav");
  buttonSound = new SoundFile(this, "data/sounds/button.wav");
  finishSound = new SoundFile(this, "data/sounds/finish.wav");


    for (int i = 0; i < nCoins; i++) { //loop voor coins

    coins[i] = new Coin();
  }


  s = "";          // om te kijken welke code bij de WASD keys hoort
  updateMap("levels/level0.png", "levels/level0overlay.png");    
  //looping thru all the tiles.
  left = false;
  right = false;
  up = false;
  down = false;
}

void draw() {

  //drawing all the tiles
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      tile = tiles[i][j]; 
      tile.tileCheck();
      tile.draw();
    }
  }

  for (int i = 0; i < nCoins; i++) { // tekent de coins
    coins[i].display();
  }

  p.update();
  p.display();

  fill(0);
  textSize(24);
  text(s, 100, 50);

  if (enemymove.isEnabled) {
    enemymove.draw();
  }
  //enemymove2.draw();
  enemystatic.draw();

  collisionmanager.CheckCollisionToWall();
  collisionmanager.CheckCollisionToEnemy();
  // collisionmanager.CheckCollisionToEnemy2();
  collisionmanager.CheckCollisionToFinish();
  //collisionmanager.EnemyToWall(enemymove);
  //collisionmanager.EnemyToWall(enemymove2);
}

void updateMap(String mapImage, String mapOverlayImage) {

  for (int j =0; j <nCoins; j++) {
    coins[j].isEnabled = false;
  }

  coinCounter = 0;
  map = loadImage(mapImage);
  mapOverlay = loadImage(mapOverlayImage);

  image(map, 0, 0);
  image(mapOverlay, 0, 18);
  //println(hex(get(13, 12)));
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
      default:
        tileType = "background"; 
        tileImage = grassTile;
      }
      tileColor = get(x, y + 18);
      Tile newTile = new Tile(w * x, h * y, w, h, tileType, hex(tileColor), tileImage);
      tiles[x][y] = newTile;
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

          p.place(x*w + 0.5*w, y*h + 0.5*h);
          break;
        }
      }
    }
  }
}

void keyPressed() {
  // println(keyCode);
  if (keyCode == 32) {
    updateMap("data/levels/level1.png", "data/levels/level1overlay.png");
    enemystatic.isEnabled = false;//disable static enemy for level 2
    enemymove.isEnabled = false;
    //enemymove2.isEnabled = true;//enable moving enemy for level 2
    collisionmanager.isEnabled = false;
    collisionmanager.isEnabled2 = true;
  }

  s = "key: " + keyCode;

  if (keyCode == 65)        // naar links bewegen
  {
    left = true;
  } else if (keyCode == 68) // naar rechts bewegen
  {
    right = true;
  } else if (keyCode == 87) // naar boven bewegen
  {
    up = true;
  } else if (keyCode == 83) // naar benden bewegen
  {
    down = true;
  }
}

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
