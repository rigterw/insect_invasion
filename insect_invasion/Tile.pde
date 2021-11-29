class Tile 
{
  int count; //The amount of tiles
  float x, y; //X en y position
  float w, h; //Tile width and height
  String type; //Tile type
  String colour; //Tile colour
  String direction;
  PImage tile; // Tile image
  Boolean buttonStandingOn = false; // Boolean to see if player is standing on a button
  Boolean sound = true;// Boolean to toggle playing a sound
  /*
   * 7 argument constructor for the Tile class
   * @param float x
   * @param float y
   * @param float h
   * @param String type
   * @param String colour
   * @param PImage tile
   */
  Tile(float x, float y, float w, float h, String type, String colour, PImage tile) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.type = type;
    this.colour = colour;
    this.tile = tile;

    //for the one way tiles, translates the color code to direction.
    if (type == "oneWay") {
      switch(colour) {

      case "FFFF0000": 
        direction = "north";
        break;
      case "FF00FF21": 
        direction = "east";
        break;        
      case "FF0026FF": 
        direction = "south";
        break;        
      case "FFFFFFFF": 
        direction= "west";
        break;
      }
    }
  }


  /*
 * Method to check the tiles
   * @return void
   */
  void tileCheck() {

    //Checks if the player is standing on this tile.
    if ( (x + h > p.x && p.x > x) && (y + h > p.y && p.y > y)) {
      //checking if the current tile we are standing on is a button
      if ( type == "button") {
        //checking if we were already standing on a button
        if (buttonStandingOn == false) {  
          //looping thru the tiles
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
      } else if (type == "finish") {//code for finish + next level
        String map = str(int(random(1, mapcount + 1)));

        //playing the finish sound
        finishSound.play();

        //updating the map to the next level
        updateMap("data/levels/level" + map + ".png", "data/levels/level" + map + "overlay.png") ;


        buttonStandingOn = false;
      } else if (type == "windtile") {
        p.y += 10;
      }
    } else { 
      buttonStandingOn = false;
    }
  }

  /*
   * Method to draw the tiles
   * @return void
   */
  void draw() {
    //checking if the tile type is a door/(open) or a button
    if (type == "door" || type == "doorOpen" || type == "button") {

      //drawing the tile image
      image(walkTile, x, y);

      //Updates the button pressed 
      if (type == "button") {
        if (buttonStandingOn) {
          if (sound == true) {
            buttonSound.play();
            sound = false;
          }
          tile = buttonPressed;
        } else { 
          tile = buttonTile;
          sound = true;
        }
      }

      tint(unhex(colour));
      image(tile, x, y);
    }
    //for the oneWay tiles, it rotates the images to the right side.
    /* else if (type == "oneWay") {
     float rotation = 0;
     float rotX = x;
     float rotY = y;
     switch(direction) {
     
     case "east": 
     rotation = 0.5*PI;
     rotX += w;
     
     break;        
     case "south": 
     rotation = PI;
     rotX += w;
     rotY += h;
     break;        
     case "west": 
     rotation = 1.5*PI;
     rotY += h;
     break;
     }
     rotate(rotation);
     image(tile, rotX, rotY);
     rotate(-rotation);
     }*/
    else {
      noTint();
      image(tile, x, y);
    }
  }
}
