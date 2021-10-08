class Tile 
{

  float x, y; //x en y position
  float w, h; // tile width and height
  String type; //tile type
  String colour; //tile colour
  PImage tile;

  Tile(float x, float y, float w, float h, String type, String colour) 
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.type = type;
    this.colour = colour;
  }

  void draw() {
    //fill(unhex(colour));
    switch(type) {
    case "wall" :
      tile = loadImage("WallTile.png");
      image(tile, x, y);
      break;
    case "grass" :
      tile = loadImage("GrassTile.png");
      image(tile, x, y);
      break;
      case "walkable" :
      tile = loadImage("WalkTile.png");
      image(tile,x,y);
      break;
    }
    //rect(x, y, w, h);
  }
}
