class MovingEnemy extends MainEnemy {

  String direction = "north"; // setting the moving enemy's moving direction
  int speed = 3; // setting the moving enemy's moving speed

  /*
   * Constructor for the MovingEnemy class
   * @param Integer xspeed
   * @param Integer yspeed
   * @param Integer circleX
   * @param Integer circleY
   * @param Boolean isEnabled
   * @param Integer level
   */
  MovingEnemy(int xspeed_, int yspeed_) {
    this.xspeed = xspeed_;
    this.yspeed = yspeed_;
  }
  
  void placeMovingEnemy(float xPos_, float yPos_){
    circleX = xPos_;
    circleY = yPos_;
    isEnabled = true;
  }
  

  /*
   * Method to draw the moving enemy
   * @return void
   */
  void draw() {
    //updating the moving enemy
    update();

    //inherits everything inside the draw of all enemy classes

    super.draw();
  }

  /*
   * Method to update the moving enemy
   * @return void
   */
  void update() {
    //assigns the tile where the enemy is standing on to a variabele.
    Tile tileStanding = TileEnemy(0, 0);

    //Checks if the enemy is standing in the middle of a tile.
    if ((direction == "north" && tileStanding.y + 0.5 * tileStanding.h  >= circleY) || (direction == "south" && tileStanding.y + 0.5 * tileStanding.w  <= circleY) ||
      (direction == "west" && tileStanding.x + 0.5 * tileStanding.w >= circleX) || (direction == "east" && tileStanding.x + 0.5 * tileStanding.w <= circleX) ) {
      //if the enemy is standing on a tile it checks the tiles around him to see which way he has to go.
      pathcheck(tileStanding);
    }
    circleX = circleX + xspeed;
    circleY = circleY + yspeed;
  }


  /*
   * Method to check the path for the enemy
   * @return void
   */
  void pathcheck(Tile tileStanding) {

    Tile frontTile = null;
    Tile leftTile = null;
    Tile rightTile = null;
    Tile backTile = null;

    //Checks which tiles are around this enemy
    switch(direction) {
    case "north":

      frontTile = TileEnemy(0, -1);
      leftTile = TileEnemy(-1, 0);
      rightTile = TileEnemy(1, 0);
      backTile = TileEnemy(0, 1);

      break;
    case "south":
      frontTile = TileEnemy(0, 1);
      leftTile = TileEnemy(1, 0);
      rightTile = TileEnemy(-1, 0);
      backTile = TileEnemy(0, -1);
      break;

    case "east" :
      frontTile = TileEnemy(1, 0);
      leftTile = TileEnemy(0, -1);
      rightTile = TileEnemy(0, 1);
      backTile = TileEnemy(-1, 0);
      break;

    case "west" :
      frontTile = TileEnemy(-1, 0);
      leftTile = TileEnemy(0, 1);
      rightTile = TileEnemy(0, -1);
      backTile = TileEnemy(1, 0);
      break;
    }
    if ((frontTile.type.equals("enemywalkable") || frontTile.type.equals("doorOpen") 
    || frontTile.type.equals("enemyOneWay")||(frontTile.type.equals("oneWay")&&frontTile.direction.equals(direction))) == false) {
      circleX = int(tileStanding.x + 0.5*tileStanding.w);
      circleY = int(tileStanding.y + 0.5*tileStanding.w);
      if ((rightTile.type.equals("enemywalkable") && !leftTile.type.equals("doorOpen")) || rightTile.type.equals("doorOpen")) {

        switch(direction) {
        case "north":
          xspeed = speed;
          yspeed = 0;
          direction = "east";
          break;

        case "east":
          xspeed = 0;
          yspeed = speed;
          direction = "south";
          break;

        case "south":
          xspeed = -speed;
          yspeed = 0;
          direction = "west";
          break;

        case "west":
          xspeed = 0;
          yspeed = -speed;
          direction = "north";
          break;
        }
      } else if (leftTile.type.equals("enemywalkable") || leftTile.type.equals("doorOpen")) {
        switch(direction) {

        case "south":
          xspeed = speed;
          yspeed = 0;
          direction = "east";
          break;

        case "west":
          xspeed = 0;
          yspeed = speed;
          direction = "south";
          break;

        case "north":
          xspeed = -speed;
          yspeed = 0;
          direction = "west";
          break;

        case "east":
          xspeed = 0;
          yspeed = -speed;
          direction = "north";
          break;
        }
      } else { 
        switch(direction) {
        case "north":
          xspeed = 0;
          yspeed = speed;
          direction = "south";
          break;

        case "east":
          xspeed = -speed;
          yspeed = 0;
          direction = "west";
          break;

        case "south":
          xspeed = 0;
          yspeed = -speed;
          direction = "north";
          break;

        case "west":
          xspeed = speed;
          yspeed = 0;
          direction = "east";
          break;
        }
      }
    }
  }
}
