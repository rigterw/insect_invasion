class MainEnemy {
  float enemyX; //Enemy x
  float enemyY; //Enemy Y
  int enemyvx; //Enemy x velocity
  int enemyvy; // Enemy y velocity
  int enemyDiameter; // Enemy's diameter
  int level; // Current level
  boolean isEnabled = false; //Boolean to disable the enemy

  /*
   * Constructor for the MainEnemy class
   */
  MainEnemy() {
    enemyvx = 0;//starting speed in x direction
    enemyvy = 0;//starting speed in y direction
    enemyX = 100; //start position x enemy
    enemyY = 100; //start position y enemy
    enemyDiameter = 32; //setting the diameter
    level = 1; // setting the level
    
  }


  //returns the tile where the enemy is standing on
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

  void display(){
    if (isEnabled == true) { 
     update(); 
     draw();
    }
  }

  void update() {
   //Collision with player. 
  }
  
  /*
   * Method to draw the enemy
   * @return void
   */
  void draw() {
      //drawing the enemy
      fill(255, 0, 0); //enemy
      image(enemy, enemyX - (enemyDiameter / 2), enemyY - (enemyDiameter / 2), enemyDiameter, enemyDiameter);
    
  }
}
