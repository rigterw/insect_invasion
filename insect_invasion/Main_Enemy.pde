class MainEnemy {
  int circleX; //Enemy x maybe change to enemyX? 
  int circleY; //Enemy Y maybe change to enemyY?
  int xspeed; //Enemy x speed
  int yspeed; // Enemy y speed
  int diameter; // Enemy's diameter
  int level; // Current level
  boolean isEnabled = true; //Boolean to disable the enemy

  /*
   * Constructor for the MainEnemy class
   */
  MainEnemy() {
    xspeed = 0;//starting speed in x direction
    yspeed = 0;//starting speed in y direction
    circleX = 0; //start position x enemy
    circleY = 0; //start position y enemy
    diameter = 32; //setting the diameter
    level = 1; // setting the level
  }


  //creator comment this please
  Tile TileEnemy(int xVerschuiving, int yVerschuiving) {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        tile = tiles[i][j];

        if (tile.x + tile.h >=  circleX && circleX >= tile.x
          && tile.y + tile.h >=  circleY && circleY >= tile.y)
        {
          return tile = tiles[i + xVerschuiving][j + yVerschuiving];
        }
      }
    }
    return null;
  }

  /*
   * Method to draw the enemy
   * @return void
   */
  void draw() {
    //checking if the enemy is enabled
    if (isEnabled == true) {
      //drawing the enemy
      fill(255, 0, 0); //enemy
      image(enemy, circleX - (diameter / 2), circleY - (diameter / 2), diameter, diameter);
    }
  }
}
