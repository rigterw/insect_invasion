class Tile 
{
  int count;
  float x, y; //x en y position
  float w, h; // tile width and height
  String type; //tile type
  String colour; //tile colour
  PImage tile;
  Boolean buttonStandingOn = false;
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


  void tileCheck() {
//code voor de deur
      if ( (x + h > p.x && p.x > x) && (y + h > p.y && p.y > y)) {
    if ( type == "button") {
        if (buttonStandingOn == false) {       
          for (int xTile = 0; xTile < cols; xTile++) {

            for (int yTile = 0; yTile < rows; yTile++) { 
              if (tiles[xTile][yTile].colour.equals(colour)) {  

                if (tiles[xTile][yTile].type == "door" ) {
                  tiles[xTile][yTile].type = "doorOpen";
                  tiles[xTile][yTile].tile = doorOpenTile;
                } else if (tiles[xTile][yTile].type == "doorOpen") {

                  tiles[xTile][yTile].type = "door"; 
                  tiles[xTile][yTile].tile = doorTile;
                }
              }
            }
          }
          buttonStandingOn = true;
        }
      } 
 else if (type == "finish") {//code voor finish + volgend level
   String map = str(int(random(1,mapcount + 1)));
      updateMap("levels/level" + map + ".png", "levels/level" + map + "overlay.png") ;
    
      
    buttonStandingOn = false;}
    }
  else { buttonStandingOn = false;}
  }
  void draw() {
    if (type == "door" || type == "doorOpen" || type == "button") {
if(type == "door" || type == "doorOpen"){
  image(walkTile, x, y);
}
      if (buttonStandingOn) {
        tint(unhex(colour) + unhex("FF202020"));
      } else { 
        tint(unhex(colour));
      }
    } else {
      noTint();
    }
    image(tile, x, y);
  }
}
