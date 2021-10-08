void settings() {
  size(1280, 720);
}

//initializing all the variables
Tile tile;

int cols = 32;
int rows = 18;

int w = 40;
int h = 40;

PImage map, walkTile, grassTile, wallTile, tileImage;

color tileColor;

String tileType;

Tile[][] tiles = new Tile[cols][rows];

void setup() {
  wallTile = loadImage("tiles/WallTile.png");
  grassTile = loadImage("tiles/GrassTile.png");
  walkTile = loadImage("tiles/WalkTile.png"); 
  
  updateMap("levels/level1.png");    
  //looping th  ru all the tiles.
}

void draw() {

  //drawing all the tiles
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      tile = tiles[i][j]; 
      tile.draw();
    }
  }
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
      default:
        tileType = "background"; 
        tileImage = grassTile;
    }
      Tile newTile = new Tile(w * x, h * y, w, h, tileType, hex(tileColor),tileImage);
      tiles[x][y] = newTile;
    }
  }
}

void keyPressed() {
  println(keyCode);
  if (keyCode == 32) {
    updateMap("levels/level3.png");
  }
}
