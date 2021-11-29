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
  MovingEnemy(int enemyvx, int enemyvy, int enemyX, int enemyY, boolean isEnabled, int level) {
    this.enemyvx = enemyvx;
    this.enemyvy = enemyvy;
    this.enemyX = enemyX;
    this.enemyY = enemyY;
    this.isEnabled = isEnabled;
    this.level = level;
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

<<<<<<< HEAD
    //creator comment this please
    if ((direction == "north" && tileStanding.y + 0.5 * tileStanding.h  >= enemyY) || (direction == "south" && tileStanding.y + 0.5 * tileStanding.w  <= enemyY) ||
      (direction == "west" && tileStanding.x + 0.5 * tileStanding.w >= enemyX) || (direction == "east" && tileStanding.x + 0.5 * tileStanding.w <= enemyX) ) {
      //creator comment this please
      //doet iedere keer wanneer de enemy in het midden van een tile staat een check 
=======
    //Checks if the enemy is standing in the middle of a tile.
    if ((direction == "north" && tileStanding.y + 0.5 * tileStanding.h  >= circleY) || (direction == "south" && tileStanding.y + 0.5 * tileStanding.w  <= circleY) ||
      (direction == "west" && tileStanding.x + 0.5 * tileStanding.w >= circleX) || (direction == "east" && tileStanding.x + 0.5 * tileStanding.w <= circleX) ) {
      //if the enemy is standing on a tile it checks the tiles around him to see which way he has to go.
>>>>>>> cf3a32ce93903ad381a3a1f2e61f02642d4e0706
      pathcheck(tileStanding);
    }
    enemyX = enemyX + enemyvx;
    enemyY = enemyY + enemyvy;
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
    if ((frontTile.type.equals("enemywalkable") || frontTile.type.equals("doorOpen") || frontTile.type.equals("enemyOneWay")) == false) {
      enemyX = int(tileStanding.x + 0.5*tileStanding.w);
      enemyY = int(tileStanding.y + 0.5*tileStanding.w);
      if ((rightTile.type.equals("enemywalkable") && !leftTile.type.equals("doorOpen")) || rightTile.type.equals("doorOpen")) {

        switch(direction) {
        case "north":
          enemyvx = speed;
          enemyvy = 0;
          direction = "east";
          break;

        case "east":
          enemyvx = 0;
          enemyvy = speed;
          direction = "south";
          break;

        case "south":
          enemyvx = -speed;
          enemyvy = 0;
          direction = "west";
          break;

        case "west":
          enemyvx = 0;
          enemyvy = -speed;
          direction = "north";
          break;
        }
      } else if (leftTile.type.equals("enemywalkable") || leftTile.type.equals("doorOpen")) {
        switch(direction) {

        case "south":
          enemyvx = speed;
          enemyvy = 0;
          direction = "east";
          break;

        case "west":
          enemyvx = 0;
          enemyvy = speed;
          direction = "south";
          break;

        case "north":
          enemyvx = -speed;
          enemyvy = 0;
          direction = "west";
          break;

        case "east":
          enemyvx = 0;
          enemyvy = -speed;
          direction = "north";
          break;
        }
      } else { 
        switch(direction) {
        case "north":
          enemyvx = 0;
          enemyvy = speed;
          direction = "south";
          break;

        case "east":
          enemyvx = -speed;
          enemyvy = 0;
          direction = "west";
          break;

        case "south":
          enemyvx = 0;
          enemyvy = -speed;
          direction = "north";
          break;

        case "west":
          enemyvx = speed;
          enemyvy = 0;
          direction = "east";
          break;
        }
      }
    }
  }
}
