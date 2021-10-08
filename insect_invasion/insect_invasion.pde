void settings() {
  size(1280, 720);
}

//initializing all the variables
Tile tile;

int cols = 32;
int rows = 18;

int w = 40;
int h = 40;

PImage map;

color tileColor;

String tileType;

Tile[][] tiles = new Tile[cols][rows];

void setup() {

  updateMap("level1.png");

  //looping through all the tiles.
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
        break;
      case "FF000000":
        tileType = "wall";
        break;
      case"FF228A15" :
        tileType = "grass";
        break;
      default:
        tileType = "background";
      }

      Tile newTile = new Tile(w * x, h * y, w, h, tileType, hex(tileColor));
      tiles[x][y] = newTile;
    }
  }
}

void keyPressed() {
  println(keyCode);
  if (keyCode == 32) {
    updateMap("level3.png");
  }
}
//text
