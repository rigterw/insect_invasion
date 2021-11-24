class CollisionManager {

  boolean isWall; // Boolean to check if the tile is a wall
  String direction = "0"; // String to set the direction

  int nowHit; // creator comment this please
  int lastHit; // creator comment this please
  int cooldownTimer = 1000; // 1000ms cooldown on ?? creator comment this please
  boolean isEnabled = true; // creator comment this please

  int nowHit2; // creator comment this please
  int lastHit2; // creator comment this please
  int cooldownTimer2 = 1000; // 1000ms cooldown on ?? creator comment this please
  boolean isEnabled2 = false; // creator comment this please


  /*
   * Method to check the collision between the player and a wall
   * @return void
   */
  void CheckCollisionToWall() {
    //looping thru all the tiles
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        //getting the tile
        tile = tiles[i][j];

        float playerHBX, playerHBY; //Players borders
        playerHBX = p.x;
        playerHBY = p.y;

        //checking the tiletype
        if (
          tile.type == "walkable" ||
          tile.type == "doorOpen" ||
          tile.type == "button" ||
          tile.type == "finish" ||
          tile.type == "enemywalkable" ||
          tile.type == "enemyOneWay") {

          //setting the isWall variable
          isWall = false;
        } else {

          //setting the isWall variable
          isWall = true;
        }

        //checking if the current tile is a wall
        if (isWall) {

          //checking the left side of the tile
          if (p.x < tile.x) {
            playerHBX = tile.x;
            direction = "left";
          } 
          //checking the right side of the tile
          else if (p.x > tile.x+tile.w) { 
            playerHBX = tile.x+tile.w;
            direction = "right";
          }

          //checking the top side of the tile
          if (p.y < tile.y) {
            playerHBY = tile.y;
            direction = "up";
          }
          //checking the bottom side of the tile
          else if (p.y > tile.y+tile.h) {
            playerHBY = tile.y+tile.h;
            direction = "down";
          }


          //checking what side is the closed side
          float distX = p.x-playerHBX;
          float distY = p.y-playerHBY;
          float distance = sqrt(distX*distX) + sqrt(distY*distY);

          if (distance <= p.w / 2) {
            //looping thru the directions and setting the players position
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

  /*
  * Method to check the collision between player and enemy
   * @return void
   */
  void CheckCollisionToEnemy() {
    //checking if the enemy is enabled
    if (isEnabled == true) {
      //checking distance between player and enemy
      if (dist(p.x, p.y, enemymove.enemyX, enemymove.enemyY) < p.w / 2 + enemymove.enemyDiameter / 2) {
        //Setting the hit time so the cooldown gets started
        nowHit = millis();
        //checking if the hit is within the cooldown
        if (nowHit > (lastHit + cooldownTimer)) {
          println("hit");
          lastHit = nowHit;
        }
      }
    }
  }

  /*
   * Method to check the collision between player and finish
   * @return void
   */
  void CheckCollisionToFinish() {
    //looping thru the tiles
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        //seting the current tile
        tile = tiles[i][j];

        //check if the tile type is finish
        if (tile.type == "finish" && 
          (tile.x + tile.h > p.x && p.x > tile.x) && 
          (tile.y + tile.h > p.y && p.y > tile.y)) {
          // go to next level
          enemystatic.isEnabled = false;//disable static enemy for level 2
          enemymove.isEnabled = false;
          isEnabled = false; //disable collision with enemy
          isEnabled2 = true; //enable collision with enemy2
        }
      }
    }
  }
}
