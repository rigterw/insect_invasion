class MainEnemy {
  int enemyX; //Enemy x position
  int enemyY; //Enemy y position
  int enemyvx; //Enemy x velocity
  int enemyvy; // Enemy y velocity
  int enemyDiameter; // Enemy's diameter
  int level; // Current level
  boolean isEnabled = true; //Boolean to disable the enemy

  /*
   * Constructor for the MainEnemy class
   */
  MainEnemy() {
    enemyvx = 0;//starting speed in x direction
    enemyvy = 0;//starting speed in y direction
    enemyX = 0; //start position x enemy
    enemyY = 0; //start position y enemy
    enemyDiameter = 32; //setting the diameter
    level = 1; // setting the level
  }


  //creator comment this please
  Tile TileEnemy(int xVerschuiving, int yVerschuiving) {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        tile = tiles[i][j];

        if (tile.x + tile.h >=  enemyX && enemyX >= tile.x
          && tile.y + tile.h >=  enemyY && enemyY >= tile.y)
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
      image(enemy, enemyX - (enemyDiameter / 2), enemyY - (enemyDiameter / 2), enemyDiameter, enemyDiameter);
    }
  }
}
