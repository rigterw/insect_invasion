class CollisionManager {

  boolean isWall;
  String direction = "0";


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
          tile.type == "finish" ||
          tile.type == "enemywalkable" ||
          tile.type == "enemyOneWay") {
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
          float distance = sqrt(distX*distX) + sqrt(distY*distY);

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
  int cooldownTimer = 1000; // Cooldown van 1000 ms
  boolean isEnabled = true;
  void CheckCollisionToEnemy() {
    if (isEnabled == true) {
      if (dist(p.x, p.y, enemymove.circleX, enemymove.circleY) < p.w / 2 + enemymove.diameter / 2) { // Check afstand tussen player en enemy
        nowHit = millis();
        if (nowHit > (lastHit + cooldownTimer)) {
          if (healthbar.health > 0) { // Als je meer als 0 hp hebt verlies je 1 hp
            //println("hit");
            healthbar.health -= 1;
            lastHit = nowHit;
          }
        }
      }
    }
  }
  int nowHit2;
  int lastHit2;
  int cooldownTimer2 = 1000; // Cooldown van 1000 ms
  boolean isEnabled2 = false;
  /* void CheckCollisionToEnemy2() {
   if (isEnabled2 == true) {
   if (dist(p.x, p.y, enemymove2.circleX, enemymove2.circleY) < p.w / 2 + enemymove2.diameter / 2) { // Check afstand tussen player en enemy2
   nowHit2 = millis();
   if (nowHit2 > (lastHit2 + cooldownTimer2)) {
   if (healthbar.health > 0) { // Als je meer als 0 hp hebt verlies je 1 hp
   //println("hit");
   healthbar.health -= 1;
   lastHit2 = nowHit2;
   }
   }
   }
   }
   }
   */
  void CheckCollisionToFinish() {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        tile = tiles[i][j];

        if (tile.type == "finish" && 
          (tile.x + tile.h > p.x && p.x > tile.x) && 
          (tile.y + tile.h > p.y && p.y > tile.y)) {
          // go to next level
          enemystatic.isEnabled = false;//disable static enemy for level 2
          enemymove.isEnabled = false;
          //    enemymove2.isEnabled = true;//enable moving enemy for level 2
          isEnabled = false; //disable collision with enemy
          isEnabled2 = true; //enable collision with enemy2
        }
      }
    }
  }

  /* void EnemyToWall(MainEnemy enemy) {
   for (int i = 0; i < cols; i++) {
   for (int j = 0; j < rows; j++) {
   tile = tiles[i][j];
   
   float enemyHBX, enemyHBY; //spelers randen
   enemyHBX = enemy.circleX;
   enemyHBY = enemy.circleY;
   
   
   if (tile.type == "door") {
   
   if (enemy.circleX < tile.x) {  // linker kant van de tile
   enemyHBX = tile.x;
   direction = "left";
   } else if (enemy.circleX > tile.x+tile.w) { // rechter kant van de tile
   enemyHBX = tile.x+tile.w;
   direction = "right";
   }
   
   if (enemy.circleY < tile.y) { // boven kant van de tile
   enemyHBY = tile.y;
   direction = "up";
   } else if (enemy.circleY > tile.y+tile.h) { // // onder kant van de tile
   enemyHBY = tile.y+tile.h;
   direction = "down";
   }
   
   //kijken welke rand het dichtsbijzijnde is
   float distX = enemy.circleX-enemyHBX;
   float distY = enemy.circleY-enemyHBY;
   float distance = sqrt(distX*distX) + sqrt(distY*distY);
   
   if (distance <= 32 / 2) {
   switch (direction) {
   
   case "left" :
   enemy.circleX = enemy.circleX - 6;
   enemy.yspeed =  -3;
   enemy.xspeed = 0;
   break;
   case "right" :
   enemy.yspeed = +3;
   enemy.xspeed = 0;
   break;
   case "up":
   enemy.yspeed = - enemy.yspeed;
   break;
   case "down":
   enemy.xspeed = 3;
   enemy.circleY = enemy.circleY + 6;
   enemy.yspeed = 0;
   break;
   }
   }
   }
   }
   }
   }*/
}
