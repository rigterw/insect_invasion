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
  int nowHit;
  int lastHit;
  int cooldownTimer = 1000;

  void CheckCollisionToEnemy() {
    if (dist(p.x, p.y, enemymove.circleX, enemymove.circleY) < p.w / 2 + enemymove.diameter / 2) {
      nowHit = millis();
      if (nowHit > (lastHit + cooldownTimer)) {
        if (healthbar.health > 0) {
          //println("hit");
          healthbar.health -= 1;
          lastHit = nowHit;
        }
      }
    }
  }
  void CheckCollisionToFinish() {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        tile = tiles[i][j];

        if (tile.type == "finish" && 
          (tile.x + tile.h > p.x && p.x > tile.x) && 
          (tile.y + tile.h > p.y && p.y > tile.y)) {
          // go to next level
          println("finish has been hit");
        }
      }
    }
  }

  void EnemyToWall() {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        tile = tiles[i][j];

        float enemyHBX, enemyHBY; //spelers randen
        enemyHBX = enemymove.circleX;
        enemyHBY = enemymove.circleY;


        if (tile.type == "door") {

          if (enemymove.circleX < tile.x) {  // linker kant van de tile
            enemyHBX = tile.x;
            direction = "left";
          } else if (enemymove.circleX > tile.x+tile.w) { // rechter kant van de tile
            enemyHBX = tile.x+tile.w;
            direction = "right";
          }

          if (enemymove.circleY < tile.y) { // boven kant van de tile
            enemyHBY = tile.y;
            direction = "up";
          } else if (enemymove.circleY > tile.y+tile.h) { // // onder kant van de tile
            enemyHBY = tile.y+tile.h;
            direction = "down";
          }

          //kijken welke rand het dichtsbijzijnde is
          float distX = enemymove.circleX-enemyHBX;
          float distY = enemymove.circleY-enemyHBY;
          float distance = sqrt(distX*distX) + (distY*distY);

          if (distance <= 32 / 2) {
            switch (direction) {

            case "left" :
              enemymove.xspeed =  -enemymove.xspeed;
              break;
            case "right" :
              enemymove.xspeed = -enemymove.xspeed;
              break;
            case "up":
              enemymove.yspeed = - enemymove.yspeed;
              break;
            case "down":
              enemymove.yspeed = - enemymove.yspeed;
              break;
            }
          }
        }
      }
    }
  }
}
