void settings() {
  size(1280, 720);
}

//initializing all the variables
Tile tile;
Coin coin1;

boolean left, right, up, down;
Player p;
String s;

int cols = 32;
int rows = 18;

int w = 40;
int h = 40;

PImage map, walkTile, grassTile, wallTile, tileImage, doorTile, buttonTile, doorOpenTile, cobwebTile, finishTile;

color tileColor;

String tileType;

Tile[][] tiles = new Tile[cols][rows];

void setup() {

  wallTile = loadImage("tiles/WallTile.png");
  grassTile = loadImage("tiles/GrassTile.png");
  walkTile = loadImage("tiles/WalkTile.png"); 
  doorTile = loadImage("tiles/DoorTile.png");
  buttonTile = loadImage("tiles/ButtonTile.png"); 
  doorOpenTile = loadImage("tiles/DoorOpenTile.png");
  cobwebTile = loadImage("tiles/CobwebTile.png");
  finishTile = loadImage("tiles/FinishTile.png");

  updateMap("levels/level1.png");    
  //looping thru all the tiles.

  p = new Player();
  s = "";          ///////////  om te kijken welke code bij de WASD keys hoort

  left = false;
  right = false;
  up = false;
  down = false;
  
  coin1 = new Coin(); 
  coin1.isEnabled = true;


  
}

void draw() {

  //drawing all the tiles
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      tile = tiles[i][j]; 
      tile.draw();
    }
  }
  
  p.update();
  p.display();
  
  fill(0);
  textSize(24);
  text(s, 100, 50);
  
  if (coin1.isEnabled == true) { 
    coin1.draw(); } 
}

void updateMap(String mapImage) {


  map = loadImage(mapImage);

  image(map, 0, 0);
 
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
      case "FF404040" : 
        tileType = "cobweb";
        tileImage = cobwebTile;
        break;
              case "FFF2FF02" : 
        tileType = "finish";
        tileImage = finishTile;
        break;
        
      default:
        tileType = "background"; 
        tileImage = grassTile;
      }
      Tile newTile = new Tile(w * x, h * y, w, h, tileType, hex(tileColor), tileImage);
      tiles[x][y] = newTile;
    }
  }
}

void keyPressed() {
  println(keyCode);
  if (keyCode == 32) {
    updateMap("levels/level3.png");
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
   if (keyCode == 65)        // links bewegen
  {
    left = false;
  } else if (keyCode == 68) // rechts bewegen
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
