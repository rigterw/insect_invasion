class MainEnemy {
  int circleX, circleY, xspeed, yspeed, diameter;

  MainEnemy() {
    diameter = 32;
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
    //noStroke(); //enemy vision circle
    //fill(0);
    ////noFill();
    //ellipse(circleX, circleY, 120, 120);

    fill(255, 0, 0); //enemy
    ellipse(circleX, circleY, diameter, diameter);
  }
}
