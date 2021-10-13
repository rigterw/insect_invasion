class CollisionManager {

  boolean isWall;
  String direction;


  void CheckCollisionToWall() {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        tile = tiles[i][j];

        float playerHBX, playerHBY; //spelers randen
        playerHBX = p.x;
        playerHBY = p.y;
        if (
          tile.type == "walkable" ||
          tile.type == "doorOpen" ||
          tile.type == "button" ||
          tile.type == "finish") {
          isWall = false;
        } else {
          isWall = true;
        }


        if (isWall) {

          if (p.x < tile.x) {  // linker kant van de tile
            playerHBX = tile.x;
            direction = "left";
          } else if (p.x > tile.x+tile.w) { // rechter kant van de tile
            playerHBX = tile.x+tile.w;
            direction = "right";
          }

          if (p.y < tile.y) { // boven kant van de tile
            playerHBY = tile.y;
            direction = "up";
          } else if (p.y > tile.y+tile.h) { // // onder kant van de tile
            playerHBY = tile.y+tile.h;
            direction = "down";
          }

          //kijken welke rand het dichtsbijzijnde is
          float distX = p.x-playerHBX;
          float distY = p.y-playerHBY;
          float distance = sqrt(distX*distX) + (distY*distY);

          if (distance <= p.w / 2) {
            switch (direction) {

            case "left" :
              p.x = p.x - p.maxSpeed;
              break;
            case "right" :
              p.x = p.x + p.maxSpeed;
              break;
            case "up":
              p.y = p.y - p.maxSpeed;
              break;
            case "down":
              p.y = p.y + p.maxSpeed;
              break;
            }
          }
        }
      }
    }
  }

  void CheckCollisionToEnemy() {
    if (dist(p.x, p.y, enemy.circleX, enemy.circleY) < p.w / 2 + 16) {
      println("hit");
    }
  }
}
