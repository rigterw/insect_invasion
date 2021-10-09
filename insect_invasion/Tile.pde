class Tile 
{

  float x, y; //x en y position
  float w, h; // tile width and height
  String type; //tile type
  String colour; //tile colour
  PImage tile;

  Tile(float x, float y, float w, float h, String type, String colour, PImage tile) 
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.type = type;
    this.colour = colour;
    this.tile = tile;
  }

  void draw() {
if(type == "door" || type == "doorOpen" || type == "button"){


tint(unhex(colour));
}
else {
  noTint();
}
      image(tile,x,y);
  }
}
