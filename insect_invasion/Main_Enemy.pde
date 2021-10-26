class MainEnemy {
  int circleX, circleY, xspeed, yspeed, diameter, level;
  boolean isEnabled = true;
  
  MainEnemy() {
    xspeed = 0;//starting speed in x direction
    yspeed = 0;//starting speed in y direction
    circleX = 0; //start position x enemy
    circleY = 0; //start position y enemy
    diameter = 32;
    level = 1;
  }


  Tile TileEnemy() {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        tile = tiles[i][j];

        if (tile.x + tile.h >  circleX && circleX > tile.x
          && tile.y + tile.h >  circleY && circleY > tile.y)
        {
          return tile;
        }
      }
    }
    return null;
  }

  void draw() {
    if (isEnabled == true) {
      //noStroke(); //enemy vision circle
      //fill(0);
      ////noFill();
      //ellipse(circleX, circleY, 120, 120);

      fill(255, 0, 0); //enemy
      ellipse(circleX, circleY, diameter, diameter);
    }
  }
}
