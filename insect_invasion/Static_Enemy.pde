class StaticEnemy extends MainEnemy {
  String direction = null;
  /*
   * 2 argument constructor from the StaticEnemy class
   * @param Integer circleX
   * @param Integer circleY
   */
  //StaticEnemy(int circleX_, int circleY_) {
  //  this.circleX = circleX_;
  //  this.circleY = circleY_;
  //}


  void placeStaticEnemy(float xPos_, float yPos_) {

    enemyX = xPos_;
    enemyY = yPos_;
    isEnabled = true;
    direction = "north";

    if (TileEnemy(0, 1).type.equals("enemywalkable") || TileEnemy(0, 1).type.equals("door") || TileEnemy(0, 1).type.equals("doorOpen")) {
      direction = "south";
    }    
    if (TileEnemy(0, -1).type.equals("enemywalkable") || TileEnemy(0, -1).type.equals("door") || TileEnemy(0, -1).type.equals("doorOpen")) {
      direction = "north";
    }    
    if (TileEnemy(-1, 0).type.equals("enemywalkable") || TileEnemy(-1, 0).type.equals("door") || TileEnemy(-1, 0).type.equals("doorOpen")) {
      direction = "west";
    }    
    if (TileEnemy(1, 0).type.equals("enemywalkable") || TileEnemy(1, 0).type.equals("door") || TileEnemy(1, 0).type.equals("doorOpen")) {
      direction = "east";
    }
  }

  /*
   * Method to draw the static enemy
   * @return void
   */


  void draw() {
    //Draws a vision circle on top of the enemy
    //noFill();
    noStroke();
    ellipseMode(CENTER);

    float visionW = 0;
    float visionH = 0;
    float visionRadius =  visionW/2;
    float PlayerToEnemy = dist(enemyX, enemyY, p.x, p.y);

    switch (direction) {

    case "south":
      visionW = 0;
      visionH = 250;
      break;

    case "east":
      visionW = 250;
      visionH = 0;
      break;

    case "north":
      visionW = 0;
      visionH = -250;
      break;

    case "west":
      visionW = -250;
      visionH = 0;
      break;
    }

    ellipse(enemyX, enemyY, visionW, visionH);

    //checks if the player is in range 
    //switch makes enemy move towards player direction
    if (PlayerToEnemy <= p.radius + visionRadius) {
      if (!TileEnemy(0, 0).type.equals("door")) {

        switch (direction) {

        case "south": 
          enemyY += speed; 
          break;

        case "east":
          enemyX += speed;
          break;

        case "north":
          enemyY -= speed;
          break;

        case "west":
          enemyX -= speed;
          break;
        }
      }
    }

    super.draw();//inherits everything inside the draw of all enemy classes
  }
}
