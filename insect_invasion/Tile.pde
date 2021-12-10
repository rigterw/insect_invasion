class Tile 
{
  int count; //The amount of tiles
  float x, y; //X en y position
  float w, h; //Tile width and height
  String type; //Tile type
  String colour; //Tile colour
  String direction, windDirection;
  PImage tile; // Tile image
  Boolean buttonStandingOn = false;
  Boolean canWind, hasWind = false; // Boolean to see if player is standing on a button
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
  Tile(float x, float y, float w, float h, String type, String colour, PImage tile, Boolean wind) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.type = type;
    this.colour = colour;
    this.tile = tile;
    canWind = wind;

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
                  tiles[xTile][yTile].canWind = true;
                  tiles[xTile][yTile].tile = doorOpenTile;
                } else if (tiles[xTile][yTile].type == "doorOpen") {

                  tiles[xTile][yTile].type = "door"; 
                  tiles[xTile][yTile].canWind = false;
                  tiles[xTile][yTile].tile = doorTile;
                }
              }
            }
          }
          updateWind();
        }
        buttonStandingOn = true;
      } else if (type == "finish") {//code for finish + next level
        int nextMap = int(random(1, mapcount + 1));
        while (nextMap == currentMap) {
          nextMap = int(random(1, mapcount + 1));
        }
        currentMap = nextMap;
        //playing the finish sound
        finishSound.play();
        p.score += int(timer.time / 1000);
        timer.time = timer.maxTime;

        //updating the map to the next level
        updateMap("data/levels/level" + str(currentMap) + ".png", "data/levels/level" + str(currentMap) + "overlay.png") ;


        buttonStandingOn = false;
      }
      if (hasWind) {
        switch(windDirection) {
        case "north":
          p.y -= windSpeed;
          break;     
        case "east":
          p.x += windSpeed;
          break;     
        case "south":
          p.y += windSpeed; 
          break;
        case "west":
          p.x -= windSpeed;   
          break;
        }
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
    image(walkTile, x, y);
    //checking if the tile type is a door/(open) or a button
    if (type == "door" || type == "doorOpen" || type == "button") {

      //drawing the tile image


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
    else if (type == "oneWay") {

      switch(direction) {

      case "east": 
        tile = oneWayEast;
        break;        
      case "south": 
        tile = oneWaySouth;
        break;        
      case "west": 
        tile = oneWayWest;
        break;
      case "north":
        tile = oneWayNorth;
      }
      image(tile, x, y);
    } else {
      noTint();
      image(tile, x, y);
    }
    if (hasWind) {
      image(windTile, x, y);
    }
  }


  //assings itself wind and activates the next tile
  void spreadWind(int x, int y, String direction) {
    if (canWind) {
      if (type == "door") {
        println("deurtje"); 
        println(canWind, "wind"); 
        println();
      }
      hasWind = true;
      windDirection = direction;
      switch (direction) {     
      case "north":
        tiles[x][y-1].spreadWind(x, y-1, direction);
        break;     
      case "east":
        tiles[x+1][y].spreadWind(x+1, y, direction);
        break;     
      case "south":
        tiles[x][y+1].spreadWind(x, y+1, direction); 
        break;
      case "west":
        tiles[x-1][y].spreadWind(x-1, y, direction);    
        break;
      }
    }
  }


  //for the wind tiles, initiates the spawn of wind
  void spawnWind(int x, int y) {
    if (tiles[x][y-1].canWind) {
      direction = "north";
      tiles[x][y-1].spreadWind(x, y-1, direction);
    } else if (tiles[x+1][y].canWind) {
      direction = "east";
      tiles[x+1][y].spreadWind(x+1, y, direction);
    } else if (tiles[x][y+1].canWind) {
      direction = "south";
      tiles[x][y+1].spreadWind(x, y+1, direction);
    } else if (tiles[x-1][y].canWind) {
      direction = "west";
      tiles[x-1][y].spreadWind(x-1, y, direction);
    }
  }
}
