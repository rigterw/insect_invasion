class MovingEnemy extends MainEnemy {

  String direction = "north";
  int speed = 3;

  MovingEnemy(int xspeed, int yspeed, int circleX, int circleY, boolean isEnabled, int level) {
    this.xspeed = xspeed;
    this.yspeed = yspeed;
    this.circleX = circleX;
    this.circleY = circleY;
    this.isEnabled = isEnabled;
    this.level = level;
  }

  void draw() {
    update();
    super.draw();//inherits everything inside the draw of all enemy classes
  }

  void update() {
    Tile tileStanding = TileEnemy(0, 0);

    if ((direction == "north" && tileStanding.y + 0.5 * tileStanding.h  >= circleY) || (direction == "south" && tileStanding.y + 0.5 * tileStanding.w  <= circleY) ||
      (direction == "west" && tileStanding.x + 0.5 * tileStanding.w >= circleX) || (direction == "east" && tileStanding.x + 0.5 * tileStanding.w <= circleX) ) {
        //doet iedere keer wanneer de enemy in het midden van een tile staat een check 
      pathcheck(tileStanding);
    }
    circleX = circleX + xspeed;
    circleY = circleY + yspeed;
  }
  

  void pathcheck(Tile tileStanding) {// checkt of hij vooruit kan blijven lopen

    Tile frontTile = null;
    Tile leftTile = null;
    Tile rightTile = null;
    Tile backTile = null;

    switch(direction) {//stelt vast welke tiles er om de enemy heen liggen.
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
        switch(direction){
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
          break;}
      }
    }
  }
}
